% // ==================================
% // test program
% // ==================================
function test_random_dynamics_model()

    distn = rand(10, 10)
    [m, p] = random_dynamics_model(distn, [3;4])
    [m, p] = random_dynamics_model(distn, [1;1])
    [m, p] = random_dynamics_model(distn, [10;10])
end