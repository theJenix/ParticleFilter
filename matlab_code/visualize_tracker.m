function [ image ] = visualize_tracker( movie, frame, window_width, pf )

    f = figure('visible','off');
    imshow(frame, 'Border', 'tight');
    hold on
    plot(pf.candidates(1, :), pf.candidates(2, :), 'b.',  'MarkerSize', 10) 
    plot(pf.center(1), pf.center(2), 'o');
    plot(pf.center(1), pf.center(2), 'gs',   'MarkerSize', window_width);
    plot(pf.center(1), pf.center(2), 'ro--', 'MarkerSize', ceil(pf.spread));
% th = 0:pi/50:2*pi;
% xunit = pf.spread * cos(th) + pf.center(1);
% yunit = pf.spread * sin(th) + pf.center(2);
% plot(xunit, yunit);
    hold off
    
    % convert to an image matrix
    image = hardcopy(f, '-dzbuffer', '-r0');
    writeVideo(movie, image);
    close(f);
end

