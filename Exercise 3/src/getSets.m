function [ training, trainingClasses, test, testClasses ] = getSets( data, mode )
%GETSETS Summary of this function goes here
%   Detailed explanation goes here

    rng(123401234);

    if mode == 2
        
        %dryStrokes = data(1:82, :);
        %wetStrokes = data(83:end, :);
        data(1:82, 21) = 1;
        data(83:end, 21) = 2;
        
        trainSize = calculateTrainingSize(data, 2);
        
        [training, trainingClasses, test, testClasses] = getTrainingAndTestSet(data, trainSize, 2); 
        
    end
    
    if mode == 6
        
        trainSize = calculateTrainingSize(data, 6);
        
        [training, trainingClasses, test, testClasses] = getTrainingAndTestSet(data, trainSize, 6); 
        
    end


end

