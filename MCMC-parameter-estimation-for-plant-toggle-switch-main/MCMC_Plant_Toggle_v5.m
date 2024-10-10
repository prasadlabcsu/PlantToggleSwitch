function YY = MCMC_Plant_Toggle_v5(P, DI, xx)
% In this version, Memory will be simulated. 
% In the version 1.2, leaky expression terms were added back to the model. 

% Version 3 
% Reduce the amount of calling ode solver by combine same treatments. 
% DI -- Day of induction 

% 1st period to let the plant toggle reach steady state. 
% The initial state is assumed to be the OFF state. 
% Plant is the structure array contains all information about the plants. 

%  The matrix is organized by rows, each row corresponds to one treatment:
%  DEX-->LUC, 
%  DEX-->OHT, 
%  DEX-->DEX 
%  LUC-->LUC
%  OHT-->LUC, 
%  OHT-->OHT, 
%  OHT-->DEX
%  We define OHT as our inducer 1 and DEX the inducer 2 
%  Therefore, 
%  OHT: [1, 0]
%  DEX: [0, 1]
%  LUC: [0, 0]
%  Version 5 
%  Fix the degradation rate constant to 2, thus reduce one degree of
%  freedom. 'toggle_func_v4' is used rather than 'toggle_func_v2'. 
x0 = P(1:2); 
Num_Plants = 7; 
YY = zeros(length(xx), Num_Plants);  
% Initialization 
para = [[0, 0], P(3:end)]; 
options = [];
DeltaT = 1; 
[t0, y0] = ode23('toggle_func_v4', [0, DeltaT], x0, options, para); 
% Inducer 1 
x0 = y0(end, 1:2); 
            %1)DEX;2)LUC;3)OHT 
This_TrtID1 = [0, 1; 0, 0; 1, 0]; 
DeltaT = DI; 
tt1 = {};
uu1 = {};
vv1 = {};
for ii = 1:3 
    para = [This_TrtID1(ii, :), P(3:end)]; 
    [t1, y1] = ode23('toggle_func_v4', [0, DeltaT], x0, options, para); 
    tt1{ii} = t1;
    uu1{ii} = y1(:, 1);
    vv1{ii} = y1(:, 2);
end
            %1)DEX;2)DEX;3)DEX;4)LUC;5)OHT;6)OHT;7)OHT; 
    Trt_Idx = [1,    1,    1,    2,    3,    3,    3]; 
            %1)LUC;2)OHT;3)DEX;4)LUC;5)LUC;6)OHT;7)DEX; 
This_TrtID2 = [0, 0; 1, 0; 0, 1; 0, 0; 0, 0; 1, 0; 0, 1]; 

DeltaT = xx(end) - DI; 
tt2 = {};
uu2 = {};
vv2 = {};
for ii = 1:7
    para = [This_TrtID2(ii, :), P(3:end)]; 
    x0 = [uu1{Trt_Idx(ii)}(end), vv1{Trt_Idx(ii)}(end)]; 
    options = [];
    [t2, y2] = ode23('toggle_func_v4', [0, DeltaT], x0, options, para);
    tt2{ii} = t2;
    uu2{ii} = y2(:, 1);
    vv2{ii} = y2(:, 2);
end
% Combine the two parts into one trajectory 
for ii = 1:7 
    tt = []; 
    uu = []; 
    tt = cat(1, tt1{Trt_Idx(ii)}(1:(end-1)), tt2{ii} + DI); 
    uu = cat(1, uu1{Trt_Idx(ii)}(1:(end-1)), uu2{ii}); 
    yy = spline(tt, uu, xx'); 
    YY(:, ii) = yy; 
end

%% 

% figure 
% plot(tt, uu, 'b', tt, vv, 'r')
% hold on 
% scatter(xx', yy, 'r', 'filled')
% 
% xlabel('\tau'); 
% ylabel('concentration'); 
% legend('u', 'v'); 


end % end of function 