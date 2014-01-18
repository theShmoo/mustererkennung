function [ result ] = classifyWithMahalanobis2( trainingLabel, trainingData, testLabel, testData, covMatType )
%CLASSIFYWITHMAHALANOBIS Summary of this function goes here
%   Detailed explanation goes here

    [class1, class2] = splitClasses2(trainingLabel, trainingData);
    testSampleCount = size(testLabel, 1);
    result = 0;
    
    for i=1:testSampleCount
        
        sample = testData(i, :);
        distances = calculateMahalanobis2(class1, class2, sample, covMatType);
        
        foundClass = find(distances==min(distances));
        
        if foundClass == testLabel(i)
            
            result = result + 1;
            
        end
        
    end
    
    result = (result / testSampleCount) * 100;

end

