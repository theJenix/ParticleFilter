% Problem Set 6 - Particle Tracking
% Name: Jesse Rosalia
% GT Username: jrosalia3
% Section: A
%
% update_patch_iir - Infinite Impulse Response filter to blend the previous template with the current best guess.
%
function [ new_window ] = update_patch_iir( frame, window, best_center, alpha )

    window_size = size(window);
    
    y_size  = int16(floor(window_size(1) / 2));
    y_range = -y_size:y_size;
    if size(y_range, 2) > window_size(1)
        y_range(window_size(1) + 1) = [];
    end
    x_size  = int16(floor(window_size(2) / 2));
    x_range = -x_size:x_size;
    if size(x_range, 2) > window_size(2)
        x_range(window_size(2) + 1) = [];
    end

    tile_x_range = x_range + best_center(1);
    tile_y_range = y_range + best_center(2);

    tile = frame(tile_y_range, tile_x_range);
    
    new_window =  alpha * tile + (1 - alpha) * window;
end

