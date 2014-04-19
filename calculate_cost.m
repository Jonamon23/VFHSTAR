function [new_g_cost,new_projection_position] = calculate_cost(valleys,Hi)
% Function 10
% By:Dingwang Wang
%
% This function sums each projected direction cost g(1)+g(2)+..+g(ng)+h(ng)
% I refer it from A*, Then picks the lowest one  and output the associated
% the sector number to picked_sector
%
% Call this funciton as:
% 
%
% Input:
% g_cost - the cost for each projected candidate direction with ds distance 
%     Hi - Heuristic value for each node
% 
% Output: 
%   picked_sector - the sector number of projected direction with the
%                   lowest cost.

S_max=16;
 if(isempty(valleys))
   new_g_cost=[];
  % new_projection_position=[];
    return
else   
    target_sector = round((target_angle-(-135))/sector_res);
    center_sector=27;
        %find nearest sector to angle
        
    START=1; %valley array index definitions
    END=2;
    WIDTH=3;
    TOGOAL_L=4;
    TOGOAL_R=5;
    WIDE=6; 
   
        %How close the rising and falling edges of the valleys are to the
        %target

    valleys(:,TOGOAL_L)=target_sector-valleys(:,START);
    valleys(:,TOGOAL_R)=valleys(:,END)-target_sector;
    
    valleys(:,WIDE)=valleys(:,WIDTH)>=S_max;
    
    narrow_valleys=valleys(~logical(valleys(:,WIDE)),1:2);
    wide_valleys=valleys(logical(valleys(:,WIDE)),1:3);
    
    %Index definitions
    SECTOR=1;
    WIDE=2;
    TOGOAL=3;
    TOAPPROACH=4;
    TOLAST=5;
    G_COST=6;
    PROJ_X=7;
    PROJ_Y=8;
    PROJ_TH=9;
    
    %Narrow valley's supply one candidate, down the center
    lc=size(candidates,1)+1;
    ln=size(narrow_valleys,1)-1;
    Candidates(lc:lc+ln,SECTOR)=narrow_valleys(:,START)+(narrow_valleys(:,END)...
        -narrow_valleys(:,START))/2;
    candidates(lc:lc+ln,WIDE)=0;
    %Wide valleys supply at least 2 candidates. 
    %First is the left side of the valley
      lc=size(candidates,1)+1;
    lw=size(narrow_valleys,1)-1;
    Candidates(lc:lc+lw,SECTOR)=wide_valleys(:,START)+S_max/2;
    candidates(lc:lc+ln,WIDE)=1; 
   
     %Second is the right side of the valley
     lc=size(candidates,1)+1;
      Candidates(lc:lc+lw,SECTOR)=wide_valleys(:,END)-S_max/2;
    candidates(lc:lc+ln,WIDE)=1; 
    lc=size(candidates,1)+1;
    % Wide valleys can also supply the a candidate of the target direction
    target_valley=valleys(valleys(:,TOGOAL_L)>0 & valleys(:,TOGOAL_R)>0);
    if(~isempty(target_valley))
        candidates(lc,[SECTOR,WIDE])=[target_sector,1];
    end
        lc=size(candidates,1)+1;
    %Check if the wide valleys can supply the forward candidate
    forward_valley=valleys(valleys(:,START)+S_max/2<center_sector & ...
        valleys(:,END)-S_max/2>center_sector);
    if(~isempty(forward_valley))
        candidates(lc,[SECTOR,WIDE])=[center_sector,1];
    end
    
    %Calculate the g_cost
    
     
    
    % function g_cost = calc_cost_gc(ci, kt, th, ci-1)
% % Function 7
% % By: Dingwang Wang
% %
% % This function calculate the cost for a projected candidate direction ci 
% % of a node at depth i. It will use the equation 3 and 4 of the VFH* paper.
% %
% % Call this function as:
% %
% % Input: ci - the sector number of the candidate i
% %        kt - the sector number of the target
% %        th - the current orientation
% %      ci-1 - the sector number of the previously selected direction
% %
% % Output: g_cost - the cost for each project candidate direction
% 

    
     
    
        % For each valley, calculate the distance between the target sector
        % and the valley's start and end sector. Then put the smaller value
        % into the minimum distance column of the valley row. 
    [~,index] = min(valleys(:,MIN_DIST));
        % choose the valley with the smallest distance from the target by 
        % comparing the MIN_DIST of each valley and save the row index of 
        % the best valley 
    best_valley = valleys(index,:);
        % using the index of the valley of the least distance to the
        % target, fetch the valley's values and put into a vector

    if(~best_valley(:,WIDE))   % if best valley is narrow
        travel_sector = round(best_valley(:,START)+(best_valley(:,END)...
                                              - best_valley(:,START))/2);
        % angle = (START+END)/2

    else                       % if best valley is wide
        closer_to_target = abs(best_valley(:,START)-target_sector)< abs(best_valley(:,END)-target_sector);
            % determine if valley START border is the closest to the target 
            
        % angle = (kn+kf)/2
        % kn is the first free sector
        % kf = kn+s_max
        % since kf can be substituted in, angle = kn + s_max/2

        if(closer_to_target==1) % if START border is the closest,
            travel_sector=round(best_valley(:,START)+s_max/2); 
                % angle = start_border + s_max/2 
                
        else                    % if END border is the closest,
            travel_sector=round(best_valley(:,END)-s_max/2);
                % angle = end_border + s_max/2 
        end
    end
 end
end