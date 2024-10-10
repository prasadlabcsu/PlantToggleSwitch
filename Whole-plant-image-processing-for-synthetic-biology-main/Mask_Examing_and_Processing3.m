%% Apply Mask to the Luc Images and Quantify the Data
%  Wenlong Xu
%  July 16, 2014 
%  ------------------------------------------------------------------------
%  Plot the Best-Fit Mask and see if any manual cutting needed
%  Apply the Leaves Mask, make necessary cutting and labeling
%  NOTE (Jan 25, 2016)
%  To allow the error-prone underneath grid removing, we include the
%  functionality to restore selected area of the root mask from the 
%  original root mask. 

function [Luc_Mask_Cut, Plant_Info] = Mask_Examing_and_Processing3(Tissue_Name, Luc_Mask, Ori_Mask, Record, SaveMode, Dir, GroupingMode, Plant_Info)
    If_Cutting = 1; 
    If_Start_Over = 1; 
    FontSize = 30; 
    % Ori_Mask -- this is the original root mask acquired from 
    % Get_Roots_Mask function. 
    % This Plant_Info_Backup is added on Nov 30, 2014 when a bug is found: 
    % If some errors happened during the grouping process, the previous and
    % wrong grouping info is not cleaned from the Plant_Info Matrix.
    % Therefore, the original info needs to be firstly stored used for
    % later reboot if necessary. 
    Plant_Info_Backup = Plant_Info; 
    while If_Cutting == 1
        if If_Start_Over == 1 
            Luc_Mask_Cut = Manual_Cutting3(Tissue_Name, Luc_Mask, Record, Ori_Mask); 
            If_Start_Over = 0; 
        elseif If_Start_Over == 0 
            Luc_Mask_Cut = Manual_Cutting3(Tissue_Name, Luc_Mask_Cut, Record, Ori_Mask); 
            
        end
        Luc_Mask_Cut = imclearborder(Luc_Mask_Cut,8); 
        Luc_Mask_Cut = Remove_Background_noise(Luc_Mask_Cut, 1, 5e-5*numel(Record)); 
        % Labeled_Mask = bwlabel(Luc_Mask_Cut, 8);
        Blocks = regionprops(logical(Luc_Mask_Cut), Luc_Mask_Cut, 'BoundingBox', 'PixelList'); 
        Num_Tissues = size(Blocks, 1); 
        Boundaries = bwboundaries(Luc_Mask_Cut);	
        %  Check the maximum of labeling index to see if all plants are separated 
        f1 = figure; 
        set(f1, 'Position', get(0, 'Screensize')); 
        imshow(Record)
        hold on 
        for kk = 1:Num_Tissues
            Box = Blocks(kk).BoundingBox; 
            thisBoundary = Boundaries{kk}; 
            text(Box(1)+Box(3), Box(2)-20, num2str(kk), 'FontSize', FontSize, 'FontWeight', 'Bold', 'Color', [0 1 0])
            plot(thisBoundary(:,2), thisBoundary(:,1), 'g', 'LineWidth', 2);
        end
        hold off
        continue_or_not = questdlg(['Do you have ', num2str(Num_Tissues), ' ', Tissue_Name, '?'], 'Cutting', 'Yes', 'No', 'Start Over', 'Yes');
        switch continue_or_not
            case 'Yes'
                If_Cutting = 0;
                %             imshow(Out)
                %             drawnow 

            case 'No'
                If_Cutting = 1; 
                close(f1); 
            case 'Start Over'
                If_Cutting = 1; 
                If_Start_Over = 1; 
                close(f1); 
                fprintf('Start Over Manual Cutting %s\n', Tissue_Name);
        end
        
    end
    fprintf(   '%s Mask Visual Checking Completed! \n', Tissue_Name); 
    %%%%%%%%%%%%%%%%%%%%
    % Here needs some codes to store the labeled ROI's
    if SaveMode == 1
        saveas(f1, fullfile(Dir, [Tissue_Name, '_labeled.jpg']))
    elseif SaveMode == 0
        % No image saved
    else
        error('Wrong Value for SaveMode!!!')
    end
% After cutting, for the final Masks on the Luc images, it is necessary to
% group roots and leaves into plants. In version 2.0, this job was done
% manually in Excel by copy-and-paste. 
    if GroupingMode == 1
        fprintf(   'Manual Input Grouping Info: \n'); 
        IF_Continue = 1; 
        while IF_Continue == 1
            if strcmp(Tissue_Name, 'Leaves')
                ii = 1; 
            elseif strcmp(Tissue_Name, 'Roots')
                ii = 2; 
            else
                error('Wrong Input of Tissue Name for Tissue Grouping!')
            end 
            % Reboot the Plant_Info Matrix
            Plant_Info  = Plant_Info_Backup; 
            Plant_Indexes = Plant_Info(:, 1); 
            [Num_Plant, Num_Col] = size(Plant_Info); 
            Mask_Saving_Info = zeros(Num_Plant, 20); 
            Plant_Index = Plant_Info(:, 1); 
            fprintf('Group Tissue ROIs into Plants: \n'); 
            for jj = 1:Num_Plant
                prompt = {['Please Enter Number of ',  Tissue_Name, ' for Plant #', num2str(Plant_Index(jj)), ':']};
                dlg_title = ['Number of ', Tissue_Name];
                num_lines = 1;
                def = {'1'};
                Num_Tissue = inputdlg(prompt, dlg_title, num_lines, def);
                Num_Tissue = Num_Tissue{1};
                Num_Tissue = str2double(Num_Tissue); 
                Num_Tissue = uint8(Num_Tissue); 
                fprintf(   'Plant #%u \t%s \t', Plant_Index(jj), Tissue_Name); 
                Pointer = find(Plant_Info(jj, 2:Num_Col)==0, 1, 'first') + 1; 
                for zz = 1:Num_Tissue
                    prompt = {['Please Enter Index of #', num2str(zz), ' ', Tissue_Name, ' for Plant #', num2str(Plant_Index(jj)), ':']};
                    dlg_title = ['Index of #', num2str(zz), ' ', Tissue_Name];
                    num_lines = 1;
                    def = {'1'};
                    Tissue_Index = inputdlg(prompt, dlg_title, num_lines, def);
                    Tissue_Index = Tissue_Index{1};
                    Tissue_Index = str2double(Tissue_Index);
                    Tissue_Index = uint8(Tissue_Index); 
                    Plant_Info(jj, Pointer) = ii*100 + Tissue_Index; 
                    Mask_Saving_Info(jj, zz) = Tissue_Index; 
                    Pointer = Pointer + 1; 
                    fprintf(   '%u \t', Tissue_Index); 
                end
                fprintf(   '\n'); 
            end
            % Double Check the Input and Give a Chance to Change
            continue_or_not = questdlg('Are you sure about the input listed in the Command Line?', 'Double-Check', 'Yes', 'No', 'Yes');
            switch continue_or_not
                case 'Yes'
                    IF_Continue = 0; 
                    % Once the grouping is finished, we will save the mask
                    % for leaves and roots of different plants separately. 
                    for mm = 1:Num_Plant  
                        Regions_for_this_Plant = Mask_Saving_Info(mm, :); 
                        Regions_for_this_Plant(Regions_for_this_Plant==0) = []; 
                        Tissue_Mask_for_this_Plant = zeros(size(Luc_Mask_Cut)); 
                        for nn = 1:length(Regions_for_this_Plant)
                            Region_Index = Regions_for_this_Plant(nn); 
                            RegionPixelList = Blocks(Region_Index).PixelList; 
                            Num_Pixel = size(RegionPixelList, 1);
                            for xx = 1:Num_Pixel
                                Tissue_Mask_for_this_Plant(RegionPixelList(xx, 2), RegionPixelList(xx, 1)) = 1; 
                            end
                        end
                        Binary_Tissue_Mask = Tissue_Mask_for_this_Plant == 1; 
                        h10 = figure; 
                        set(gcf, 'Position', get(0, 'Screensize')); 
                        imshow(Binary_Tissue_Mask); 
                        imwrite(Binary_Tissue_Mask, fullfile(Dir, ['Plant ', sprintf('%d', Plant_Indexes(mm)), Tissue_Name, ' Mask.bmp'])); 
                        close(h10); 
                    end
                case 'No'
                    IF_Continue = 1; 
                    fprintf(   'Error Found While Grouping %s into Plants! \n', Tissue_Name); 
                    fprintf(   '%s Grouping Started Again: \n', Tissue_Name); 
            end
            
        end
    end
    close(f1); 
    fprintf(   '%s Mask Examing and Processing Finished. \n', Tissue_Name);
end












