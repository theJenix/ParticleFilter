function [ image ] = visualize_tracker( frame, window_width, pf )

    f = figure('visible','off');
    imshow(frame, 'Border', 'tight');
    hold on
    plot(pf.candidates(1, :), pf.candidates(2, :), 'b.',  'MarkerSize', 5) 
    plot(pf.center(1), pf.center(2), 'o');
    plot(pf.center(1), pf.center(2), 'gs',   'MarkerSize', window_width);
    plot(pf.center(1), pf.center(2), 'ro--', 'MarkerSize', pf.spread);
    hold off
    
    
    % convert to an image matrix
    image = hardcopy(f, '-dzbuffer', '-r0');
    
%     addframe(movie, f);
%     fr = getframe(f);
%     close(f);
% 
%     [im,map] = frame2im(fr);    %Return associated image data 
%     if isempty(map)            %Truecolor system
%       rgb = im;
%     else                       %Indexed system
%       rgb = ind2rgb(im,map);   %Convert image data
%     end
% 
%     image = rgb;


end

