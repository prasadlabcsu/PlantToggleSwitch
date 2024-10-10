%% Mask fitting function to align the Color Image to the BF Image 
%  Wenlong Xu
%  May 30, 2017 
%  ------------------------------------------------------------------------
function [Cropped_Leaves, Cropped_Roots] = Mask_Fitting2(Color_Image2, BF_Image, Refined_Leaves, Refined_Roots2) 
If_Proceed = 1; 

fixed = rgb2gray(BF_Image); 
moving = rgb2gray(Color_Image2); 

while If_Proceed == 1
    [moving_out,fixed_out] = cpselect(moving,fixed,'Wait', true);  
    tform = fitgeotrans(moving_out,fixed_out,'nonreflectivesimilarity'); 
    Coordinate = imref2d(size(fixed)); 
    Cropped_Whole = imwarp(moving, tform, 'OutputView', Coordinate); 
    f1 = figure; 
    imshowpair(Cropped_Whole, fixed)
    
    continue_or_not = questdlg('Are you satisfied with the mask mapping?', 'Mapping', 'Yes', 'No', 'Yes');
    switch continue_or_not
        case 'Yes'
            If_Proceed = 0;
        case 'No'
            If_Proceed = 1; 
    end
    close(f1); 
end

Cropped_Leaves = imwarp(Refined_Leaves, tform, 'OutputView', Coordinate);
% figure;
% imshowpair(fixed, Cropped_Leaves)

Cropped_Roots  = imwarp(Refined_Roots2, tform, 'OutputView', Coordinate);
% figure;
% imshowpair(fixed, Cropped_Roots)

end 