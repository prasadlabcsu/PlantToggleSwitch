%% Function to Get the Leaves Mask from Digital Images
%  Wenlong Xu
%  July 31, 2014 
%  Version 2, updated May 3, 2017 
%  ------------------------------------------------------------------------
%  Part of the code here are copied directly from the old main code. The
%  other part is to achieve a better distinguish between leaves and the 
%  roots close to the leaves by looking at the ratio of 
%  (Green/Blue)/(Red/Blue)
%  Inputs: 
%  originalImage
%  Output: 
%  Refined_Leaves
function f1 = Get_Leaves_Mask2(originalImage)
global Leaves_Threshold2
Leaves_Threshold2 = 1;  
Out = green_thresholding(originalImage, Leaves_Threshold2); 

f1 = figure; 
set(gcf, 'Position', get(0, 'ScreenSize'))
ax = axes('Parent',f1,'position',[0.1, 0.25, 0.8, 0.65]); 
%                                 left  bottom width height
set(ax, 'Units', 'Pixels'); 
AXPos = get(ax, 'Position'); 
imshow(Out); 
SPos = [AXPos(1)+floor(AXPos(3)/4), floor(AXPos(2)*0.66), floor(AXPos(3)/2), 20]; 
b = uicontrol('Parent',f1,'Style','slider','Position',SPos, ...'Units', 'normalized',
              'value',Leaves_Threshold2, 'min',0, 'max',1); 
bgcolor = f1.Color;
bl1 = uicontrol('Parent',f1,'Style','text','Position',[SPos(1)-30,SPos(2),20,20],...
                'String','0','BackgroundColor',bgcolor, 'FontSize', 10, 'FontWeight', 'Bold');
bl2 = uicontrol('Parent',f1,'Style','text','Position',[SPos(1)+SPos(3)+20,SPos(2),20,20],...
                'String','1','BackgroundColor',bgcolor, 'FontSize', 10, 'FontWeight', 'Bold');
bl3 = uicontrol('Parent',f1,'Style','text','Position',[AXPos(1)+floor(AXPos(3)/2)-50, SPos(2)+20, 100, 20],...
                'String','Threshold','BackgroundColor',bgcolor, 'FontSize', 10, 'FontWeight', 'Bold', 'HorizontalAlignment', 'center');   
            
b.Callback = @(es, ep) slider1_callback(originalImage, es.Value);

end

function slider1_callback(IN, Th1)
evalin('base', ['Leaves_Threshold2 = ', sprintf('%f', Th1), ';']); 
Out = green_thresholding(IN, Th1); 
imshow(Out)
end

