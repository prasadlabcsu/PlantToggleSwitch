%% Mega Shell of MCMC parameter estimation using whole plant imaging data 
%  June 7, 2017 
%  Wenlong Xu
%  Prasad Group 
%  Colorado State Univ
%  ------------------------------------------------------------------------
% info for Toggle2-5-49 (Toggle 1.0)
% LINE_NAME = 'Toggle2-5-49';
%  ------------------------------------------------------------------------
% info for Toggle2-5-39 (Less used transgenic line of Toggle 1.0)
% LINE_NAME = 'Toggle2-5-39';
%  ------------------------------------------------------------------------
% info for Toggle2-5-65 (Less used transgenic line of Toggle 1.0)
% LINE_NAME = 'Toggle2-5-65';
%  ------------------------------------------------------------------------
% info for TKK489-8-8 (Toggle 2.0)
% LINE_NAME = 'TKK489-8-8';
%  ------------------------------------------------------------------------
% Info for: TKK690-2-T1 (8/3/2016) -- Heterozygous line of Toggle 2.1
% LINE_NAME = 'TKK690-2-T1';
%  ------------------------------------------------------------------------
% info for TKK690-2-6 (Toggle 2.1)
% LINE_NAME = 'TKK690-2-6';

%  ------------------------------------------------------------------------
%  Repeat the random sampling MCMC on Toggle 1.0 
LINE_NAME = 'Toggle2-5-49';
Prefix = 'Leaves'; 
M = 1000; 
MCMC_Shell_v5_3_func(LINE_NAME, Prefix, M)
clear all; close all; clc; 

LINE_NAME = 'Toggle2-5-49';
Prefix = 'Roots'; 
M = 1000; 
MCMC_Shell_v5_3_func(LINE_NAME, Prefix, M)
clear all; close all; clc; 

%  ------------------------------------------------------------------------
%  Run the random sampling MCMC on the non-essential transgenic lines 
LINE_NAME = 'TKK690-2-T1';
Prefix = 'Leaves'; 
M = 1000; 
MCMC_Shell_v5_3_func(LINE_NAME, Prefix, M)
clear all; close all; clc; 

LINE_NAME = 'TKK690-2-T1';
Prefix = 'Roots'; 
M = 1000; 
MCMC_Shell_v5_3_func(LINE_NAME, Prefix, M)
clear all; close all; clc;  

LINE_NAME = 'Toggle2-5-39';
Prefix = 'Leaves'; 
M = 1000; 
MCMC_Shell_v5_3_func(LINE_NAME, Prefix, M)
clear all; close all; clc; 

LINE_NAME = 'Toggle2-5-39';
Prefix = 'Roots'; 
M = 1000; 
MCMC_Shell_v5_3_func(LINE_NAME, Prefix, M)
clear all; close all; clc; 

LINE_NAME = 'Toggle2-5-65';
Prefix = 'Leaves'; 
M = 1000; 
MCMC_Shell_v5_3_func(LINE_NAME, Prefix, M)
clear all; close all; clc; 

LINE_NAME = 'Toggle2-5-65';
Prefix = 'Roots'; 
M = 1000; 
MCMC_Shell_v5_3_func(LINE_NAME, Prefix, M)
clear all; close all; clc; 
% -------------------------------------------------------------------------
% Match all random sampling runs to 5000 
LINE_NAME = 'TKK690-2-6';
Prefix = 'Leaves'; 
M = 4000; 
MCMC_Shell_v5_3_func(LINE_NAME, Prefix, M)
clear all; close all; clc; 

LINE_NAME = 'TKK489-8-8';
Prefix = 'Leaves'; 
M = 4000; 
MCMC_Shell_v5_3_func(LINE_NAME, Prefix, M)
clear all; close all; clc; 

LINE_NAME = 'TKK489-8-8';
Prefix = 'Roots'; 
M = 4000; 
MCMC_Shell_v5_3_func(LINE_NAME, Prefix, M)
clear all; close all; clc; 

LINE_NAME = 'Toggle2-5-49';
Prefix = 'Leaves'; 
M = 4000; 
MCMC_Shell_v5_3_func(LINE_NAME, Prefix, M)
clear all; close all; clc; 

LINE_NAME = 'Toggle2-5-49';
Prefix = 'Roots'; 
M = 4000; 
MCMC_Shell_v5_3_func(LINE_NAME, Prefix, M)
clear all; close all; clc; 

LINE_NAME = 'TKK690-2-T1';
Prefix = 'Leaves'; 
M = 4000; 
MCMC_Shell_v5_3_func(LINE_NAME, Prefix, M)
clear all; close all; clc; 

LINE_NAME = 'TKK690-2-T1';
Prefix = 'Roots'; 
M = 4000; 
MCMC_Shell_v5_3_func(LINE_NAME, Prefix, M)
clear all; close all; clc;  

LINE_NAME = 'Toggle2-5-39';
Prefix = 'Leaves'; 
M = 4000; 
MCMC_Shell_v5_3_func(LINE_NAME, Prefix, M)
clear all; close all; clc; 

LINE_NAME = 'Toggle2-5-39';
Prefix = 'Roots'; 
M = 4000; 
MCMC_Shell_v5_3_func(LINE_NAME, Prefix, M)
clear all; close all; clc; 

LINE_NAME = 'Toggle2-5-65';
Prefix = 'Leaves'; 
M = 4000; 
MCMC_Shell_v5_3_func(LINE_NAME, Prefix, M)
clear all; close all; clc; 

LINE_NAME = 'Toggle2-5-65';
Prefix = 'Roots'; 
M = 4000; 
MCMC_Shell_v5_3_func(LINE_NAME, Prefix, M)
clear all; close all; clc; 










