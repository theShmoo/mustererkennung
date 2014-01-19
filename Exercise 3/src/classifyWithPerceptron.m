function [ result ] = classifyWithPerceptron( srTraining, trainingClasses, srTest, testClasses, maxEpoches)
%% CLASSIFYWITHPERCEPTRON Classifies the test dataset with the perceptron
%trained with the training data set

numFeatures = size(srTraining , 2);
numTrainingData = size(srTraining , 1);
numTestData = size(srTest, 1);
classLabels = unique(trainingClasses);
numClasses = size(classLabels , 1);
trainClass = ones(numTrainingData,1);

% Transpose the trainingset and add an additional column for the bias
X = ones(numFeatures+1,numTrainingData);
X(2:numFeatures+1,:) = transpose(srTraining);

    
    %for every class a result list with its agains all
    w = mutliPerco(X,trainingClasses,maxEpoches);
    classified = classifyPerceptron(srTest',w);
    result = classified == testClasses;
end

