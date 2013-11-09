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
%featureSet=[5 4 3;25 35 21;170 80 120];
%trainingSet=[150 90 115;6 8 4;23 36 27;145 88 117;21 34 26];
%trainingLabels={'class1';'class2';'class3';'class1';'class3'};
%Expected output: class2 class3 class1
% vec = k_NN(featureSet, trainingSet,trainingLabels,1);

function [classNames]= k_NN(featureSet,trainingSet,trainingLabels,k)

    classNames = cell(size(featureSet,1),1);
    
    for i = 1:size(featureSet,1)
        feature=featureSet(i,:);
        distances= zeros([length(feature) 1]);
        trainingLabelsC=trainingLabels;
        
        %%Compute Euclidean distance between feature and each member of the training
        %set
        for j = 1:size(trainingSet,1)
            training=trainingSet(j,:);
            distances(j)=norm(feature-training);
        end


        %%Select the k Nearest Neighbours
        classes=unique(trainingLabelsC);
        classesCount= zeros([length(classes) 1]);
        mcClass=0;
        
        for j = 1:k
            [~,nn]=min(distances);
            nn = nn(1);
            ci=find(not(cellfun('isempty', strfind(classes,trainingLabelsC{nn}))));
            classesCount(ci)=classesCount(ci)+1;
            %feature gets labeled with the class name, that is most common among the
            %k Nearest Neighbours
            if (classesCount(ci)>mcClass)
                classNames{i}=trainingLabelsC{nn};
                mcClass=classesCount(ci);
            end
            distances(nn)=[];
            trainingLabelsC(nn)=[];
        end
        
    end
end