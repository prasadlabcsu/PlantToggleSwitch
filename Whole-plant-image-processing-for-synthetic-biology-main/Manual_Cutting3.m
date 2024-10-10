%% Cutting Plant Masks 
%  Wenlong Xu
%  July 14, 2014 
%  Version 2 
%  Jan 25, 2016
%  ------------------------------------------------------------------------
%% Introduction 
%  Due to the plant growth, roots and leaves from different plants may
%  overlap with each other. This results in the merge of masks for
%  different plants causing difficulties for futher data formating for each
%  plant. Programming for automatic detection of individual plants with
%  overlaps is more challenging, which may result in an Artificial
%  Intelligence project. Instead of this smart way, I opt for manually
%  cutting the Masks wherever necessary using mouse. 
%  NOTE (Jan 25, 2016) 
%  In this version, we will have the option to restore root mask for the
%  selected area from the original root mask without removing the grid to
%  recover from potential grid removal with errors. 
%  ------------------------------------------------------------------------
%% Inputs & Outputs 
%  In  -- Input image needs cutting (Binary Image); 
%  Out -- Input image cutted (Binary Image); 
function Out = Manual_Cutting3(Tissue_Name, In, Display, Ori)
% This matrix is used to store the previous cuts for later displays
    Previous_Cuts = zeros(200, 100); 
    Num_Cut = 0; 
    Out = In;     
    Display_Mask = cast(In, class(Display)); 
    [~, ~, m3] = size(Display); 
    To_Display = zeros(size(Display)); 
    To_Display = cast(To_Display, class(Display)); 
    for xx = 1:m3
        To_Display(:, :, xx) = Display_Mask.*Display(:, :, xx); 
    end
    f1 = figure;
    set(f1, 'Position', get(0, 'Screensize')); 
    ax1 = axes('Parent',f1,'position',[0.05, 0.1, 0.4, 0.8]); 
%                                 left  bottom width height
    imshow(Display)
    ax2 = axes('Parent',f1,'position',[0.55, 0.1, 0.4, 0.8]);
    %                                 left  bottom width height
    imshow(To_Display) 
    cut_control = 1; 
    Num_Cutting = 0;
    while cut_control == 1
        cut_or_not = questdlg(['Do you want to cut the ', Tissue_Name, '?'], 'Cutting', 'Yes', 'No', 'Yes');
        switch cut_or_not
            case 'Yes' 
                h = imfreehand(ax2); 
                position = wait(h); 
                CutX = position(:, 1); 
                CutY = position(:, 2); 
                % Till here, we've found the convenience to have 2 mode of cutting: 
                % 1: stroke remove -- do not connect the 1st and last
                % points and only cut along the lines
                % 2: chunk remove -- connect the 1st and the lasst points 
                % and remove everything inside 
                stroke_or_chunk = questdlg('What do you want to operate?', 'Operations', 'Stroke', 'Chunk', 'Recover', 'Chunk');
                switch stroke_or_chunk
                    case 'Stroke'
                        Num_Points = length(CutX); 
                        for ii = 1:(Num_Points-1)
                            ff = imline(ax2, CutX(ii:(ii+1)), CutY(ii:(ii+1))); 
                            Out0 = createMask(ff); 
                            
                            Out = Out & ~Out0;

                        end
%                         Out = Connect_Points(Out, CutX, CutY, 0, 0);
                    % This noise-removing step together with the manual cutting can help
                    % remove unwanted leaves or root branches by cutting them to
                    % under-threshold pieces. 
                        Num_Cutting = Num_Cutting + 1; 
                        fprintf(   'Manual Stroke Cutting No. %u Made to %s \n', Num_Cutting, Tissue_Name);
                    case 'Chunk' 
                % Also since we are fill in holes, so we cannot modify the
                % Out directly for the case of 'Chunk' as before. We will 
                % have a Mask contain all the cutting information before 
                % its display. Otherwise some of the details in between the
                % leaves and roots will be lost. 
%                         RAM = zeros(size(Out)); 
%                         RAM = Connect_Points(RAM, CutX, CutY, 1, 1); 
%                         RAM = imfill(RAM, 'holes'); 
                        RAM = createMask(h); 
                        Out = ~RAM & Out; 
                        Num_Cutting = Num_Cutting + 1; 
                        fprintf(   'Manual Chunk Cutting No. %u Made to %s \n', Num_Cutting, Tissue_Name);   
                    case 'Recover' 
%                         RAM = zeros(size(Out)); 
%                         RAM = Connect_Points(RAM, CutX, CutY, 1, 1); 
%                         RAM = imfill(RAM, 'holes'); 
                        RAM = createMask(h); 
                        Blocks = regionprops(RAM, 'PixelList'); 
                        Pixels = Blocks(1).PixelList; 
                        Num_Pixels = size(Pixels, 1); 
                        for ii = 1:Num_Pixels 
                            Out(Pixels(ii, 2), Pixels(ii, 1)) = Ori(Pixels(ii, 2), Pixels(ii, 1)); 
                        end
                        Num_Cutting = Num_Cutting + 1; 
                        fprintf(   'Manual Chunk Recover No. %u Made to %s \n', Num_Cutting, Tissue_Name); 
                end
                imshow(To_Display)
                hold on 
                if Num_Cut ~= 0 
                    for ii = 1: Num_Cut
                        Pre_CutX = Previous_Cuts(2*ii-1, :); 
                        Pre_CutX(Pre_CutX == 0) = []; 
                        Pre_CutY = Previous_Cuts(2*ii, :); 
                        Pre_CutY(Pre_CutY == 0) = []; 
                        plot(Pre_CutX, Pre_CutY, 'r', 'LineWidth', 3)
                        drawnow
                    end
                end
                Num_Cut = Num_Cut + 1; 
                plot(CutX, CutY, 'r', 'LineWidth', 3)
                drawnow
                Previous_Cuts(2*Num_Cut-1, 1:length(CutX)) = CutX; 
                Previous_Cuts(2*Num_Cut, 1:length(CutY)) = CutY; 
            case 'No'
                cut_control = 0;
        end
        hold off
    end
    close(f1)
end