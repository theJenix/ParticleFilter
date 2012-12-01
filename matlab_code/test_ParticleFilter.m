% // ==================================
% // test program
% // ==================================
function test_ParticleFilter()

    % Test with a constant Gaussian as the sensor model, and
    % a static dynamics model.  The result is all of the particles
    % should collect on the most probable point in the gaussian.
    pf = ParticleFilter(10, 10, 100);
    sensor = fspecial('gaussian', [1 100]);
    for i = 1:100
        pf.elapseTime(@(p) random_dynamics_model(10, 10, p));
        pf.observe(sensor);
    end
%     pf.center
%     pf.spread
    pf.candidates
end