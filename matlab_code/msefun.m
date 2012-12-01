% Problem Set 6 - Particle Tracking
% Name: 
% GT Username: 
% Section: <A vs. GR?>
%
%   msdfun - Mean Squared Difference function
%
function [ mse ] = msefun( M, t )
    % 
    diff = bsxfun(@minus, M, t);
    diff = diff.^2;
    diff = sum(diff);
    % Divide by m * n (the size of the tile)
    mse  = diff / size(t, 1);
end

