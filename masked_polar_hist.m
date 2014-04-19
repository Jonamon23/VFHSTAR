function H_polar= masked_polar_hist(H, Th_robot, Rr, Rl,robotRadius,...
    threshold_high,threshold_low,X_robot, Y_robot,lidar)
% Function 5
% By: Dingwang Wang
%
% This function According to the description on P3 of the VFH+, Then mean 
% it will be keep if the angle corresponding to valley sector within the 
% range of Th_r and Th_l, otherwise it will be masked.
%
% Call this function as:
% 
% 
% Input: 
%   H - Smoothed Polar Obstacle density histogram - vector(1x54)
%	Th - The current robot orientation
%	Rr - The minimum steering radii for right turn
%   Rl - The minimum steering radii for left turn
%
% Output: 
%  H_binary Masked and Smoothed Polar Obstacle density 
%              histogram = vector(1x54)

%Apply the threshold hysteresis to setup the Binary Polar Histogram
% (1 = valley, 0 = non-valley)
    H_binary=(H>threshold_high);
    H_binary=(H<threshold_low);

    % The lidar index definitions

    Index=1;
    Distance=2;
    Theta=3;
    X_cell=4;
    Y_cell=5;
    Cell_to_left_Center=6;
    Cell_to_right_Center=7;


    lidar_array(Index,:)=[1:1080];
    lidar_array(Distance,:)=lidar;
    lidar_array(Theta,:)=[0.25:0.25:270];
    lidar(X_cell,:)=lidar_array(Distance,:).*sin(lidar_array(Theta,:);
    lidar(Y_cell,:)=lidar_array(Distance,:).*cos(lidar_array(Theta,:);
    %The positions of the right and left trajectory centers relatvie to the
    %current robot position
    X_left_center=X_robot-Rl*sin(Th_robot);
    Y_left_center=Y_robot+Rl*sin(Th_robot);

    X_right_center=X_robot+Rr*sin(Th_robot);
    Y_right_center=Y_robot-Rr*sin(Th_robot);
    %The distance from an active cell to the two trajectory centers
    lidar_array(Cell_to_left_Center,:)=sqrt((X_left_center-X_cell).^2+...
        (Y_left_center-Y_cell).^2);
    lidar_array(Cell_to_right_Center,:)=sqrt((X_right_center-X_cell).^2+...
        (Y_right_center-Y_cell).^2);
    %Check if the obstacle block the direction to left
    Mini_safe_distance=Rr+robotRadius;
    lidar_array(Cell_to_left_Center,:)=lidar_array(Cell_to_left_Center,:)-...
        Mini_safe_distance;
    % Find all the obstacle that will block the direction to left
    lidar_array(Cell_to_left_Center,:)=find(lidar_array(Cell_to_left_Center,:)...
        <0);
    % Find the farthest cell index
    Mask_index=min(lidar_array(Cell_to_left_Center,:));
    %Calculate the associated sector index
    Mask_sector_index=Mask_index*sensor_res/sector_res;
    %Mask the binary left to the farthest cell
    H_binary(end-Mask_sector_index:end)=1;


    %Check if the obstacle block the direction to right
    Mini_safe_distance=Rl+robotRadius;
    lidar_array(Cell_to_right_Center,:)=lidar_array(Cell_to_right_Center,:)-...
        Mini_safe_distance;
    % Find all the obstacle that will block the direction to right
    lidar_array(Cell_to_right_Center,:)=find(lidar_array(Cell_to_right_Center,:)...
        <0);
    % Find the farthest cell index
    Mask_index=max(lidar_array(Cell_to_right_Center,:));
    %Calculate the associated sector index
    Mask_sector_index=Mask_index*sensor_res/sector_res;
    %Mask the binary right to the farthest cell
    H_binary(1:Mask_sector_index)=1;

end





