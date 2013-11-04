%% kNN
% Author _Matthias Vigele_
%
% This function returns the classes of a set of feature vectors by using
% the k-Nearest Neighbour Classifier
%% INPUT
%   featureSet ... a matrix with values of extracted Features, values
%   describing the same image are in the same row
%   trainingSet ... a matrix countaining values of
%   extracted Features of the same kind as used in the featureSet
%   trainingLabels ... a cell vector containing the names of the classes
%   that correspond to the images inside the training set.
%   k ... the number of Nearest Neigbours to take into account
%% OUTPUT
%   classNames ... a cell vector containing the names of the detected
%   classes
%% Example
% vec = kNN(featureSet, trainingSet,trainingLabels,k);

function [classNames]= k_NN(featureSet,trainingSet,trainingLabels,k)
classNames = cell(length(featureSet),1);
for i = 1:length(featureSet,1)
    feature=featureSet(i,:);
    distances= cell(length(feature),1);
    trainingLabelsC=trainingLabels;
    %%Compute Euclidean distance between feature and each member of the training
    %set
    for j = 1:length(trainingSet,1)
        training=trainingSet(j,:);
        distance=(feature-training)^2;
        distances(j)=sqrt(sum(distance));
    end
    
    
    %%Select the k Nearest Neighbours
    classes = containers.Map('KeyType','char','ValueType','int32');
    mcClass=0;
    for j = 1:k
        nn=find(min(distances), 1);
        if (isKey(classes,trainingLabelsC(nn)))
            classes(trainingLabelsC(nn)) =  classes(trainingLabelsC(nn))+1;
        else
            classes(trainingLabelsC(nn)) = 1;
            %feature gets labeled with the class name, that is most common among the
            %k Nearest Neighbours
            if (classes(trainingLabelsC(nn))>mcClass)
                classNames(i)=trainingLabelsC(nn);
                mcClass=classes(trainingLabelsC(nn));
            end
            
        end
        distances(nn)=[];
        trainingLabelsC(nn)=[];
    end
    
    
end
end