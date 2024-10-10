%% Function to Get the Roots Mask from Digital Images
%  Wenlong Xu
%  July 31, 2014 
%  ------------------------------------------------------------------------
%  Inputs: 
%  originalImage
%  GridMask
%  Output: 
%  Refined_Leaves
function f1 = Get_Roots_Mask2(originalImage)
global Root_Threshold
Root_Threshold = 0.9; 
Out = root_thresholding(originalImage, Root_Threshold); 

f1 = figure; 
set(gcf, 'Position', get(0, 'ScreenSize'))
ax1 = axes('Parent',f1,'position',[0.05, 0.25, 0.4, 0.65]); 
%                                 left  bottom width height
imshow(originalImage)
ax2 = axes('Parent',f1,'position',[0.55, 0.25, 0.4, 0.65]); 
%                                 left  bottom width height
set(ax2, 'Units', 'Pixels'); 
AXPos = get(ax2, 'Position'); 
imshow(Out); 
SPos = [AXPos(1)+floor(AXPos(3)/4), floor(AXPos(2)*0.66), floor(AXPos(3)/2), 20]; 
b = uicontrol('Parent',f1,'Style','slider','Position',SPos, ...'Units', 'normalized',
              'value',Root_Threshold, 'min',0, 'max',1); 
bgcolor = f1.Color;
bl1 = uicontrol('Parent',f1,'Style','text','Position',[SPos(1)-30,SPos(2),20,20],...
                'String','0','BackgroundColor',bgcolor, 'FontSize', 10, 'FontWeight', 'Bold');
bl2 = uicontrol('Parent',f1,'Style','text','Position',[SPos(1)+SPos(3)+20,SPos(2),20,20],...
                'String','1','BackgroundColor',bgcolor, 'FontSize', 10, 'FontWeight', 'Bold');
bl3 = uicontrol('Parent',f1,'Style','text','Position',[AXPos(1)+floor(AXPos(3)/2)-50, SPos(2)+20, 100, 20],...
                'String','Threshold','BackgroundColor',bgcolor, 'FontSize', 10, 'FontWeight', 'Bold', 'HorizontalAlignment', 'center');   
            
b.Callback = @(es, ep) slider2_callback(originalImage, es.Value);

end

function slider2_callback(IN, Th)
evalin('base', ['Root_Threshold = ', sprintf('%f', Th), ';']); 
Out = root_thresholding(IN, Th); 
imshow(Out)
end
