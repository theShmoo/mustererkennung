function [ training, trainingClasses, test, testClasses, trainingSize ] = getTrainingAndTestSet(wines,trainingSize,anz)
%GETTRAININGANDTESTSET Summary of this function goes here
%   Detailed explanation goes here

    % Shuffel data
    wines = wines(randperm(size(wines,1)),:);
     
    %Calculate test and trainingsset
    
    classTraining = cell(anz,1);
    classTest = cell(anz,1);
    for i = 1:anz    
        class = wines(wines(:,1)==i,:);
        classTraining{i} = class(1:trainingSize,:);
        classTest{i} = class(trainingSize+1:end,:);
        
        assert(isequal(class,[classTraining{i}; classTest{i}]), 'Class %d is not split correctly',i);
    end

    % divide training and test dataset
    training = cell2mat(classTraining);
    trainingClasses = training(:,1);
    training = training(:,2:end);
    test = cell2mat(classTest);
    testClasses = test(:,1);
    test = test(:,2:end); 

end

