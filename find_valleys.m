function valleys=find_valleys(H_binary,threshold,s_max)
% Function 6
% By: Dingwang Wang
%
% This function finds candidate valleys whose PODs bellow a certain 
%   threshold and puts a logical 1 in the corresponding element address.
%   Then classifies the binary histogram representing sectors with 1 
%   if the sector obstacle density is less than the threshold, otherwise 
%   the element is 0. Then this function will find out all the available 
%   valleys that robot can go through. We will output all the valleys with 
%   the associated start sector, end sector, if is wide or narrow valley, 
%   and an empty column for distance from target.
%   A narrow valley is classified as a valley whose width is less than or
%   equal to s_max.
%   POD: polar obstacle density
%
% Call this Function as: 
%   ArrayOfValleyProperties=valleys(SmoothedPODHistrogram,...
%                                                   ValleyThreshold,Smax)
%
% Inputs: 
%    Masked_H ? Masked and Smoothed Polar Obstacle density 
%               histogram = vector(1x54)
%   threshold - value that is compared against to classify a valley
%       s_max - classification for minimum width of a wide valley
%
% Output: 
%     valleys - valleys[start sector, end sector, wide/narrow valley]

   if (sum(H_binary)<=0) %if all values are 0, then there are no valleys
        valleys=[];
        return;
   end  
    
     edges=[H_binary,0]-[0,H_binary]; 
        %find where values change from 0-1 or 1-0
    valley_start=find(edges>0); % find where edges = 1 -> start of valley
    valley_end=find(edges<0)-1; % find where edges = -1 -> end of valley
    valley_width=valley_end-valley_start+1; % determine width of valley
    valley_wide=valley_width>s_max; % classify wide valleys > s_max
     
  
    valley_count=length(valley_start);
        % determine how many rows are needed in valley array

    valleys = zeros(valley_count,4); % initialize array of valley starts, 
        %ends, whether it is wide, and an extra column for distance
        % The fourth column is defined here, but not used until a later
        % function
    
    START= 1; %define column 1 for start index
    END  = 2; %define column 2 for end index
    WIDE = 3; %define column 3 for classifying wide or narrow
        % 1 = wide , 0 = narrow
    
    valleys(:,START)=valley_start(:); 
        % put start address in first column
    valleys(:,END)=valley_end(:); 
        % put end address in second column
    valleys(:,WIDE)=valley_wide(:); 
        % put wide classifaction in third column
    %Fourth column is empty for now
    
end
