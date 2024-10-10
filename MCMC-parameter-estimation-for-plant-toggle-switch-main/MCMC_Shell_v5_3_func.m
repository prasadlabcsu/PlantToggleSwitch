%% Shell of MCMC parameter estimation using whole plant imaging data 
%  May 2, 2017 
%  Wenlong Xu
%  Prasad Group 
%  Colorado State Univ
%  ------------------------------------------------------------------------
%% Functionalized on June 7, 2018 to automate the scheduled MCMC runs 
% Plants need to be arranged by:  
%  DEX-->LUC, 
%  DEX-->OHT, 
%  DEX-->DEX 
%  LUC-->LUC
%  OHT-->LUC, 
%  OHT-->OHT, 
%  OHT-->DEX
function MCMC_Shell_v5_3_func(LINE_NAME, Prefix, M)
%  ------------------------------------------------------------------------
if strcmp(LINE_NAME, 'TKK489-8-8') 
    % info for TKK489-8-8 (Toggle 2.0)
    Plant_Matrix = 1:21;
    Plant_Matrix = reshape(Plant_Matrix, [3, 7]); % Plants used for TKK690-2-6; 
    Plant_Matrix = Plant_Matrix'; 
elseif strcmp(LINE_NAME, 'TKK690-2-6') 
    % info for TKK690-2-6 (Toggle 2.1)
    Plant_Matrix = 1:21;
    Plant_Matrix = reshape(Plant_Matrix, [3, 7]); % Plants used for TKK690-2-6; 
    Plant_Matrix = Plant_Matrix'; 
elseif strcmp(LINE_NAME, 'Toggle2-5-49') 
    % info for Toggle2-5-49 (Toggle 1.0)
    Plant_Matrix = zeros(7, 4);
    Plant_Matrix(1, :) = 1:4;
    Plant_Matrix(2, :) = 5:8;
    Plant_Matrix(3, :) = 9:12;
    Plant_Matrix(4, :) = (1:4) + 32;
    Plant_Matrix(5, :) = [2, 3, 5, 6] + 16;
    Plant_Matrix(6, :) = (8:11) + 16;
    Plant_Matrix(7, :) = (12:15) + 16; 
elseif strcmp(LINE_NAME, 'Toggle2-5-39') 
    % info for Toggle2-5-39 (Less used transgenic line of Toggle 1.0)
    Plant_Matrix = zeros(9, 4);
    Plant_Matrix(1, :) = 1:4;
    Plant_Matrix(2, :) = 5:8;
    Plant_Matrix(3, :) = 9:12;
    Plant_Matrix(4, :) = (1:4) + 32;
    Plant_Matrix(5, :) = [1, 2, 4, 5] + 16;
    Plant_Matrix(6, :) = (6:9) + 16;
    Plant_Matrix(7, :) = (10:13) + 16;
elseif strcmp(LINE_NAME, 'Toggle2-5-65') 
    % info for Toggle2-5-65 (Less used transgenic line of Toggle 1.0)
    Plant_Matrix = zeros(9, 4);
    Plant_Matrix(1, :) = 1:4;
    Plant_Matrix(2, :) = 5:8;
    Plant_Matrix(3, :) = 9:12;
    Plant_Matrix(4, :) = (1:4) + 32;
    Plant_Matrix(5, :) = (1:4) + 16;
    Plant_Matrix(6, :) = (5:8) + 16;
    Plant_Matrix(7, :) = (9:12) + 16;
elseif strcmp(LINE_NAME, 'TKK690-2-T1') 
    % Info for: TKK690-2-T1 (8/3/2016) -- Heterozygous line of Toggle 2.1
    Plant_Matrix = zeros(7, 3);
    Plant_Matrix(1, :) = 13:15;
    Plant_Matrix(2, :) = 16:18;
    Plant_Matrix(3, :) = 19:21;
    Plant_Matrix(4, :) = 1:3;
    Plant_Matrix(5, :) = 4:6;
    Plant_Matrix(6, :) = 7:9;
    Plant_Matrix(7, :) = 10:12;
end 
 
%  Number of repeatation
% M = 1000; 
Day_Induce = 4; % Counting from Day 0 
%  Number of iteration steps 
N = 10000;  
%  Number of parameters 
N_para = 13;  

% [all_para, all_Lsq, all_flag, all_iteration] = MCMC_v5(Plant, M, N, N_para, If_display); 
% [all_para, all_Lsq, all_flag, all_iteration] = MCMC_v5_par(Plant, M, N, N_para); 
% [all_para, all_Lsq, all_flag, all_iteration, all_plant] = MCMC_v5_3_par(M, N, N_para, LINE_NAME, Plant_Matrix, Day_Induce, Prefix); 
[all_para, all_Lsq, all_flag, all_iteration, all_plant] = MCMC_v5_3_par(M, N, N_para, LINE_NAME, Plant_Matrix, Day_Induce, Prefix); 
% [all_para, all_Lsq, all_flag, all_iteration] = MCMC_v5_1(Plant, M, N, N_para, Day_Induce, 1); 

% Output the parameters fitted 

out1 = fopen(['Parameters_MCMC_v5_3_', LINE_NAME, '_', Prefix, '_', Date, '.txt'], 'w'); 
for ii = 1: M 
    for jj = 1:N_para
        fprintf(out1, '%f\t ', all_para(ii, jj)); 
    end
    fprintf(out1, '%f\t %d\t %d\t', all_Lsq(ii), all_flag(ii), all_iteration(ii)); 
    for jj = 1:7 
        fprintf(out1, '%d\t ', all_plant(ii, jj)); 
    end
    fprintf(out1, '\n'); 
end
fclose(out1); 

end 
