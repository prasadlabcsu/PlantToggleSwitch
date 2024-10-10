%% Function to Get the Leaves Mask from Green and Blue Channels 
%  Wenlong Xu
%  July 21, 2014 
%  ------------------------------------------------------------------------
%% Introdution
% This meathod is based on:
% Leaf colors is characterized by HIGH Green and LOW Blue
% Background and Roots are kind-of equal in Green and Blue Channels 
%  The roots in between the leaves are always hard to detect. 
%  It is necessary and important to remove these parts to make sure they
%  will be included in the Roots Mask. Accurate Masks are fundenmental for
%  accuracy in our final results. 
%  After some trials, it was found (Green+10/Blue+10)/(Red+10/Blue+10)
%  Before this function was writen, removing these parts are highly depends
%  on manual cutting afterwards. 
% Inputs & Outputs
% IN  -- High-Resolution GRB Image by Digital Camera
% OUT -- Logical Matrix Containing Raw Leaves Mask 
% TH1 -- Threshold for G2B ratio
% TH2 -- Threshold for G2R ratio
%  ------------------------------------------------------------------------
%% 
function OUT = Raw_Leaves_Mask(IN, TH2)
    TH1 = 1.5;  
    IN = double(IN); 
    G2B = (IN(:, :, 2)+10)./(IN(:, :, 3)+10); 
    % Possible to get Inf from this operation
%     [N_row, N_col] = size(G2B); 
%     for ii = 1:1:N_row
%         ROW = G2B(ii, :); 
%         Index_Inf = find(isinf(ROW)==1); 
%         if ~isempty(Index_Inf)
%             G2B(ii.*ones(1, length(Index_Inf)), Index_Inf) = 100; 
%         end
%     end
    OUT1 = G2B > TH1; 
    
    G2R = ((IN(:, :, 2)+10)./(IN(:, :, 3)+10))./((IN(:, :, 1)+10)./(IN(:, :, 3)+10)); 
    OUT2 = G2R > TH2; 
    OUT = OUT1 & OUT2; 
end