%% Remove Background Noise
%  Wenlong Xu
%  July 3, 2014 
%  ------------------------------------------------------------------------
function O = Remove_Background_noise(I, Mode, Para)
% Mode 1 -- Regular one with Parameter as the threshold on Area; 
% Mode 0 -- Get the largest ones with Parameter as the number of Areas; 
    Measurements = regionprops(I, 'Area', 'PixelList'); 
    Num_Raw = size(Measurements, 1); 
    Areas = zeros(1, Num_Raw); 
    for ii = 1:1:Num_Raw
        Areas(ii) = Measurements(ii, 1).Area; 
    end
    if Mode == 1
        Index = find(Areas>Para);
    elseif Mode == 0 
        for mm = 1:1:Para
            Index(mm) = find(Areas==max(Areas)); 
            Areas(Index(mm))=1; 
        end
    end
    Num_Refined = length(Index); 
    Refined = zeros(size(I)); 
    for jj = 1:1:Num_Refined
        Pixels = Measurements(Index(jj), 1).PixelList; 
        for mm = 1:1:(length(Pixels))
            Refined(Pixels(mm, 2), Pixels(mm, 1)) = 1; 
        end
    end
    O = Refined; 
end