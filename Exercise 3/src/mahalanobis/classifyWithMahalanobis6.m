function [ result ] = classifyWithMahalanobis6( trainingLabel, trainingData, testLabel, testData, covMatType )
%CLASSIFYWITHMAHALANOBIS Summary of this function goes here
%   Detailed explanation goes here

    [class1, class2, class3, class4, class5, class6] = splitClasses6(trainingLabel, trainingData);
    testSampleCount = size(testLabel, 1);
    result = 0;
    
    for i=1:testSampleCount
        
        sample = testData(i, :);
        distances = calculateMahalanobis6(class1, class2, class3, class4, class5, class6, sample, covMatType);
        
        foundClass = find(distances==min(distances));
        
        if foundClass == testLabel(i)
            
            result = result + 1;
            
        end
        
    end
    
    result = (result / testSampleCount) * 100;

end

