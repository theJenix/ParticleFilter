function [ legal_moves, prob_distn ] = random_dynamics_model( rand_distn, position )
    templ_x = double([-1 -1 -1  0 0 0  1 1 1]);
    templ_y = double([-1  0  1 -1 0 1 -1 0 1]);
    legal_moves = [double(position(1)) + templ_x ; double(position(2)) + templ_y];
    
    lm_size = size(legal_moves);
    [~, col] = ind2sub(lm_size, find(legal_moves <= 0));
    
    legal_moves(:, col) = [];

    [~, col] = ind2sub(lm_size, find(legal_moves(1, :) > size(rand_distn, 2)));

    legal_moves(:, col) = [];

    [~, col] = ind2sub(lm_size, find(legal_moves(2, :) > size(rand_distn, 1)));

    legal_moves(:, col) = [];

    try
        inx = sub2ind(size(rand_distn), legal_moves(2, :), legal_moves(1, :));
        prob_distn = rand_distn(inx);
        prob_distn = prob_distn / sum(prob_distn(:));
    catch err
        A(235) = 1;
    end
end

