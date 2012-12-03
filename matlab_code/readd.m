% Problem Set 6 - Particle Tracking
% Name: Jesse Rosalia
% GT Username: jrosalia3
% Section: A
%
% readd - Helper method to read a frame of video in the correct format.
%
function [ frame ] = readd( video, frame_number )
    frame = double(read(video, frame_number));
    frame = frame / 255;

end

