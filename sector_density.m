function h = sector_density(dmax,sensor_res,sector_res,... 
                            robotRadius)
% Function 3 
% By: Jonathon Kreska
% 
% This function enlarges the lidar values based on the safe robot radius 
%  and keeps the most dangerous ones. Then it calculates the magnitude of 
%  the polar obstacle density of of each Lidar vector element then it 
%  calculates the magnitude of polar obstacle density of each sector in a 
%  reduced size vector.
%
% Call this function as:
%   SummedPODHistrogram = sector_density(LidarVector,MaxDistOfLidar,...
%                                        SensorResolution,SectorResolution)
%
% Input: 
%   enlargedlidar - Distances of obstacles from robot - vector(1x1081)
%            dmax - Maximum distance of sensor
%      sensor_res - angle between consecutive lidar element readings
%      sector_res - angle width of each sector
%
% Output: 
%   h - summed POD histogram based on sector width - vector(1x54)

   
    deg_spread=2*min(asind(robotRadius./lidar),45);
    cell_spread_count=round(deg_spread/sensor_res)+1;
    max_cell_spread_count=max([1,cell_spread_count]);
    cell_index=zeros(1080,max_cell_spread_count);
    cell_distance=zeros(1080,max_cell_spread_count);
   
       for i=1:max_cell_spread
           for j=1:1080
           cell_index(j:i)=min((j+cell_spread_count(j)/2),(j-cell_spread_count(j)/2+(i-1)));
           cell_index(j:i)=max(1,cell_index(j:i));
           end
           cell_distance(:i)=lidar(:);
       end
   
    cell_index= cell_index(:);
    cell_distance=cell_distance(:);
    index_distance=[cell_index(:),cell_distance(:)];
    index_distance=sortrows(index_distance,-2);
      
    enlargedlidar=dmax*ones(1,1080);
    enlargedlindar(index_distance(:,1))=index_distance(:,2);
    %gfddgggffgfhhjhf
    a=1; %a can be any variable such that: a-b*dmax=0
    b=a/dmax; % b is determined based on a and dmax
    
    m = a-b*enlargedlidar(1:end-1); %gives a magnitude of danger to readings that 
        % are close. If a lidar reading is small, the danger value is 
        % larger. This is determinded based on the maximum distance of the 
        % sensor. I had to cut off the last element so it lidar vector
        % could be used in the reshape function. A loss of one value is
        % nothing compared to the size of the whole vector. My original
        % way to keep all the elements was too compilcated and it doesn't
        % matter after you round the number of vectors
    
    element_per_sector = sector_res / sensor_res; 
        % finds how many lidar elements should be summed
    max_sectors = round(length(m)/element_per_sector); 
        %determines max number of sectors based on resolution and length
    
    temp=reshape(m,element_per_sector,max_sectors);
        % shapes danger values into an array with a rows of elements per
        % sector with columns of these values for each sector
        % If elements_per_sector = 3 and max_sector = 4 and m(1:12)
        %          S1 S2 S3 S4
        % temp =   E1 E4 E7 E10
        %          E2 E5 E8 E11
        %          E3 E6 E9 E12
          
    h=sum(temp,1); % sums each sector, condensing it into a vector  
    
    end
