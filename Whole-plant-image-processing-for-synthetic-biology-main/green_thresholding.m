function Out = green_thresholding(originalImage, Leaves_Threshold2)

[d1, d2, d3] = size(originalImage);

Raw_Leaves = Raw_Leaves_Mask(originalImage, Leaves_Threshold2);
Refined_Leaves = Remove_Background_noise(Raw_Leaves, 1, 5e-5*numel(Raw_Leaves));
Display_Mask = cast(Refined_Leaves, class(originalImage));

Display_Mask = repmat(Display_Mask, [1, 1, d3]);
Out = Display_Mask.*originalImage;