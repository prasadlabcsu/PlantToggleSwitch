%% Shell Codes for the Whole-Plant Image Processing (Data Generation)
%  Wenlong Xu
%  Aug 5, 2014 
%  Version 6 Updated on July 7, 2015 
%  ------------------------------------------------------------------------
%% Introduction 
%  The previous whole-plant image processing codes are functionalized and
%  the inputs and data analysis parts are separated from the function to
%  maximize the flexibility. 
%  The function is only limited to get the fitted whole-plant Masks to the 
%  Luc Images. The inputs of directories, folder names and parameters are
%  separated into this code. 
%  To make it easier to get the dynamics of the Luc Signal over the
%  collection time period, the data analysis is also separted. Therefore,
%  Data Analysis function can be invoked for several times with different 
%  "Record" Images as input.  
%  ------------------------------------------------------------------------
%% Version Info
%  Updated on Jan 23, 2015 
%  Updates: 
%  1) When recording the Fluc intensity, saturations were found due to the
%  data format. In previous versions, uint32 was used, which was updated
%  into uint64 to avoid the saturation. 
%  2) Masks are saved for each tissue of individual plants rather than the
%  tissues for all the plants on the plate. 
%  Version 6 
%  Updated on July 7, 2015 
%  Updates: 
%  In the lastest dataset, there are a lot of plants have a significant
%  portion of roots are outside of the grid on the bottom of the plate. In
%  this updates, we enlarge the root detection region to have more roots
%  included in the image processing. 
%  Version 7 
%  Updated on May 6, 2017 
%  In this version, the thresholding has been make into GUI with slide
%  bars. Mask alignment has been modified to a grid-independent manner
%  using image registration. 
%  In version 7, use Shell2.m rather than Shell.m 
%  Version 7.1 
%  Updated on May 30, 2017      
%  Based on Jeremy's feedback, there are two problems using Version 7. 
%  1) There are issues to find the right color images and bright-field Luc
%  images in the same folder. 
%  Solution: we make the entire code less streamlined by making the file
%  and folder selections manual. 
%  2) There may be bug on the image registration. 
%% Global variables for the GUI 
global Leaves_Threshold2 Root_Threshold
Leaves_Threshold2 = 1; 
Root_Threshold = 0.9; 
If_Dynamics = 1; 
%% Select the files to process 
%  First select the Color Image collected by a regular camera: 
% This is the default working directory to start with:  
if ~exist(Dir2, 'dir') && ispc 
    Dir1 = 'C:\'; 
elseif ~exist(Dir2, 'dir') && isunix 
    Dir1 = '/'; 
else 
    Dir1 = Dir2; 
end
    
[Color_FileName, BF_PathName, ~] = uigetfile({'*.jpg;*.tif;*.png;*.gif', 'All Image Files'; '*.*', 'All Files'}, ...
                                    'Select the COLOR Image Collected by a Regular Camera', ...
                                    Dir1); 
%  First select the Bright-Field Image collected by the Luciferase camera: 
Dir1 = BF_PathName; 
BFFileName = uigetfile({'*.jpg;*.tif;*.png;*.gif', 'All Image Files'; '*.*', 'All Files'}, ...
                                    'Select the Bright-Field Image Collected by the Luciferase Camera', ...
                                    Dir1); 
%  Then select the folder containing the Luciferase signals collected by
%  the Luciferase camera;  
sep = filesep; 
Idx3 = find(Dir1 == sep, 2, 'last'); 
Dir2 = Dir1(1:(Idx3-1)); 
luc_folder_name = uigetdir(Dir2, 'Select the Folder Containing the Corresponding Luciferase Images'); 

%% Read in the selected Color Image and Bright-Field Image 
BF_Image = imread(fullfile(BF_PathName, BFFileName)); 
Color_Image = imread(fullfile(BF_PathName, Color_FileName));

Pathway = BF_PathName;
[Plant_Info, Leaves_Mask, Roots_Mask] = Whole_Plant_Masks2(Color_Image, BF_Image, Pathway);

Whole_Mask = Leaves_Mask | Roots_Mask;
imwrite(Leaves_Mask, fullfile(BF_PathName, 'Leaves_Mask.bmp'));
imwrite(Roots_Mask,  fullfile(BF_PathName, 'Roots_Mask.bmp'));
imwrite(Whole_Mask,  fullfile(BF_PathName, 'Whole_Mask.bmp'));
%% 
PrintMode = 1;
Luc_Files = dir(fullfile(luc_folder_name, '*.tif'));
Num_Luc_Files = length(Luc_Files);
Idx4 = find(luc_folder_name == sep, 1, 'last'); 
Luc_Folder = luc_folder_name(Idx4+1:end); 
% Analyze each luc image to see the differences across time
if If_Dynamics
    for jj = 1:1:Num_Luc_Files
        Luc_File = Luc_Files(jj).name;
        Index2 = find(Luc_File == '.', 1, 'last');
        Luc_Index = Luc_File(Index2-2:Index2-1);
        Record = imread(fullfile(luc_folder_name, Luc_File));
        Record = uint64(Record);
        OutputFileName = [Luc_Folder, Luc_Index];
        Data_Analysis3(Plant_Info, Leaves_Mask, Roots_Mask, Record, PrintMode, Pathway, OutputFileName);
    end
end

for mm = 1:1:Num_Luc_Files
    LucImage = imread(fullfile(luc_folder_name, Luc_Files(mm).name));
    if mm == 1
        Record = uint64(zeros(size(LucImage)));
        Record = Record + uint64(LucImage);
    else
        Record = Record + uint64(LucImage);
    end
end
OutputFileName = [Luc_Folder, 'Total'];

Data_Analysis3(Plant_Info, Leaves_Mask, Roots_Mask, Record, PrintMode, Pathway, OutputFileName);

