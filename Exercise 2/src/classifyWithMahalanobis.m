function [ result ] = classifyWithMahalanobis( trainingLabel, trainingData, testLabel, testData )
%CLASSIFYWITHMAHALANOBIS Summary of this function goes here
%   Detailed explanation goes here

    % Type of covariance matrix you want
    covMatType = 1;

    [class1, class2, class3] = splitClasses(trainingLabel, trainingData);
    testSampleCount = size(testLabel, 1);
    result = 0;
    
    for i=1:testSampleCount
        
        sample = testData(i, :);
        distances = calculateMahalanobis(class1, class2, class3, sample, covMatType);
        
        foundClass = find(distances==min(distances));
        
        if foundClass == testLabel(i)
            
            result = result + 1;
            
        end
        
    end
    
    result = result / testSampleCount;

end

