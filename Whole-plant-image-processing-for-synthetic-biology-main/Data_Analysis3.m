%% Data Processing and Results Output
%  Wenlong Xu
%  July 16, 2014 
%  ------------------------------------------------------------------------
%% Version Information: 
%  This is the 2nd version. Instead of output a list of ROIs as in version
%  1.0, this version spit out 1 output file coresponding to each plant. 
%  INPUTS & OUTPUTS
%  BP -- Best Performance, indicating how good the Total Plant Mask is
%  placed. 
%% Updates
%  May 1, 2015 
%  Due to pixel intensity saturation, we changed the data format from
%  uint32 to uint64 for all 
%  ------------------------------------------------------------------------  
%% 
function Data_Analysis3(Plant_Info, Luc_Leaves_Mask_Cut, Luc_Roots_Mask_Cut, Record, PrintMode, Pathway, OutputFileName)
    % Leaves Measurements 
    Labeled_Leaves_Mask = bwlabel(Luc_Leaves_Mask_Cut, 8);
    Leaves_Blocks = regionprops(Labeled_Leaves_Mask, Luc_Leaves_Mask_Cut, 'Area', 'PixelList');
    % Roots Measurements 
    Labeled_Roots_Mask = bwlabel(Luc_Roots_Mask_Cut, 8);
    Roots_Blocks = regionprops(Labeled_Roots_Mask, Luc_Roots_Mask_Cut, 'Area', 'PixelList');
    
    [Num_Plants, ~] = size(Plant_Info); 
    
    %% Prepare for Outputing Whole Plate Data Analysis
    Outfile1 = fopen(fullfile(Pathway, [OutputFileName, 'DataAnalysis.txt']), 'w'); 
    fprintf(Outfile1, [OutputFileName, '\n']);
    fprintf(Outfile1, 'Tissue \t Label Num \t Area \t Total Luc \t Luc Density \n');
    fprintf('Tissue \t Label Num \t Area \t Total Luc \t Luc Density \n');
    %% 
    for ii = 1:Num_Plants
        Num_Tissue = find(Plant_Info(ii, :)==0, 1, 'first'); 
        % Number of total tissue for each plant, roots and leaves included:
        Num_Tissue = Num_Tissue - 2; 
        Tissues_Info = Plant_Info(ii, 2:Num_Tissue+1); 
        
        % Initialize storage matrixes for each plant 
        % Leaves
        Leaves_total_area = 0; 
        Leaves_total_luc = 0; 

        % Histogram Idea
        Leaves_luc_List = []; 
        % Roots
        Roots_total_area = 0; 
        Roots_total_luc = 0; 

        % Histogram Idea
        Roots_luc_List = []; 
        
        for jj = 1:Num_Tissue
            % Leaves
            if floor(Tissues_Info(jj)/100) == 1 
                kk = Tissues_Info(jj) - 100; 
                Leaves_Area = Leaves_Blocks(kk).Area;
                Leaves_Pixels = Leaves_Blocks(kk).PixelList;
                
                Leaves_total_area = Leaves_total_area + Leaves_Area; 
                Num_Pixel = size(Leaves_Pixels, 1); 
                luc_List_on_1Leaf = zeros(1, Num_Pixel); 
                % Total Luc signal on 1 leave ROI
                Total_Luc_on_1Leaf = 0; 
                Total_Luc_on_1Leaf = uint64(Total_Luc_on_1Leaf); 
                for zz = 1:Num_Pixel
                    Total_Luc_on_1Leaf = Total_Luc_on_1Leaf + uint64(Record(Leaves_Pixels(zz, 2), Leaves_Pixels(zz, 1)));
                    luc_List_on_1Leaf(zz) = Record(Leaves_Pixels(zz, 2), Leaves_Pixels(zz, 1)); 
                end
                Density_Luc_on_1Leaf = double(Total_Luc_on_1Leaf)/double(Leaves_Area); 
                % Print out individual ROI for Whole Plate Data Analysis
                if PrintMode == 1
                    fprintf(Outfile1, 'Leaf \t %u \t %u \t %u \t %f \n', ...
                        kk, Leaves_Area, Total_Luc_on_1Leaf, Density_Luc_on_1Leaf);
                    fprintf('Leaf \t %u \t %u \t %u \t %f \n', ...
                        kk, Leaves_Area, Total_Luc_on_1Leaf, Density_Luc_on_1Leaf);
                elseif PrintMode == 0
                    fprintf('Leaf \t %u \t %u \t %u \t %f \n', ...
                        kk, Leaves_Area, Total_Luc_on_1Leaf, Density_Luc_on_1Leaf);
                else
                    error('Wrong Value for PrintMode!!!')
                end
                % Done for individual ROI Output 
                
                Leaves_total_luc = Leaves_total_luc + Total_Luc_on_1Leaf;
                
                Leaves_luc_List = cat(2, Leaves_luc_List, luc_List_on_1Leaf); 
            % Roots
            elseif floor(Tissues_Info(jj)/100) == 2 
                kk = Tissues_Info(jj) - 200; 
                Roots_Area = Roots_Blocks(kk).Area;
                Roots_Pixels = Roots_Blocks(kk).PixelList;
                Roots_total_area = Roots_total_area + Roots_Area; 
                
                Num_Pixel = size(Roots_Pixels, 1);
                luc_List_on_1Root = zeros(1, Num_Pixel);
                % Total Luc signal on 1 leave ROI
                Total_Luc_on_1Roots = 0;
                Total_Luc_on_1Roots = uint64(Total_Luc_on_1Roots);
                for zz = 1:Num_Pixel
                    Total_Luc_on_1Roots = Total_Luc_on_1Roots + uint64(Record(Roots_Pixels(zz, 2), Roots_Pixels(zz, 1)));
                    luc_List_on_1Root(zz) = Record(Roots_Pixels(zz, 2), Roots_Pixels(zz, 1)); 
                end
                Density_Luc_on_1Root = double(Total_Luc_on_1Roots)/double(Roots_Area);
                % Print out individual ROI for Whole Plate Data Analysis
                if PrintMode == 1
                    fprintf(Outfile1, 'Root \t %u \t %u \t %u \t %f \n', ...
                        kk, Roots_Area, Total_Luc_on_1Roots, Density_Luc_on_1Root);
                    fprintf('Root \t %u \t %u \t %u \t %f \n', ...
                        kk, Roots_Area, Total_Luc_on_1Roots, Density_Luc_on_1Root);
                elseif PrintMode == 0
                    fprintf('Root \t %u \t %u \t %u \t %f \n', ...
                        kk, Roots_Area, Total_Luc_on_1Roots, Density_Luc_on_1Root);
                else
                    error('Wrong Value for PrintMode!!!')
                end
                % Done for individual ROI Output
                
                Roots_total_luc = Roots_total_luc + Total_Luc_on_1Roots; 
                
                Roots_luc_List = cat(2, Roots_luc_List, luc_List_on_1Root);  
            else 
                error('Wrong Inputs in Plant_Num_and_Index!')
            end

        end
        Density_Luc_on_Leaves = double(Leaves_total_luc)/double(Leaves_total_area);
        Density_Luc_on_Roots  = double(Roots_total_luc) /double(Roots_total_area);
        
        Leaves_Luc_Range = min(Leaves_luc_List):1:max(Leaves_luc_List);
        Leaves_nelements = hist(Leaves_luc_List, Leaves_Luc_Range); 
        Remove_Zeros = find(Leaves_nelements == 0); 
        Leaves_nelements(Remove_Zeros) = []; 
        Leaves_Luc_Range(Remove_Zeros) = []; 
        
        Roots_Luc_Range  = min(Roots_luc_List) :1:max(Roots_luc_List);
        Roots_nelements  = hist(Roots_luc_List,  Roots_Luc_Range); 
        Remove_Zeros = find(Roots_nelements == 0); 
        Roots_nelements(Remove_Zeros) = []; 
        Roots_Luc_Range(Remove_Zeros) = []; 
        %% Output data analysis results to 1 out file for each plant
        Outfile2 = fopen(fullfile(Pathway, [OutputFileName, 'Plant ', sprintf('%d', Plant_Info(ii, 1)), 'DataAnalysis.txt']), 'w'); 
        fprintf(Outfile2, [OutputFileName, '\n']);
        fprintf(Outfile2, 'Plant No. \t %u \n', Plant_Info(ii, 1));
        fprintf(Outfile2, 'Leaves Total Area \t %u \n', Leaves_total_area);
        fprintf(Outfile2, 'Leaves Total Luc \t %u \n',  Leaves_total_luc);
        fprintf(Outfile2, 'Leaves Luc Density\t %u \n',  Density_Luc_on_Leaves);
        
        fprintf(Outfile2, 'Roots Total Area \t %u \n', Roots_total_area);
        fprintf(Outfile2, 'Roots Total Luc \t %u \n',  Roots_total_luc);
        fprintf(Outfile2, 'Roots Luc Density\t %u \n',  Density_Luc_on_Roots);
        
        fprintf(Outfile2, 'Leaves Luc Distribution \n');
        for xx = 1:length(Leaves_nelements)
            fprintf(Outfile2, '%u \t%u \n', Leaves_Luc_Range(xx), Leaves_nelements(xx));
        end
        
        fprintf(Outfile2, 'Roots Luc Distribution \n');
        for yy = 1:length(Roots_nelements)
            fprintf(Outfile2, '%u \t%u \n', Roots_Luc_Range(yy), Roots_nelements(yy));
        end
        fclose(Outfile2); 
    end
    
    fclose(Outfile1); 
end