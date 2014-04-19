function H = smooth_h(h, L)
% Function 4
% By: Dingwang Wang
% 
% In this function, the following equation is used:
%
%          hh(k-L)+2*hh(k-L+1)+...+L*hh(k)+...+2*hh(k+L-1)+hh(k+L)
% H(k) =  ---------------------------------------------------------
%                               2*L + 1
%
% H represents smoothed histrogram that will be used to make decisions.  
%   A loop is used to calcualte every sector's smoothed value. Because 
%   these calculations depend on previous and next sectors' obstacle 
%   densities, the map's beginning and ending will be filled with null 
%   values (to make calculations possible for the first and last sectors).
%
% Call this function as:
%   SmoothedPODHistrogram = smooth_h(SummedPODHistrogram,SmoothingDistance)
%
% Inputs: 
%   h - summed POD histogram based on sector width - vector(1x54)
%   L - smoothing parameter that determines the distance from the current 
%       center element on both sides. 
% Outputs:
%   H - Smoothed Polar Obstacle density histogram - vector(1x54)

    max_sectors = length(h); %variable for visual comprehension
    ratio = [(1:1:L),L,(L:-1:1)]; % for example if L=3, The ratio sequence
                                  % of the numerator should be: 
                                  % 1 2 3 3 3 2 1
    H_temp = conv(h,ratio);
    
   
    
    H(1:max_sectors)=H_temp(L+1:L+max_sectors)/(2*L+1);
    
end