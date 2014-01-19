function [ training, trainingClasses, test, testClasses ] = getTrainingAndTestSet(dataset,trainingSize,anz)
% getTrainingAndTestSet This function devides the dataset into a training set and a test set.
%
% AUTHOR _David Pfahler_
% INPUT
%   dataset ... The dataset to devide into training and test sets
%   trainingSize ... The size of the training set
%   anz ... the number of classes in dataset
% OUTPUT
%   training ... the training set
%   trainingClasses ... the labels of the classes of the training set
%   test ... the test set
%   testClasses ... the labels of the classes of the test set
%
% DESCRIPTION
%   This function devides the dataset into a training set and a test set.
%   Each class of the the dataset is devided into one training set with a
%   fixed size and the rest gets into the test set.

% Shuffel data
dataset = dataset(randperm(size(dataset,1)),:);

%Calculate test and trainingsset

classTraining = cell(anz,1);
classTest = cell(anz,1);
for i = 1:anz    
    class = dataset(dataset(:,end)==i,:);
    classTraining{i} = class(1:trainingSize,:);
    classTest{i} = class(trainingSize+1:end,:);

    assert(isequal(class,[classTraining{i}; classTest{i}]), 'Class %d is not split correctly',i);
end

% divide training and test dataset
training = cell2mat(classTraining);
trainingClasses = training(:,end);
training = training(:,1:(end-1));
test = cell2mat(classTest);
testClasses = test(:,end);
test = test(:,1:(end-1)); 

end

