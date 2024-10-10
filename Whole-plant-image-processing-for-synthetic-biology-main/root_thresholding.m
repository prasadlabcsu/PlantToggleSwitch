

function Out = root_thresholding(originalImage, Root_Threshold)


Red_Channel = originalImage(:, :, 1); 
Green_Channel = originalImage(:, :, 2); 
Finding_roots = Red_Channel + Green_Channel; 

BW_Finding_roots = im2bw(Finding_roots, Root_Threshold); 
Display_Mask = cast(BW_Finding_roots, class(originalImage));
[~, ~, m3] = size(originalImage);
Display_Mask = repmat(Display_Mask, [1, 1, m3]);
Out = Display_Mask.*originalImage;