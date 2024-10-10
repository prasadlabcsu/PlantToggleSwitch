%% Get the growth data from the results directory 
%  May 1, 2017 
%  Wenlong Xu
%  Prasad Group 
%  Colorado State Univ
%  ------------------------------------------------------------------------

Dir = 'E:\Research Backup\Image Processing\ARPA-E Data Processed\Toggle2-5-39, 49 & 65 T3 plants(06-15-2015)\Toggle2-5-65 Result Summary\LUC'; 
LINE_NAME = 'Toggle2-5-65'; 
ResultFiles = dir(fullfile(Dir, [LINE_NAME, '_Plant_Index_*'])); 
Prefix = {'Leaves', 'Roots'}; 

Num_Plants = length(ResultFiles); 

Path1 = LINE_NAME; 
if isempty(dir(Path1))
    mkdir(Path1);
end


for ii = 1:Num_Plants 
    Folder_Name = [LINE_NAME, '_Plant_Index_', sprintf('%d', ii)]; 
    for jj = 1:length(Prefix)
        
        Path2 = fullfile(Dir, Folder_Name, [Prefix{jj}, '_Distribution_Info_Log2_BW100.txt']); 

        copyfile(Path2, fullfile(Path1, [LINE_NAME, '_', Prefix{jj}, '_Plant_Index_', sprintf('%d', ii+32), '.txt'])); 
    end
end


    
    
    
    
    
    
    
    
    
    
    