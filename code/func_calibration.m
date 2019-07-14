function [objective] = func_calibration(imagePoints, worldPoints, x)
% Objective function to minimize eq.10 in Zhang's paper. 
% Size of input variable x is 5+6*n where n is number of checkerboard 
% images. An intrinsic matrix can be reconstructed from first five
% parameters, and the extrinsic matrix can be reconstructed from remain
% parameters.

% You should fill the variable hat_m which contains reprojected positions 
% of checkerboard points in screen coordinate.

% Function inputs:
% - 'imagePoints': positions of checkerboard points in a screen space.
% - 'worldPoints': positions of checkerboard points in a model space.
% - 'x': parameters to be optimized.

% Function outputs:
% - 'objective': difference of estimated values and real values.
    
numView = size(imagePoints,3);
hat_m = zeros(size(imagePoints));

% ----- Your code here (9) -----
alpha = x(1,1);
beta = x(2,1);
gamma = x(3,1);
u0 = x(4,1);
v0 = x(5,1);
K = [alpha gamma u0; 0 beta v0; 0 0 1];

for nv=1:numView
    rotationVec = x(6*nv:6*nv+5-3,1).';
    R = rotationVectorToMatrix(rotationVec).';
    t = x(6*nv+5-2:6*nv+5,1);
    
    for i=1:size(imagePoints,1)
        tmp = K*[R(:,1),R(:,2),t]*[worldPoints(i,1);worldPoints(i,2);1];
        hat_m(i,:,nv) = tmp(1:2)/tmp(3);
    end
end

objective = imagePoints - hat_m;