%% Toggle switch 
%  March 6, 2017 
%  Wenlong Xu 
%  Prasad group 
%  Colorado State Univ. 
%  ------------------------------------------------------------------------
%% Version info 
%  v0: This is the original toggle switch with inducible promoter 
%  v1: this is a simplified toggle switch: 
%       1. We assume no leaky expression of the repressible promoter; 
%       2. We assume the inducers act directly on the toggle switch like a
%       leaky expression term in the toggle switch formulation. 
%  v2: Strengthes of induction also left as free parameters. 
%      Simulate the whole curve day-by-day based on the TrtID. 
%  v3: Degradation rate constant is set to 2 rather than estimated from the
%      experimental data. 
function dydt = toggle_func_v4(t, y, flag, para) 
% onoff1 and onoff2 are used as binary switches for the inducible promoter.
% alpha1 and alpha2 are used as inducible terms. 
% alpha3 and alpha4 are the leaky expression terms. 
% 
onoff1 = para(1); 
onoff2 = para(2); 
alpha1 = para(3); 
alpha2 = para(4); 
alpha3 = para(5); 
alpha4 = para(6); 
beta1  = para(7); 
beta2  = para(8); 
K1     = para(9); 
K2     = para(10); 
n1     = para(11);
n2     = para(12); 
D      = 2; 

dydt = zeros(2, 1); 
% u
dydt(1) = onoff1 * alpha1 + alpha3 + beta1/(1 + (y(2)/K1)^n1) - D * y(1); 
% v 
dydt(2) = onoff2 * alpha2 + alpha4 + beta2/(1 + (y(1)/K2)^n2) - D * y(2); 
end % end of function 