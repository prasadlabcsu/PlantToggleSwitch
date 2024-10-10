%% Create the structure containing plant information
%  May 1, 2017 
%  Wenlong Xu
%  Prasad Group 
%  Colorado State Univ
%  ------------------------------------------------------------------------
%% Modified from the get_plant_info to get the population mean rather than individual plants 
function Plant = get_plant_info_mean(LINE_NAME, Day_Induce, Prefix)
%  The matrix is organized by rows, each row corresponds to one treatment: 
%  DEX-->LUC, 
%  DEX-->OHT, 
%  DEX-->DEX 
%  LUC-->LUC
%  OHT-->LUC, 
%  OHT-->OHT, 
%  OHT-->DEX
if strcmp(LINE_NAME, 'Toggle2-5-49')
    %  Toggle2-5-49 (06/15/2015) 
    %  The mostly used transgenic line for Toggle1.0
    Plant_Idx = [1, 2, 3, 7, 4, 5, 6]; 
    Num_plants = 4; 
    Idx = zeros(9, 4); 
    Idx(1, :) = 1:4; 
    Idx(2, :) = 5:8; 
    Idx(3, :) = 9:12; 
    Idx(4, :) = [2, 3, 5, 6] + 16; 
    Idx(5, :) = (8:11) + 16; 
    Idx(6, :) = (12:15) + 16; 
    Idx(7, :) = (1:4) + 32; 
    Idx(8, :) = (5:8) + 32; 
    Idx(9, :) = [9, 10, 11, 13] + 32; 
    Trt1_tag = {'DEX', 'DEX', 'DEX', 'OHT', 'OHT', 'OHT', 'LUC', 'LUC', 'LUC'}; 
    Trt2_tag = {'LUC', 'OHT', 'DEX', 'LUC', 'OHT', 'DEX', 'LUC', 'OHT', 'DEX'};
elseif strcmp(LINE_NAME, 'Toggle2-5-39')
    %  Toggle2-5-39 (06/15/2015) 
    %  less used transgenic line for Toggle1.0
    %  Plant Index 21 lacks one day in the time series, which will be
    %  excluded from the analysis. 
    Plant_Idx = [1, 2, 3, 7, 4, 5, 6]; 
    Num_plants = 4; 
    Idx = zeros(9, 4); 
    Idx(1, :) = 1:4; 
    Idx(2, :) = 5:8; 
    Idx(3, :) = 9:12; 
    Idx(4, :) = [1, 2, 4, 5] + 16; 
    Idx(5, :) = (6:9) + 16; 
    Idx(6, :) = (10:13) + 16; 
    Idx(7, :) = (1:4) + 32; 
    Idx(8, :) = (5:8) + 32; 
    Idx(9, :) = (9:12) + 32; 
    Trt1_tag = {'DEX', 'DEX', 'DEX', 'OHT', 'OHT', 'OHT', 'LUC', 'LUC', 'LUC'}; 
    Trt2_tag = {'LUC', 'OHT', 'DEX', 'LUC', 'OHT', 'DEX', 'LUC', 'OHT', 'DEX'};
elseif strcmp(LINE_NAME, 'Toggle2-5-65')
    %  Toggle2-5-65 (06/15/2015) 
    %  less used transgenic line for Toggle1.0
    Plant_Idx = [1, 2, 3, 7, 4, 5, 6]; 
    Num_plants = 4; 
    Idx = zeros(9, 4); 
    Idx(1, :) = 1:4; 
    Idx(2, :) = 5:8; 
    Idx(3, :) = 9:12; 
    Idx(4, :) = (1:4) + 16; 
    Idx(5, :) = (5:8) + 16; 
    Idx(6, :) = (9:12) + 16; 
    Idx(7, :) = (1:4) + 32; 
    Idx(8, :) = (5:8) + 32; 
    Idx(9, :) = (9:12) + 32; 
    Trt1_tag = {'DEX', 'DEX', 'DEX', 'OHT', 'OHT', 'OHT', 'LUC', 'LUC', 'LUC'}; 
    Trt2_tag = {'LUC', 'OHT', 'DEX', 'LUC', 'OHT', 'DEX', 'LUC', 'OHT', 'DEX'};
elseif strcmp(LINE_NAME, 'TKK489-8-8')
	%  TKK489-8-8 (09/26/2016) -- Toggle 2.0 
    Plant_Idx = 1:1:7; 
    Num_plants = 3; 
    Idx = 1:21; 
    Idx = reshape(Idx, [3, 7]); 
    Idx = Idx'; 
    Trt1_tag = {'DEX', 'DEX', 'DEX', 'LUC', 'OHT', 'OHT', 'OHT'}; 
    Trt2_tag = {'LUC', 'OHT', 'DEX', 'LUC', 'LUC', 'OHT', 'DEX'};
%  ------------------------------------------------------------------------
elseif strcmp(LINE_NAME, 'TKK690-2-T1') 
    %  TKK690-2-T1 (8/3/2016) -- Heterozygous line of Toggle 2.1 
    Plant_Idx = 1:1:7; 
    Num_plants = 3; 
    Idx = zeros(7, 3);
    Idx(1, :) = 13:15; 
    Idx(2, :) = 16:18; 
    Idx(3, :) = 19:21; 
    Idx(4, :) = 1:3; 
    Idx(5, :) = 4:6; 
    Idx(6, :) = 7:9; 
    Idx(7, :) = 10:12; 
    Trt1_tag = {'DEX', 'DEX', 'DEX', 'LUC', 'OHT', 'OHT', 'OHT'}; 
    Trt2_tag = {'LUC', 'OHT', 'DEX', 'LUC', 'LUC', 'OHT', 'DEX'};
elseif strcmp(LINE_NAME, 'TKK690-2-6')
    %  TKK690-2-6 (10/05/2016) -- Toggle 2.1 (homozygous) 
    Plant_Idx = 1:1:7; 
    Num_plants = 3; 
    Idx = 1:21; 
    Idx = reshape(Idx, [3, 7]); 
    Idx = Idx'; 
    Trt1_tag = {'DEX', 'DEX', 'DEX', 'LUC', 'OHT', 'OHT', 'OHT'}; 
    Trt2_tag = {'LUC', 'OHT', 'DEX', 'LUC', 'LUC', 'OHT', 'DEX'};
end

info = {}; 
% info.idx  = []; 
% info.Trt1 = {}; 
% info.Trt2 = {}; 
[row, col] = size(Idx); 
for ii = 1:row
    for jj = 1:col
        info_idx = Idx(ii, jj); 
        info(info_idx).idx  = info_idx; 
        info(info_idx).Trt1 = Trt1_tag{ii}; 
        info(info_idx).Trt2 = Trt2_tag{ii}; 
    end
end
%  We define OHT as our inducer 1 and DEX the inducer 2 
%  Therefore, 
%  OHT: [1, 0]
%  DEX: [0, 1]
%  LUC: [0, 0]
%  ------------------------------------------------------------------------
%%
Num_Trts = length(Plant_Idx); 
Plant = {}; 
for ii = 1:Num_Trts 
    if strcmp(LINE_NAME, 'Toggle2-5-39') && ii == 5 
        Num_plants = 3;
    elseif strcmp(LINE_NAME, 'Toggle2-5-39') && ii ~= 5 
        Num_plants = 4;
    end
    for jj = 1:Num_plants 
        Folder_Name = [LINE_NAME, '_', Prefix, '_Plant_Index_', sprintf('%d', Idx(Plant_Idx(ii), jj))]; 
        Path1 = fullfile(LINE_NAME, [Folder_Name, '.txt']); 
        delimiterIn = '\t'; 
        headerlinesIn = 1; 
        AA = importdata(Path1, delimiterIn, headerlinesIn); 
        [Num_Days, ~] = size(AA. data); 
        % Create time axis for the experiments 
        if  strcmp(LINE_NAME, 'TKK690-2-6')
            %  TKK690-2-6 (10/05/2016)
            %  The time axis of Toggle 2.1 is different that there is no day 11
            %  but there is day 12. 
            Plant(ii).xx = [0:(Num_Days-2), Num_Days];
             
        else  % strcmp(LINE_NAME, 'Toggle2-5-49') || strcmp(LINE_NAME, 'TKK489-8-8')
            %  Toggle2-5-49 (06/15/2015) OR TKK489-8-8 (09/26/2016)
            Plant(ii).xx = 0:(Num_Days-1);
        end
        Log_mean = AA. data(:, 5); 
        if jj == 1
            if strcmp(LINE_NAME, 'Toggle2-5-39') && ii == 5 
                All_Plants = zeros(Num_Days, Num_plants + 1); 
            else 
                All_Plants = zeros(Num_Days, Num_plants); 
            end
        end
        All_Plants(:, jj) = 2.^Log_mean; 
    end
        
        
        Plant(ii).Trt1 = info(Idx(Plant_Idx(ii), jj)).Trt1; 
        Plant(ii).Trt2 = info(Idx(Plant_Idx(ii), jj)).Trt2; 
        Plant(ii).All  = All_Plants; 
        if strcmp(LINE_NAME, 'Toggle2-5-39') && ii == 5 
            Plant(ii).mean  = geomean(All_Plants(:, 1:3), 2);
        else 
            Plant(ii).mean  = geomean(All_Plants, 2); 
        end
        Plant(ii).yy      = zeros(size(Log_mean)); 
        TrtID   = zeros(Num_Days, 2); 
        for jj = 1:Num_Days 
            if (jj-1) <= Day_Induce % First inducer 
                Trt_now = info(Plant_Idx(ii)).Trt1; 
            else % Second inducer 
                Trt_now = info(Plant_Idx(ii)).Trt2; 
            end

            if strcmp(Trt_now, 'OHT')
                TrtID(jj, :) = [1, 0]; 
            elseif strcmp(Trt_now, 'DEX')
                TrtID(jj, :) = [0, 1];
            elseif strcmp(Trt_now, 'LUC')
                TrtID(jj, :) = [0, 0];
            end
        end
        Plant(ii).TrtID  = TrtID; 
            
     figure 
     for jj = 1:Num_plants 
         scatter(Plant(ii).xx, All_Plants(:, jj))
         hold on 
     end
     scatter(Plant(ii).xx, Plant(ii).mean, 'filled')
     hold off
     set(gca, 'YScale', 'log')
%     figure 
%     plot(1:1:row, 2.^Log_mean)
%     hold on 
%     plot(1:1:row, 2.^(Log_mean+Log_std), '--')
%     plot(1:1:row, 2.^(Log_mean-Log_std), '--')
%     hold off
%     set(gca, 'YScale', 'log')
%     title([info(Plant_Idx(ii)).Trt1, '-', info(Plant_Idx(ii)).Trt2])
end

% Till here, we are done with preparing with 
 






    
    
    
    
    
    
    
    
    
    
    