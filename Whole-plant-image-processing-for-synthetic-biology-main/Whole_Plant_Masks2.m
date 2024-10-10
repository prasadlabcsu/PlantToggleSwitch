%% Shell Codes for the Whole-Plant Image Processing 
%  Wenlong Xu
%  Aug 5, 2014 
%  Version 7 Updated on May 3, 2017  
%  Version 7.1 Updated on May, 30, 2017 
%  ------------------------------------------------------------------------
% [FileName, Dir, ~] = uigetfile({'*.jpg;*.tif;*.png;*.gif','All Image Files';...
%           '*.*','All Files' },'Select Images',...
%           'C:\Users\xuwl\Desktop\MLB101-SC_Induced T6_000_BF', 'MultiSelect', 'on'); 
% 
% Color_Image = imread(fullfile(Dir, FileName{2})); 
% Color_Image = Color_Image(:, :, 1:3); 
% 
% BF_Image = imread(fullfile(Dir, FileName{1})); 
% BF_Image = BF_Image(:, :, 1:3); 


function [Plant_Info, Registered_Leaves2, Registered_Roots2] = ...
    Whole_Plant_Masks2(Color_Image, BF_Image, Dir)
global Leaves_Threshold2 Root_Threshold
% If the Color Image and BF Image are larger in dimensionality than
% expected, only the first 3 dimensions are kept. 
[row, col, D3] = size(Color_Image); 
if D3 > 3 
    Color_Image = Color_Image(:, :, 1:3); 
end

[~, ~, D3] = size(BF_Image); 
if D3 > 3 
    BF_Image = BF_Image(:, :, 1:3); 
end
%%  ------------------------------------------------------------------------
% Select ROI containing plants of interests. 
% Make sure to have a ROI as small as possible and do not have objects
% unwanted, like the edges of the plate. 
f1 = figure;  
set(gcf, 'Position', get(0, 'ScreenSize'))
imshow(Color_Image)
text(col/2, 50, 'Select ROI', 'FontSize', 20, 'FontWeight', 'Bold', 'Color', 'White', 'HorizontalAlignment', 'center'); 
handle_roi = imrect; 

ROI = wait(handle_roi); 
BW = createMask(handle_roi); 
close(f1); 
%%  ------------------------------------------------------------------------
% Threshold for leaves and make mannual adjustment if necessary 
Color_Image2 = imcrop(Color_Image, ROI); 
f1 = Get_Leaves_Mask2(Color_Image2); 
uiwait(f1); 
Leaves_Mask = Raw_Leaves_Mask(Color_Image2, Leaves_Threshold2);

[Refined_Leaves, ~] = Mask_Examing_and_Processing3('Leaves', Leaves_Mask, Leaves_Mask, Color_Image2, 0, ' ', 0, 0); 
%%  ------------------------------------------------------------------------
% Threshold for roots and make mannual adjustment if necessary 
f3 = Get_Roots_Mask2(Color_Image2); 
uiwait(f3); 

Red_Channel = Color_Image2(:, :, 1); 
Green_Channel = Color_Image2(:, :, 2); 
Finding_roots = Red_Channel + Green_Channel; 

Roots_Mask = im2bw(Finding_roots, Root_Threshold); 
% f4 = figure;  
% imshow(Roots_Mask)
% close(f4); 

Roots_Mask2 = Roots_Mask & ~Refined_Leaves; 
Refined_Roots = imclearborder(Roots_Mask2,8); 
Refined_Roots = Remove_Background_noise(Refined_Roots, 1, 5e-5*numel(Roots_Mask)); 

[Refined_Roots2, ~] = Mask_Examing_and_Processing3('Root', Refined_Roots, Roots_Mask2, Color_Image2, 0, ' ', 0, 0); 

%%  ------------------------------------------------------------------------
% Using image registration to align the color image and BF image together. 
[Registered_Leaves, Registered_Roots] = Mask_Fitting2(Color_Image2, BF_Image, Refined_Leaves, Refined_Roots2); 
Registered_Leaves = Registered_Leaves > 0.1; 
Registered_Roots  = Registered_Roots > 0.1; 

%%  ------------------------------------------------------------------------
% Group the leaves and roots into corresponding plants. 
Plant_Info = Plant_Num_and_Index2(); 
[Registered_Leaves2, Plant_Info] = Mask_Examing_and_Processing3('Leaves', Registered_Leaves, Registered_Leaves, BF_Image, 1, Dir, 1, Plant_Info); 
[Registered_Roots2, Plant_Info]  = Mask_Examing_and_Processing3('Roots',  Registered_Roots,  Registered_Roots,  BF_Image, 1, Dir, 1, Plant_Info);  

% end % end of function 


