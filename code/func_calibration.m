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


objective = imagePoints - hat_m;