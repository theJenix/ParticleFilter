% Problem Set 2 - Window-based Stereo Matching
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

if (prob == 1 && subprob == 'a') || prob == -1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  1a  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

debate = VideoReader('../input_images/pres_debate.avi');

nFrames = debate.NumberOfFrames;
vidHeight = debate.Height;
vidWidth = debate.Width;

sigma = 10;

% Read the first frame
frame = readd(debate, 1);
% Pull the green channel...we'll use this for tracking
frameG = frame(:, :, 2);

% The range of the window to capture romney's head
window_range_x = 320:430;
window_range_y = 192:302;

windowG = frameG(window_range_x, window_range_y);

num_particles = 500;

% Initial particle distribution...one in every position
% TODO: try particles within the window to find...might give better results
pf = ParticleFilter(vidWidth, vidHeight, num_particles);

for k = 2:nFrames
    fprintf(1, '%d of %d frames\n', k, nFrames);
    % Predict (using random dynamics model)
    pf.elapseTime(@(pos) random_dynamics_model(vidWidth, vidHeight, pos));
    
    % Correct
    frame = readd(debate, k);
    % Pull the green channel...we'll use this for tracking
    frameG = frame(:, :, 2);
    
    mse   = calc_mse(frameG, windowG, pf.candidates);
    Pz_x  = exp(-mse/(2 * sigma^2));
    pf.observe(Pz_x);
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1)
subplot('Position',[0,0.5,0.5,0.5])
imshow(disp1a_l_to_r)
subplot('Position',[0,0,0.5,0.5])
imshow(disp1a_r_to_l)
subplot('Position',[0.5,0.5,0.5,0.5])
imshow(disp_truth_l)
subplot('Position',[0.5,0,0.5,0.5])
imshow(disp_truth_r)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end



if (prob == 2 && subprob == 'a') || prob == -1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  2a  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Your code

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(2)
subplot('Position',[0,0.5,0.5,0.5])
imshow(disp2a_l_to_r)
subplot('Position',[0,0,0.5,0.5])
imshow(disp2a_r_to_l)
subplot('Position',[0.5,0.5,0.5,0.5])
imshow(disp1a_l_to_r)
subplot('Position',[0.5,0,0.5,0.5])
imshow(disp1a_r_to_l)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end



if (prob == 2 && subprob == 'b') || prob == -1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  2b  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Your code

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(3)
subplot('Position',[0,0.5,0.5,0.5])
imshow(disp2b_l_to_r)
subplot('Position',[0,0,0.5,0.5])
imshow(disp2b_r_to_l)
subplot('Position',[0.5,0.5,0.5,0.5])
imshow(disp1a_l_to_r)
subplot('Position',[0.5,0,0.5,0.5])
imshow(disp1a_r_to_l)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end



if (prob == 3 && subprob == 'a') || prob == -1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  3a  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Your code

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(4)
subplot('Position',[0,0.5,0.33,0.5])
imshow(disp3a_l_to_r)
subplot('Position',[0,0,0.33,0.5])
imshow(disp3a_r_to_l)
subplot('Position',[0.33,0.5,0.33,0.5])
imshow(disp1a_l_to_r)
subplot('Position',[0.33,0.,0.33,0.5])
imshow(disp1a_r_to_l)
subplot('Position',[0.66,0.5,0.33,0.5])
imshow(disp_truth_l)
subplot('Position',[0.66,0.,0.33,0.5])
imshow(disp_truth_r)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end



if (prob == 3 && subprob == 'b') || prob == -1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  3b  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Your code

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(5)
subplot('Position',[0,0.5,0.33,0.5])
imshow(disp3b_gauss_l_to_r)
subplot('Position',[0,0,0.33,0.5])
imshow(disp3b_gauss_r_to_l)
subplot('Position',[0.33,0.5,0.33,0.5])
imshow(disp2a_l_to_r)
subplot('Position',[0.33,0.,0.33,0.5])
imshow(disp2a_r_to_l)
subplot('Position',[0.66,0.5,0.33,0.5])
imshow(disp_truth_l)
subplot('Position',[0.66,0.,0.33,0.5])
imshow(disp_truth_r)

figure(6)
subplot('Position',[0,0.5,0.33,0.5])
imshow(disp3b_contr_l_to_r)
subplot('Position',[0,0,0.33,0.5])
imshow(disp3b_contr_r_to_l)
subplot('Position',[0.33,0.5,0.33,0.5])
imshow(disp2b_l_to_r)
subplot('Position',[0.33,0.,0.33,0.5])
imshow(disp2b_r_to_l)
subplot('Position',[0.66,0.5,0.33,0.5])
imshow(disp_truth_l)
subplot('Position',[0.66,0.,0.33,0.5])
imshow(disp_truth_r)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end




if (prob == 4 && subprob == 'a') || prob == -1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  4a  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Your code

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1)
subplot('Position',[0,0.5,0.5,0.5])
imshow(disp4a_l_to_r)
subplot('Position',[0,0,0.5,0.5])
imshow(disp4a_r_to_l)
subplot('Position',[0.5,0.5,0.5,0.5])
imshow(disp_truth_l)
subplot('Position',[0.5,0,0.5,0.5])
imshow(disp_truth_r)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
