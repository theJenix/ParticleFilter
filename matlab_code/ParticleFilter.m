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
            % This may not be right...but it will get us something
%             self.center = mean(self.particles.').';
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
            self.spread = diff; % * weights.';
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

%             self.particles = [375 375 ; 247 247];
%             self.particle_weights = [0.5 0.5];
%             self.particle_distn = zeros(height, width);
%             num_particles = uint16(size(self.particles, 2));
%             for i = 1:num_particles;
%                 p = self.particles(:, i);
                
%                 self.particle_distn(p(2), p(1)) = ...
%                         self.particle_distn(p(2), p(1)) + 1;
%             end
            
%             self.particle_distn = self.norml(double(self.particle_distn));
        end
        
        function observe(self, observation_distn)
%             % Apply Bayes theorm and normalize
%             self.particle_distn = observation_distn .* self.particle_distn;
%             self.particle_distn = self.norml(self.particle_distn);
%             
%             % Sample the distribution to find new locations for the
%             % particles
%             sample = randsample(1:uint16(size(self.particle_distn(:), 1)), size(self.particles, 2), true, self.particle_distn(:));
            new_particle_weights = self.particle_weights .* observation_distn;
            sample = randsample(1:uint16(size(self.particles, 2)), size(self.particles, 2), true, new_particle_weights);
%             [y, x] = ind2sub(size(self.particles), sample);
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
        
                % Move all of the particles based on the dynamics model
        % then adjust the particle weight array accordingly
        % NOTE: The dynamics model is passed in as a function that takes in
        % a position, and returns the new legal positions and the
        % probability of movement to that position
        function elapseTime2(self)
            
            distn = rand(self.height, self.width);
            inx = sub2ind(self.particles(2, :), self.particles(1, :));
            distn(inx) = distn(inx) .* self.particle_weights;
            %distn = distn / sum(distn(:));
            
            range = 1:(size(distn, 1) * size(distn, 2));
            inx = randsample(range, size(self.particles, 2), true, distn(:));
            [y x] = ind2sub(size(distn), inx);
            new_particles = [x ; y];
            new_weights = distn(inx);

            % Normalize to sum to 1
            new_weights = new_weights / sum(new_weights(:));
            self.update_particles(new_particles, new_weights);
        end
    end
end


