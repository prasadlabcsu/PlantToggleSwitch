%% MCMC minimization of the least square between modeling and data 
%  April 19, 2017 
%  Wenlong Xu 
%  Prasad group 
%  Colorado State Univ. 
%  ------------------------------------------------------------------------
%% Version info 
%  Version 3 (April 21, 2017)
%  1. Sample: 
%  This version still tries to fit to the synthetic experimental data of 
%  one side of the simplest toggle switch tested in one treatment. 
%  
%  2. Major Modifications (Compared to Version 2): 
%  This version put back the random acceptance of the bad proposals to
%  overcome getting trapped in some local minima. This was a silly mistake,
%  that the log(u), where u is always smaller than 1, so this was always a
%  negative number. This means that we always accepted the bad parameter
%  sets in the version 1. 
%  
%  3. Minor Modifications compared to Version 1 (same as Version 2): 
%  1) Apply the upper and lower bounds of the parameters in the proposing
%  step for the displacement using a one-sided normal distribution; 
%  2) A better criterion of -log(sqaured distance + 1) to ensure the sharp
%  border of 0 for the criterion. 
%
%  Version 3.1 (April 23, 2017)
%  In this version, the input synthetic experimental data are from two
%  treatments, one is same as in version 3 the Memory test, the other one
%  being ON2OFF. Information of the Memory is in variable yy and
%  information of the ON2OFF is in variable yyy. 
%  
%  Version 3.2 (April 24, 2017)
%  In this version, leaky expression terms of the toggle switch were added.
%  Everything else will be kept same for comparison. 
%
%  Version 4.2 (April 25, 2017)
%  
%  Version 4.3 (April 27, 2017)
%  Due to the inaccuracy shown in the results of Version 4.2, we add one
%  more "synthetic" experimental data, the treatment of OFF2ON. 
%  The information in OFF2ON is in variable yyyy. 
%  
%  Version 5 (May 1, 2017)
%  Modified to handle the experimental data fed in as a structured array. 
%  
%  Version 5 par (May 2, 2017)
%  This is a version using parallel computing toolbox. parfor
%% Details on the system to fit: 

%% Initiate the MCMC 

% What are the parameters? 
% para = [IC1, IC2, alpha1, alpha2, alpha3, alpha4, beta1, beta2, K1, K2, n1, n2, D]; 
% IC1,    IC2    -- initial conditions 
% alpha1, alpha2 -- inducible terms 
% alpha3, alpha4 -- leaky expression 
% beta1,  beta2  -- maximal expression level 
% K1,     K2     -- repressor level to have half of the maximal level 
% n1,     n2     -- Hill coefficients 
% D              -- degradation rate 
% What are good ranges of parameter values? 
% Average protein degradation in Arabidopsis grown at 20C and 28C: 
% 20C -- 3.5 days -- 0.2 day-1
% 28C -- 2.99 days-- 0.232 day-1 
% So D = [0, 2]; 
% n = [0, 6]; 
% all the others can be set based on the maximal expression level we have. 

% % Inputs 
% %  Number of repeatation
% M = 1; 
% %  Number of iteration steps 
% N = 100;  
% %  Number of parameters 
% N_para = 13; 
function [all_para, all_Lsq, all_flag, all_iter] = MCMC_v5_par(Plant, M, N, N_para)
GOF_thresh = -1; 
It_equil_thresh = 500; 
% Prefactor multiplying the threshold to accept a bad proposal 
Bf = 1; 

%  Extract info from the structure Plant 
Num_Plants = length(Plant); 
Num_Days = length(Plant(1).mean); 
MaxL_vec = zeros(1, Num_Plants); 
MinL_vec = zeros(1, Num_Plants); 
M_TrtID  = zeros(Num_Days, 2, Num_Plants);  
Data     = zeros(Num_Days, Num_Plants);  
for ii = 1:Num_Plants
    MaxL_vec(ii) = max(Plant(ii).mean);
    MinL_vec(ii) = min(Plant(ii).mean); 
    Data(:, ii)  = Plant(ii).mean; 
    M_TrtID(:, :, ii) = Plant(ii).TrtID; 
    
end
MaxL = max(MaxL_vec); 
MinL = min(MinL_vec); 
IC1  = mean(Data(1, :)); 

% This is the x-axis of the experimental data (days)
xx = 0:(Num_Days-1); 

upper_B = [2*MinL, MaxL, MaxL, MaxL, 0.1*MaxL, 0.1*MaxL, 2*MaxL, 2*MaxL, MaxL, MaxL, 6, 6, 5]; 
lower_B = zeros(1, N_para); 
%% 

all_para = zeros(M, N_para); 
all_Lsq  = zeros(1, M); 
all_flag = zeros(1, M); 
all_iter = zeros(1, M); 
pocket = zeros(1, N_para + 2); 
% Range of biologically relevant parameters 
% para = [IC1, IC2, alpha1, alpha2, alpha3, alpha4, beta1, beta2, K1, K2, n1, n2, D]; 

scale = 1e-2.*upper_B; 

c = parcluster; 
poolobj = parpool(c); 
%% 
parfor mm = 1: M 
    tic
%     fprintf('%d \n', mm); 
    %  We set the range of all the estimated parameter to be [0, 10]; 
    para0 = rand([1, N_para]) .* upper_B; 
    para0(1) = IC1; 
    YY0 = MCMC_Plant_Toggle_v2(para0, M_TrtID, xx); 
    
    % we want to maximize this likelihood: 
    gof0 = gof_calculation(Data, YY0); 
    %% Carry out the MCMC
    %  How to actually impose a range for the parameters? 
    
    
    para1 = para0; 
    gof1 = gof0; 
    pre_factor = abs(gof0); 
    pocket = [para0, gof0, 0]; 
    Count = 1; 
    V_Lsq1 = zeros(1, N); 
    Record = gof1; 
    Record_Count = 0; 
    If_Stop = 1; 
    while Count <= N && gof1 < GOF_thresh && If_Stop
%         fprintf('%d %f %d\n', Count, gof1, Record_Count);
        for jj = 1:N_para 
            disp = random('norm', 0, 1)*scale(jj); 
            para2 = para1; 
            para2(jj) = para2(jj) + disp; 
            % if the newly proposed parameter is beyond the range
            % specified, propose a new displacement 
            if para2(jj) < lower_B(jj)
                disp = abs(random('norm', 0, 1))*scale(jj); 
                para2 = para1; 
                para2(jj) = para2(jj) + disp; 
            elseif para2(jj) > upper_B(jj)
                disp = - abs(random('norm', 0, 1))*scale(jj);
                para2 = para1; 
                para2(jj) = para2(jj) + disp; 
            end
            YY2 = MCMC_Plant_Toggle_v2(para2, M_TrtID, xx); 
            gof2 = gof_calculation(Data, YY2); 
            if gof2 > gof1 
                pre_factor = Bf * abs(gof2 - gof1) * abs(gof2); 
                para1 = para2; 
                gof1 = gof2; 
                % Check our pocket and see if the new goodness of fit is
                % better than what we had. 
                if gof1 > pocket(N_para + 1)
                    pocket = [para1, gof1, Count]; 
                end
            else 
                u = rand(1); 
                if log(u + 1) <= pre_factor * (gof1 - gof2)
                    para1 = para2;
                    gof1 = gof2;
                end
            end
            
        end
         
        % Here we keep track of the iterations (Record) that no improvement
        % in estimator has been made. If a condition on this has been 
        % reached, we say a local minimum is reached.
        if abs(Record - gof1) <= 1e-4
            Record_Count = Record_Count + 1; 
        else 
            Record = gof1;
            Record_Count = 0; 
        end
        
        if Record_Count > It_equil_thresh
            If_Stop = 0;
        end
        
        V_Lsq1(Count) = gof1; 
        Count = Count + 1; 

    end 
    if Count > N 
        all_flag(mm) = 1; 
        para1 = pocket(1:N_para); 
        gof1 = pocket(N_para + 1); 
        Count = pocket(N_para + 2); 
    elseif gof1 >= GOF_thresh 
        all_flag(mm) = 2; 
    elseif ~If_Stop 
        all_flag(mm) = 3; 
    end
    
    all_para(mm, :) = para1; 
    all_Lsq(mm)  = gof1;   
    all_iter(mm) = Count; 
    
    ElapseT = toc; 
    fprintf('%d \t%f hrs\n', mm, ElapseT/3600); 
end    
delete(poolobj);
%% Output the parameters fitted 
% out1 = fopen('Parameters_MCMC_v5_1.txt', 'w'); 
% for ii = 1: M 
%     for jj = 1:N_para
%         fprintf(out1, '%f\t ', all_para(ii, jj)); 
%     end
%     fprintf(out1, '%f\t %d\t %d\n', all_Lsq(ii), all_flag(ii), all_iteration(ii)); 
% end
% fclose(out1); 








