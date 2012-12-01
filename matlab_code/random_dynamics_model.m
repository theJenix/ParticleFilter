function [ legal_moves, prob_distn ] = random_dynamics_model( rand_distn, position )
    scale   = 5;
    templ_x = double(scale * [-1 -1 -1  0 0 0  1 1 1]);
    templ_y = double(scale * [-1  0  1 -1 0 1 -1 0 1]);
    legal_moves = [double(position(1)) + templ_x ; double(position(2)) + templ_y];
    
    col = [find(legal_moves(1, :) <= 0) find(legal_moves(2, :) <= 0) find(legal_moves(1, :) > size(rand_distn, 2)) find(legal_moves(2, :) > size(rand_distn, 1))];

    legal_moves(:, col) = [];

    %inx = sub2ind(size(rand_distn), legal_moves(2, :), legal_moves(1, :));
    prob_distn = zeros(1, size(legal_moves, 2));
    for i = 1:size(legal_moves, 2)
        prob_distn(i) = rand_distn(legal_moves(2, i), legal_moves(1, i));
    end
    prob_distn = prob_distn / sum(prob_distn(:));
end

