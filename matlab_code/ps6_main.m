% Problem Set 6 - Particle Tracking
% Name: 
% GT Username: 
% Section: <A vs. GR?>

% Notes - This does not have to be where all your code is written.  You can
% use .m scripts and functions which are located in the SAME directory.
% DO NOT INCLUDE FOLDERS IN THE ZIP FILE!

close all;
clear;
global prob;
global subprob;

if (prob == 1 && subprob == '1') || prob == -1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  1.1  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

debate = VideoReader('../input_images/pres_debate.avi');

nFrames = debate.NumberOfFrames;
nFramesToTrack = 144;
vidHeight = debate.Height;
vidWidth = debate.Width;

% sigma = sqrt(10^2/255);
sigma = 1/255;
% Read the first frame
frame = readd(debate, 1);

% The range of the window to capture romney's head
window_range_x = 320:430;
window_range_y = 192:302;

track_patch = frame(window_range_y, window_range_x, :);
% Convert to grayscale, to use for tracking
frameG  = rgb2gray(frame);
windowG = frameG(window_range_y, window_range_x);

num_particles = 1000;

% Initial particle distribution...one in every position
% TODO: try particles within the window to find...might give better results
pf = ParticleFilter(vidWidth, vidHeight, num_particles);

video_writer = VideoWriter('../output_images/ps6-1-1.avi');
open(video_writer);

% m(:, :, :, 1) = frame;
% m = zeros(vidHeight, vidWidth, 3, nFramesToTrack);
nStart = 2;
for k = nStart:nFramesToTrack
    fprintf(1, '%d of %d frames\n', k, nFrames);
    % Predict (using random dynamics model)
    dynamics = rand(vidHeight, vidWidth);
    pf.elapseTime(@(pos) random_dynamics_model(dynamics, pos));
    
    % Correct
    frame = readd(debate, k);
    % Convert to grayscale, to use for tracking
    frameG = rgb2gray(frame);
    
    mse   = calc_mse(frameG, windowG, pf.candidates);
    Pz_x  = exp(-mse/(2 * sigma));
    Pz_x  = Pz_x / sum(Pz_x);
    pf.observe(Pz_x);
    
    im = visualize_tracker(video_writer, frame, size(windowG, 1), pf);
    
    m(:, :, :, k - (nStart - 1)) = im;

    if k == 28
        pf.center
        pf.spread
        track_viz_28 = im;
    end

    if k == 84
        pf.center
        pf.spread
        track_viz_84 = im;
    end
    
    if k == 144
        pf.center
        pf.spread
        track_viz_144 = im;
    end
end

close(video_writer);

fps = 30;
implay(m,fps)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f = figure(1)
imshow(track_patch)
saveas(f, '../output_images/ps6-1-1-fig1.jpg');
f = figure(2)
imshow(track_viz_28)
saveas(f, '../output_images/ps6-1-1-fig2.jpg');
f = figure(3)
imshow(track_viz_84)
saveas(f, '../output_images/ps6-1-1-fig3.jpg');
f = figure(4)
imshow(track_viz_144)
saveas(f, '../output_images/ps6-1-1-fig4.jpg');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end



if (prob == 1 && subprob == '5') || prob == -1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  1.5  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Your code

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(5)
imshow(noisy_viz_14)
figure(6)
imshow(noisy_viz_32)
figure(7)
imshow(noisy_viz_46)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end



if (prob == 2 && subprob == '1') || prob == -1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  2.1  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Your code

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(8)
imshow(appear_patch)
figure(9)
imshow(appear_viz_14)
figure(10)
imshow(appear_viz_32)
figure(11)
imshow(appear_viz_46)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end



if (prob == 2 && subprob == '2') || prob == -1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  2.2  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Your code

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(12)
imshow(appear_noisy_patch)
figure(13)
imshow(appear_noisy_viz_14)
figure(14)
imshow(appear_noisy_viz_32)
figure(15)
imshow(appear_noisy_viz_46)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end



if (prob == 3 && subprob == '1') || prob == -1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  3.1  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Your code

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(16)
imshow(dynamics_patch)
figure(17)
imshow(dynamics_viz_14)
figure(18)
imshow(dynamics_viz_32)
figure(19)
imshow(dynamics_viz_46)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end


