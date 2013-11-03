%% kNN
% Author _Matthias Vigele_
%
% This function returns the classes of a set of feature vectors by using 
% the k-Nearest Neighbour Classifier
%% INPUT
%   featureSet ... a matrix with values of extracted Features, values
%   describing the same image are in the same row
%   trainingSet ... a matrix countaining names of the classes and values of 
%   extracted Features of the same kind as used in the featureSet
%   k ... the number of Nearest Neigbours to take into account
%% OUTPUT
%   classNames ... a cell vector containing the names of the detected
%   classes
%% Example
% vec = getFeatures( inputImage );

function [classNames]= kNN(featureSet,trainingSet,k)
    classNames = cell(length(featureSet),1);
    for i = 1:length(featureSet,1)
        feature=featureSet(i,:);
%%ToDo
%Compute Euclidean distance between feature and each member of the training
%set

%%ToDo
%Select the k Nearest Neighbours

%%ToDo
%feature gets labeled with the class name, that is most common among the 
%k Nearest Neighbours
    end
 
end