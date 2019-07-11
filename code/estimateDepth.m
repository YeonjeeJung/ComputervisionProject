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