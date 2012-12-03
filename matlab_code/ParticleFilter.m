% Problem Set 6 - Particle Tracking
% Name: Jesse Rosalia
% GT Username: jrosalia3
% Section: A
%
% ParticleFilter - This class implements a particle filter, used for tracking an image through video.
%
%
classdef ParticleFilter < handle
    
    properties(GetAccess='private', SetAccess='private')
        width
        height
        particles
        particle_weights
    end
    
    properties(GetAccess='public', SetAccess='private')
        candidates
        center
        spread
    end
    
    methods(Access='private', Static)
        function n=norml(A)
            n = A / sum(A(:));
        end
        
    end

    methods(Access='private')
        function update_particles(self, new_particles, weights)
            % Compute a weighted average based on the distribution passed
            % in.  This is likely the distribution used to redistribute the
            % particles.
            self.particles = new_particles;
            self.particle_weights = weights;
            particlesD = double(self.particles);
            weighted_average = sum(bsxfun(@times, particlesD.', weights.'));
            % Transposed to get into a column vector
            self.center = weighted_average.';
            
            % Compute the weighted distance to the center
            %..this uses Euclidean distance (sqrt((a-a0)^2 + (b-b0)^2), but
            % runs the operations across the whole matrix of points.
            diff = bsxfun(@minus, particlesD, self.center);
            diff = diff .^ 2;
            diff = sum(diff);
            diff = sqrt(diff);
            %mean(range(self.particles));
            %self.spread = sum(diff / size(diff, 2)); %* weights.';
            self.spread = diff * weights.';
        end
    end
    
    methods
        function value = get.candidates(self)
            value = self.particles;
        end
        
        function self=ParticleFilter(width, height, num_particles)
            self.width = width;
            self.height = height;

            r       = rand(2, num_particles);
            rscaled = [1 + (width - 1) * r(1, :); 1 + (height - 1) * r(2, :)];
            self.particles = uint16(rscaled);
            self.particle_weights = ones(1, num_particles) / num_particles;
        end
        
        function observe(self, observation_distn)
            % Apply Bayes theorm, resample and update the filter state
            new_particle_weights = self.particle_weights .* observation_distn;
            sample = randsample(1:uint16(size(self.particles, 2)), size(self.particles, 2), true, new_particle_weights);
            self.update_particles(self.particles(:, sample), observation_distn);%[x; y];
        end
        
        % Move all of the particles based on the dynamics model
        % then adjust the particle weight array accordingly
        % NOTE: The dynamics model is passed in as a function that takes in
        % a position, and returns the new legal positions and the
        % probability of movement to that position
        function elapseTime(self, at_dynamics)
            new_particles = zeros(size(self.particles));
            new_weights     = self.particle_weights;
            num_particles = uint16(size(self.particles, 2));
            for i = 1:num_particles;
                p = self.particles(:, i);
                [new_ps, distn] = at_dynamics(p);
                inx = randsample(1:uint16(size(new_ps, 2)), 1, true, distn);
                new_p = new_ps(:, inx);
                new_particles(:, i) = new_p;
                % "Smooth" out the weight for this particle based on the dynamics
                % distribution
                % NOTE: we'll normalize later
                new_weights(i) = new_weights(i) * distn(inx);
            end
            
            % Normalize to sum to 1
            new_weights = new_weights / sum(new_weights);
            self.update_particles(new_particles, new_weights);
        end        
    end
end


