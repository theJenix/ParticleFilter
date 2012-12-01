function test_calc_mse()
    debate = VideoReader('../input_images/pres_debate.avi');

    sigma = 10;

    % Read the first frame
    frame = readd(debate, 1);

    % The range of the window to capture romney's head
    window_range_x = 320:430;
    window_range_y = 192:302;

    % Convert to grayscale, to use for tracking
    frameG  = rgb2gray(frame);
    windowG = frameG(window_range_y, window_range_x);

    imshow(windowG);
    % Should be 0
    mse   = calc_mse(frameG, windowG, [375;247]);

end

