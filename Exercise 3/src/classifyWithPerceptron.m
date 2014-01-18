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

%if true then you have a problem! Because the perceptron can only calssify 
% a two class problem
if(numClasses > 2)
    %classify with one against all
    
    %for every class a result list with its agains all
    allClassified = zeros(numTestData,1);
    for i = 1:numClasses;
        trainClass = ones(numTrainingData,1)*-1;
        trainClass(trainingClasses == classLabels(i)) = 1;
        w = perco(X,trainClass',maxEpoches);
        classified = classifyPerceptron(srTest,w);
        %give it the label of the class
        classified = (classified + 1)/2 *i; 
        allClassified = allClassified + classified;
    end
    result = allClassified == testClasses;
    %TODO more
else   
    trainClass(trainingClasses == classLabels(1)) = -1;
    w = perco(X,trainClass',maxEpoches);
    classifiedTest = classifyPerceptron(srTest,w);
    result = classifiedTest == testClasses;
    
    
    
end

