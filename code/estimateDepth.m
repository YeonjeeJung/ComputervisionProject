function [depthMap, disparityMap] = estimateDepth(leftImage, rightImage, stereoParameters)
% This function estimate disparity and depth values from left and right
% images. You should calculate disparty map first and then convert the
% disparity map to depth map using left camera parameters.

% Function inputs:
% - 'leftImage': rectified left image.
% - 'rightImage': rectified right image.
% - 'stereoParameters': stereo camera parameters.

% Function outputs:
% - 'depth': depth map of left camera.
% - 'disparity': disparity map of left camera.

leftImageGray = rgb2gray(im2double(leftImage));
rightImageGray = rgb2gray(im2double(rightImage));

translation = stereoParameters.TranslationOfCamera2;
baseline = norm(translation);
focalLength = stereoParameters.CameraParameters1.FocalLength(1);

disparityMap = zeros(size(leftImageGray));
depthMap = zeros(size(leftImageGray));
% ----- Your code here (10) -----

windowSize = 11;
minDisparity = 51;
maxDisparity = 100;
costVolume = -ones(size(leftImageGray,1),size(leftImageGray,2),maxDisparity-minDisparity)*windowSize*windowSize;

for d=minDisparity:maxDisparity
    for y=1:size(leftImageGray,1)-windowSize
        for x=1+d:size(leftImageGray,2)-windowSize
            left = reshape(leftImageGray(y:y+windowSize-1,x:x+windowSize-1),windowSize*windowSize,1);
            right = reshape(rightImageGray(y:y+windowSize-1,x-d:x-d+windowSize-1),windowSize*windowSize,1);
            
            left = left-mean(left);
            right = right-mean(right);
            
            costVolume(y+(windowSize-1)/2,x+(windowSize-1)/2,d-minDisparity+1) = dot(left,right)/(sqrt(norm(left))*sqrt(norm(right)));
        end
    end
end

for d=minDisparity:maxDisparity
%     costVolume(:,:,d) = imguidedfilter(costVolume(:,:,d),leftImageGray);
    costVolume(:,:,d-minDisparity+1) = imgaussfilt(costVolume(:,:,d-minDisparity+1),5);
end

for y=1:size(leftImageGray,1)
    for x=1:size(rightImageGray,2)
        [maxval, maxidx] = max(costVolume(y,x,:));
        disparityMap(y,x) = maxidx+minDisparity-1;
    end
end

depthMap = (focalLength*baseline*ones(size(disparityMap)))./disparityMap;