function Hi = calc_heuristic(ci, kt, th, cim1)
% Function 9
% By: Jianfan Lin
%
% This function calculate the heuristic h(c) of last node of each
% projected direction according to equation 8 on page 5 of VFH*
% 
% Call this function as:
% Hi = calc_heuristic(ci, kt, th, ci-1)
%
% Input:
%   Ci - the sector number of the candidate I 
%   Kt - the sector number of the target 
%   Th - the current orientation 
% Cim1 - the sector number of the previously selected direction
% 
% Output:
%   Hi - Heuristic value for each node


Ke = -artan( (yip1 - yi)/(xi1-xi) ); % based on ci = kt

Hi = L * (u1*delta(ke, Kt) + u2*delta(Kt, Th/alpha) + u3*delta(Kt,cim1) );