% Problem Set 6 - Particle Tracking
% Name: Jesse Rosalia
% GT Username: jrosalia3
% Section: A

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
sigma = 10/255;
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
    pf.elapseTime(@(pos) random_dynamics_model(dynamics, pos, 5));
    
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

if (prob == 1 && subprob == '2') || prob == -1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  1.2  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Large window
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

debate = VideoReader('../input_images/pres_debate.avi');

nFrames = debate.NumberOfFrames;
nFramesToTrack = 144;
vidHeight = debate.Height;
vidWidth = debate.Width;

% sigma = sqrt(10^2/255);
sigma = 10/255;
% Read the first frame
frame = readd(debate, 1);

% The range of the window to capture romney's head (211 x 211)
window_range_x = 270:480;
window_range_y = 142:352;

track_patch = frame(window_range_y, window_range_x, :);
% Convert to grayscale, to use for tracking
frameG  = rgb2gray(frame);
windowG = frameG(window_range_y, window_range_x);

num_particles = 1000;

% Initial particle distribution...one in every position
% TODO: try particles within the window to find...might give better results
pf = ParticleFilter(vidWidth, vidHeight, num_particles);

video_writer = VideoWriter('../output_images/ps6-1-2.avi');
open(video_writer);

% m(:, :, :, 1) = frame;
% m = zeros(vidHeight, vidWidth, 3, nFramesToTrack);
nStart = 2;
for k = nStart:nFramesToTrack
    fprintf(1, '%d of %d frames\n', k, nFrames);
    % Predict (using random dynamics model)
    dynamics = rand(vidHeight, vidWidth);
    pf.elapseTime(@(pos) random_dynamics_model(dynamics, pos, 5));
    
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
saveas(f, '../output_images/ps6-1-2-fig1-large.jpg');
f = figure(2)
imshow(track_viz_28)
saveas(f, '../output_images/ps6-1-2-fig2-large.jpg');
f = figure(3)
imshow(track_viz_84)
saveas(f, '../output_images/ps6-1-2-fig3-large.jpg');
f = figure(4)
imshow(track_viz_144)
saveas(f, '../output_images/ps6-1-2-fig4-large.jpg');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Smaller window
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
debate = VideoReader('../input_images/pres_debate.avi');

nFrames = debate.NumberOfFrames;
nFramesToTrack = 144;
vidHeight = debate.Height;
vidWidth = debate.Width;

% sigma = sqrt(10^2/255);
sigma = 10/255;
% Read the first frame
frame = readd(debate, 1);

% The range of the window to capture romney's head (51 x 51)
window_range_x = 345:405;
window_range_y = 217:277;

track_patch = frame(window_range_y, window_range_x, :);
% Convert to grayscale, to use for tracking
frameG  = rgb2gray(frame);
windowG = frameG(window_range_y, window_range_x);

num_particles = 1000;

% Initial particle distribution...one in every position
% TODO: try particles within the window to find...might give better results
pf = ParticleFilter(vidWidth, vidHeight, num_particles);

video_writer = VideoWriter('../output_images/ps6-1-2-small.avi');
open(video_writer);

% m(:, :, :, 1) = frame;
% m = zeros(vidHeight, vidWidth, 3, nFramesToTrack);
nStart = 2;
for k = nStart:nFramesToTrack
    fprintf(1, '%d of %d frames\n', k, nFrames);
    % Predict (using random dynamics model)
    dynamics = rand(vidHeight, vidWidth);
    pf.elapseTime(@(pos) random_dynamics_model(dynamics, pos, 5));
    
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
saveas(f, '../output_images/ps6-1-2-fig1-small.jpg');
f = figure(2)
imshow(track_viz_28)
saveas(f, '../output_images/ps6-1-2-fig2-small.jpg');
f = figure(3)
imshow(track_viz_84)
saveas(f, '../output_images/ps6-1-2-fig3-small.jpg');
f = figure(4)
imshow(track_viz_144)
saveas(f, '../output_images/ps6-1-2-fig4-small.jpg');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end

if (prob == 1 && subprob == '3') || prob == -1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  1.3  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Large Sigma
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
debate = VideoReader('../input_images/pres_debate.avi');

nFrames = debate.NumberOfFrames;
nFramesToTrack = 144;
vidHeight = debate.Height;
vidWidth = debate.Width;

% sigma = sqrt(10^2/255);
sigma = 100/255;
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

video_writer = VideoWriter('../output_images/ps6-1-3-large.avi');
open(video_writer);

% m(:, :, :, 1) = frame;
% m = zeros(vidHeight, vidWidth, 3, nFramesToTrack);
nStart = 2;
for k = nStart:nFramesToTrack
    fprintf(1, '%d of %d frames\n', k, nFrames);
    % Predict (using random dynamics model)
    dynamics = rand(vidHeight, vidWidth);
    pf.elapseTime(@(pos) random_dynamics_model(dynamics, pos, 5));
    
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
saveas(f, '../output_images/ps6-1-3-fig1.jpg');
f = figure(2)
imshow(track_viz_28)
saveas(f, '../output_images/ps6-1-3-fig2-large.jpg');
f = figure(3)
imshow(track_viz_84)
saveas(f, '../output_images/ps6-1-3-fig3-large.jpg');
f = figure(4)
imshow(track_viz_144)
saveas(f, '../output_images/ps6-1-3-fig4-large.jpg');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Small Sigma
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
debate = VideoReader('../input_images/pres_debate.avi');

nFrames = debate.NumberOfFrames;
nFramesToTrack = 144;
vidHeight = debate.Height;
vidWidth = debate.Width;

% sigma = sqrt(10^2/255);
sigma = 0.1/255;
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

video_writer = VideoWriter('../output_images/ps6-1-3-small.avi');
open(video_writer);

% m(:, :, :, 1) = frame;
% m = zeros(vidHeight, vidWidth, 3, nFramesToTrack);
nStart = 2;
for k = nStart:nFramesToTrack
    fprintf(1, '%d of %d frames\n', k, nFrames);
    % Predict (using random dynamics model)
    dynamics = rand(vidHeight, vidWidth);
    pf.elapseTime(@(pos) random_dynamics_model(dynamics, pos, 5));
    
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
f = figure(5)
imshow(track_viz_28)
saveas(f, '../output_images/ps6-1-3-fig2-small.jpg');
f = figure(6)
imshow(track_viz_84)
saveas(f, '../output_images/ps6-1-3-fig3-small.jpg');
f = figure(7)
imshow(track_viz_144)
saveas(f, '../output_images/ps6-1-3-fig4-small.jpg');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end

if (prob == 1 && subprob == '4') || prob == -1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  1.4  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

debate = VideoReader('../input_images/pres_debate.avi');

nFrames = debate.NumberOfFrames;
nFramesToTrack = 144;
vidHeight = debate.Height;
vidWidth = debate.Width;

% sigma = sqrt(10^2/255);
sigma = 10/255;
% Read the first frame
frame = readd(debate, 1);

% The range of the window to capture romney's head
window_range_x = 320:430;
window_range_y = 192:302;

track_patch = frame(window_range_y, window_range_x, :);
% Convert to grayscale, to use for tracking
frameG  = rgb2gray(frame);
windowG = frameG(window_range_y, window_range_x);

num_particles = 125;

% Initial particle distribution...one in every position
% TODO: try particles within the window to find...might give better results
pf = ParticleFilter(vidWidth, vidHeight, num_particles);

video_writer = VideoWriter('../output_images/ps6-1-4.avi');
open(video_writer);

% m(:, :, :, 1) = frame;
% m = zeros(vidHeight, vidWidth, 3, nFramesToTrack);
nStart = 2;
for k = nStart:nFramesToTrack
    fprintf(1, '%d of %d frames\n', k, nFrames);
    % Predict (using random dynamics model)
    dynamics = rand(vidHeight, vidWidth);
    pf.elapseTime(@(pos) random_dynamics_model(dynamics, pos, 5));
    
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
saveas(f, '../output_images/ps6-1-4-fig1.jpg');
f = figure(2)
imshow(track_viz_28)
saveas(f, '../output_images/ps6-1-4-fig2.jpg');
f = figure(3)
imshow(track_viz_84)
saveas(f, '../output_images/ps6-1-4-fig3.jpg');
f = figure(4)
imshow(track_viz_144)
saveas(f, '../output_images/ps6-1-4-fig4.jpg');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end


if (prob == 1 && subprob == '5') || prob == -1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  1.5  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

debate = VideoReader('../input_images/noisy_debate.avi');

nFrames = debate.NumberOfFrames;
nFramesToTrack = 144;
vidHeight = debate.Height;
vidWidth = debate.Width;

% sigma = sqrt(10^2/255);
sigma = 10/255;
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

video_writer = VideoWriter('../output_images/ps6-1-5.avi');
open(video_writer);

% m(:, :, :, 1) = frame;
% m = zeros(vidHeight, vidWidth, 3, nFramesToTrack);
nStart = 2;
for k = nStart:nFramesToTrack
    fprintf(1, '%d of %d frames\n', k, nFrames);
    % Predict (using random dynamics model)
    dynamics = rand(vidHeight, vidWidth);
    pf.elapseTime(@(pos) random_dynamics_model(dynamics, pos, 5));
    
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

    if k == 14
        pf.center
        pf.spread
        noisy_viz_14 = im;
    end

    if k == 32
        pf.center
        pf.spread
        noisy_viz_32 = im;
    end
    
    if k == 46
        pf.center
        pf.spread
        noisy_viz_46 = im;
    end
end

close(video_writer);

fps = 30;
implay(m,fps)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f = figure(5)
imshow(noisy_viz_14)
saveas(f, '../output_images/ps6-1-5-fig1.jpg');
f = figure(6)
imshow(noisy_viz_32)
saveas(f, '../output_images/ps6-1-4-fig2.jpg');
f = figure(7)
imshow(noisy_viz_46)
saveas(f, '../output_images/ps6-1-4-fig3.jpg');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end



if (prob == 2 && subprob == '1') || prob == -1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  2.1  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

debate = VideoReader('../input_images/pres_debate.avi');

nFrames = debate.NumberOfFrames;
nFramesToTrack = 140;
vidHeight = debate.Height;
vidWidth = debate.Width;

% sigma = sqrt(10^2/255);
sigma = 0.1/255;
% Read the first frame
frame = readd(debate, 1);

% The range of the window to capture romney's head (21x61)
window_range_x = 535:590;
window_range_y = 400:520;

appear_patch = frame(window_range_y, window_range_x, :);
% Convert to grayscale, to use for tracking
frameG  = rgb2gray(frame);
windowG = frameG(window_range_y, window_range_x);

num_particles = 5000;

% Initial particle distribution...one in every position
% TODO: try particles within the window to find...might give better results
pf = ParticleFilter(vidWidth, vidHeight, num_particles);

video_writer = VideoWriter('../output_images/ps6-2-1.avi');
open(video_writer);

alpha = 0.4;
dyn_scale = 30;
% m(:, :, :, 1) = frame;
% m = zeros(vidHeight, vidWidth, 3, nFramesToTrack);
nStart = 2;
for k = nStart:nFramesToTrack
    fprintf(1, '%d of %d frames\n', k, nFrames);
    % Predict (using random dynamics model)
    dynamics = rand(vidHeight, vidWidth);
    pf.elapseTime(@(pos) random_dynamics_model(dynamics, pos, dyn_scale));
    
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

    if k == 15
        pf.center
        pf.spread
        appear_viz_15 = im;
    end

    if k == 50
        pf.center
        pf.spread
        appear_viz_50 = im;
    end
    
    if k == 140
        pf.center
        pf.spread
        appear_viz_140 = im;
    end
    
    windowG = update_patch_iir(frameG, windowG, pf.center, alpha);
end

close(video_writer);

fps = 30;
implay(m,fps)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(8)
imshow(appear_patch)
f = figure(9)
imshow(appear_viz_15)
saveas(f, '../output_images/ps6-2-1-fig1.jpg');
f = figure(10)
imshow(appear_viz_50)
saveas(f, '../output_images/ps6-2-1-fig2.jpg');
f = figure(11)
imshow(appear_viz_140)
saveas(f, '../output_images/ps6-2-1-fig3.jpg');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end



if (prob == 2 && subprob == '2') || prob == -1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  2.2  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

debate = VideoReader('../input_images/noisy_debate.avi');

nFrames = debate.NumberOfFrames;
nFramesToTrack = 140;
vidHeight = debate.Height;
vidWidth = debate.Width;

% sigma = sqrt(10^2/255);
sigma = 0.1/255;
% Read the first frame
frame = readd(debate, 1);

% The range of the window to capture romney's head (21x61)
window_range_x = 535:590;
window_range_y = 400:520;

appear_noisy_patch = frame(window_range_y, window_range_x, :);
% Convert to grayscale, to use for tracking
frameG  = rgb2gray(frame);
windowG = frameG(window_range_y, window_range_x);

num_particles = 4000;

% Initial particle distribution...one in every position
% TODO: try particles within the window to find...might give better results
pf = ParticleFilter(vidWidth, vidHeight, num_particles);

video_writer = VideoWriter('../output_images/ps6-2-2.avi');
open(video_writer);

alpha = 0.4;
dyn_scale = 30;
% m(:, :, :, 1) = frame;
% m = zeros(vidHeight, vidWidth, 3, nFramesToTrack);
nStart = 2;
for k = nStart:nFramesToTrack
    fprintf(1, '%d of %d frames\n', k, nFrames);
    % Predict (using random dynamics model)
    dynamics = rand(vidHeight, vidWidth);
    pf.elapseTime(@(pos) random_dynamics_model(dynamics, pos, dyn_scale));
    
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

    if k == 15
        pf.center
        pf.spread
        appear_viz_15 = im;
    end

    if k == 50
        pf.center
        pf.spread
        appear_viz_50 = im;
    end
    
    if k == 140
        pf.center
        pf.spread
        appear_viz_140 = im;
    end
    
    windowG = update_patch_iir(frameG, windowG, pf.center, alpha);
end

close(video_writer);

fps = 30;
implay(m,fps)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(12)
imshow(appear_noisy_patch)
f = figure(13)
imshow(appear_viz_15)
saveas(f, '../output_images/ps6-2-2-fig1.jpg');
f = figure(14)
imshow(appear_viz_50)
saveas(f, '../output_images/ps6-2-2-fig2.jpg');
f = figure(15)
imshow(appear_viz_140)
saveas(f, '../output_images/ps6-2-2-fig3.jpg');
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


