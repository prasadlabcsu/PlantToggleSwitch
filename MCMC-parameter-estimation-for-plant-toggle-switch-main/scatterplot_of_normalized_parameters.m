function [f1, f2] = scatterplot_of_normalized_parameters(A, B, n, P, IS, Name, Dir)
f1 = figure;  
% ScreenSize = get(0, 'Screensize'); 
% ScreenSize(4) = ScreenSize(4)/2.5; 
% set(gcf, 'Position', ScreenSize);
% 
% subplot(1, 2, 1)
scatter(log(A), n, 100, 'bo', 'LineWidth', 1)
hold on 
scatter(log(P(:, 1)./P(:, 3)), P(:, 4), 200, 'r^', 'filled')
hold off 
xlabel('log(A/H)')
ylabel('n')
set(gca, 'FontSize', 16, 'FontWeight', 'Bold')
if IS 
    % A value of 1 means to save the figures 
    saveas(f1, fullfile(Dir, [Name, sprintf('_ScatterPlot%d.tif', 1)])); 
    saveas(f1, fullfile(Dir, [Name, sprintf('_ScatterPlot%d.fig', 1)])); 
end
%% 
% subplot(1, 2, 2)
f2 = figure; 
scatter(log(B), n, 100, 'bo', 'LineWidth', 1)
hold on 
scatter(log(P(:, 2)./P(:, 3)), P(:, 4), 200, 'r^', 'filled')
hold off 
xlabel('log(B/H)')
ylabel('n')
set(gca, 'FontSize', 16, 'FontWeight', 'Bold')
if IS 
    % A value of 1 means to save the figures 
    saveas(f2, fullfile(Dir, [Name, sprintf('_ScatterPlot%d.tif', 2)])); 
    saveas(f2, fullfile(Dir, [Name, sprintf('_ScatterPlot%d.fig', 2)])); 
end
end