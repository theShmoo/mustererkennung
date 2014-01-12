function [ result ] = classifyWithKNN(srTest,srTraining,trainingClasses,featureNames)
% classifyWithKNN This function classifies a dataset with the kNN
% classification algorithm
%
% AUTHOR _David Pfahler_
% INPUT
%   srTest ... The test set standardized
%   srTraining ... The training set standardized
%   trainingClasses ... The labels of the training set
%   featureNames ... the feature Names
% OUTPUT
%   result ... the  result with all k classifications
%
% DESCRIPTION
%  This function classifies a dataset with the kNN
% classification algorithm

% k-NN
% Sei n die Anzahl Trainingsstichproben pro Klasse, und d die Anzahl 
% Merkmale. Das Verhaeltnis
% n/d soll > 10

% alc=find(not(cellfun('isempty', strfind(featureNames,'Alcohol'))));
% ash=find(not(cellfun('isempty', strfind(featureNames,'Ash'))));
% aash=find(not(cellfun('isempty', strfind(featureNames,'Alcanity of Ash'))));
flav=find(not(cellfun('isempty', strfind(featureNames,'Flavanoids'))));
pro=find(not(cellfun('isempty', strfind(featureNames,'Proline'))));
% prot=find(not(cellfun('isempty', strfind(featureNames,'Proanthocyanins'))));
col=find(not(cellfun('isempty', strfind(featureNames,'Color Intensity'))));
% hue=find(not(cellfun('isempty', strfind(featureNames,'Hue'))));
% mal=find(not(cellfun('isempty', strfind(featureNames,'Malic acid'))));
% tphe=find(not(cellfun('isempty', strfind(featureNames,'Total phenols'))));

% Prozente bei thres = 50
% features = [pro hue]; % 88.888
% features = [alc hue flav]; % 78.888
% features = [col flav]; % 84,4444
% features = [ash col]; % 48.8888
% features = [hue alc]; % 70
% features = [pro mal]; 78
% features = [pro mal ash]; 78,88
% features = [pro mal]; 78
% features = [pro hue ash]; % 91.1111 Prozent bei k = 55
 features = [pro col flav]; % 95.5555 Prozent bei k = 38
 
result = zeros(size(srTest,1),size(srTraining,1));
for k = 1:size(srTraining,1)
    result(:,k) = knnclassify(srTest(:,features),srTraining(:,features),trainingClasses,k);
end

end

