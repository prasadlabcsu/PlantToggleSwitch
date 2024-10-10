%% Calculate the Goodness of Fit using the structured data 
%  May 2, 2017 
%  Wenlong Xu 
%  Prasad group 
%  Colorado State Univ. 
%  ------------------------------------------------------------------------
function Lsq = gof_calculation(Data, YY)
    [~, Num_Plants] = size(Data); 
    GOF = zeros(1, Num_Plants); 
    for ii = 1:Num_Plants
        GOF(ii) = sum((log(YY(:, ii)) - log(Data(:, ii))).^2);  
    end
    
    w = [1, 4, 1, 1, 4, 2, 4]; 
    Lsq = - log(mean(GOF.*w)); 
end