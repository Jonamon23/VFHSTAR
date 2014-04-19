function [linVel, angVel] = VFH_star(ng, targetAngle)
% Function 1
% By: Jonathon Kreska
%
% This function gives the instantaneous and angular velocity based on the 
% VFH* algorithim based on the contained parameters and a reading from a 
% Lidar sensor. It will call the VFH+ process ng number of times for each 
% candidate path.
% 
% Call this function as:
% 
% 
% Input: 
%            ng - step depth of how many nodes deep VFH+ should be used to 
%                 determine the cost of each candidate path
%   targetAngle - Angle in degrees that specifies the angle position of the 
%                 target from the Vehicle Center Point (-135 to 135)
%
% Output: 
%   linVel - Calculated Instantaneous Speed of the robot
%   angVel - Calculated angular velocity of the robot


lidar = read_lidar_fake();
h = sector_density(lidar);
H = smooth_h(h);
%set position to (0,0)
i=1;
num_of_candidate = 1;
while(i<=ng)
    j=1;
    while(j<=num_of_candidate)
        masked_polar_hist();
        find_valleys();
        calculate_cost();
        projectedPositions=new_position();        
        j=j+1;       
    end
    %update num_of_candidate
    i=i+1;
end

calc_heuristic();


%this

end
