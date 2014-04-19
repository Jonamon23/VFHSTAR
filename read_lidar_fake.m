function lidar = read_lidar_fake()
% Function 2
% By: Jianfan Lin
% 
% This function acts as a test for the other functions to generate a lidar
%   reading. It can be replaced in the future with 'read_lidar' to obtain
%   an actual reading.
%
% Call this function as:
%   LidarVector = read_lidar_fake
%
% Inputs: N/A
%
% Outputs: 
%   lidar - Distances of obstacles from robot - vector(1x1081) 

    lidar = 8*ones(1,1081);
    lidar(300:360) = 7;
    lidar(460:580) = 5;
    lidar(840:920) = 6;

%     theta = 1:1081;
%     th = -135:.25:135;
%     stem(th,lidar);
%     set(gca,'XDir','reverse');
%     hold on;
%     stem(55,8.5,'r');
%     hold off;
    
end


