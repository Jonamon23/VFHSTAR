function [X2, Y2 ,th2] = new_position(X1, Y1, th,ds)
% Function 8
% By: Jianfan Lin
% 
% This function computes the new position and orientation that robot would 
% have after moving for a projected step distance ds for each candidate 
% valley.
%    	X2  = X1+ds*cos(th)
% 	 	Y2  = Y1+ds*sin(th)
%  	 	th2 = asind((Y2 -Y1)/( X2 -X1))
%
% Input: 
%   X1 and Y1 – coordinates of current position
%          Ds - the projected step distance 
%          Th - the current orientation
%
% Output: 
%   X2,Y2 – coordinates of new position
%     th2 - the orientation of new position
