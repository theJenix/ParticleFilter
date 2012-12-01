function [ frame ] = readd( video, frame_number )
    frame = double(read(video, frame_number));
    frame = frame / 255;

end

