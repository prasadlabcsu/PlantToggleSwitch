%% Function to Input the Plant #'s and ROI's They Includes
%  Wenlong Xu
%  July 31, 2014 
%  ------------------------------------------------------------------------
%% Introduction
%  To avoid the afterwards manual putting-together for each plant in Excel,
%  this function is designed to collect the information right before the
%  processing and store the processing results accordingly for each plant.
%  Hopefully, this way can enable more flexibility in further data
%  analyses. 
%  In this function, the user will be asked to connect the tissues
%  belonging to one plant using the traditional points connecting method.
%  The tissues sharing common point(s) will be grouped into one plant. 
%  ------------------------------------------------------------------------
%  Input: 
%  Output:
%  Matrix containing the grouping information for each plant in the plate: 
%  1) Each row containing information for one plant;  
%  2) Plant Index, Tissue Type-Tissue Index, ...; 
%  Tissue Types: 1xx -- Leaves; 2xx -- Roots; 
%  xx is cooresponding Tissue Index (realistical range of 1-99); 
%  ------------------------------------------------------------------------
%% 
function Plant_Info = Plant_Num_and_Index2()
% section 1, 
% Get number of plants in the plate under processing 
IF_Continue = 1; 
while IF_Continue == 1
    prompt = {'How many plants do you have in this plate?'};
    dlg_title = 'Input Total Plant Number';
    num_lines = 1;
    def = {'2'};
    Num_Plant = inputdlg(prompt, dlg_title, num_lines, def);
    Num_Plant = Num_Plant{1};
    Num_Plant = str2double(Num_Plant); 
    Num_Plant = uint8(Num_Plant); 

    Plant_Info = zeros(Num_Plant, 20); 
    % section 2, 
    % Get grouping information for each plant in the plate under processing
    fprintf('Input Number of Plants and Their Labels: \n')
    fprintf('Index \tLabel Num \n')
    for ii = 1:Num_Plant 
        prompt = {'Please Enter Plant Index Number?'};
        dlg_title = 'Input Plant Index';
        num_lines = 1;
        def = {'1'};
        Plant_Index = inputdlg(prompt, dlg_title, num_lines, def);
        Plant_Index = Plant_Index{1};
        Plant_Index = str2double(Plant_Index); 
        Plant_Index = uint8(Plant_Index); 
        Plant_Info(ii, 1) = Plant_Index; 
        fprintf('No. %u \t#%u \n', ii, Plant_Index)
    end
    
    continue_or_not = questdlg('Are you sure about the input listed in the Command Line?', 'Double-Check', 'Yes', 'No', 'Yes');
    switch continue_or_not
        case 'Yes'
            IF_Continue = 0;
        case 'No'
            IF_Continue = 1;
            fprintf('Error Found While Inputting Number of Plants and Their Labels! \n')
            fprintf('Inputting Started Again: \n')
    end
    fprintf(   'Number of Plants and Their Labels Inputted Correcetly! \n'); 
end