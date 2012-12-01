function [ mse ] = calc_mse(frame, window, centers)

    window_size = size(window);
    num_centers = size(centers, 2);
    tiles = zeros(window_size(1) * window_size(2), num_centers);
    
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
    
    for i = 1:num_centers
        tile_x_range = x_range + int16(centers(1, i));
        tile_y_range = y_range + int16(centers(2, i));
        % TODO: for now, if we're near an edge, assume that this
        % particle has a really high MSE.  eventually, we can write code to
        % wrap the image, to get a better value
        if min(tile_x_range) < 1 || min(tile_y_range) < 1 || max(tile_x_range) > size(frame, 2) || max(tile_y_range) > size(frame, 1)
            tiles(:, i) = -window(:);
        else
            tile = frame(tile_y_range, tile_x_range);
            tiles(:, i) = tile(:);
        end
    end
    
    mse = msefun(tiles, window(:));
end