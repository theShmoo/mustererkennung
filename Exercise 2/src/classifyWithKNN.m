function [ result ] = classifyWithKNN(srTest,srTraining,trainingClasses,trainingSize,testSize)
%CLASSIFYWITHKNN Summary of this function goes here
%   Detailed explanation goes here

% wine has
% 0) Class index
% 1) Alcohol 
% 2) Malic acid 
% 3) Ash 
% 4) Alcalinity of ash 
% 5) Magnesium 
% 6) Total phenols 
% 7) Flavanoids 
% 8) Nonflavanoid phenols 
% 9) Proanthocyanins 
% 10)Color intensity 
% 11)Hue 
% 12)OD280/OD315 of diluted wines 
% 13)Proline 
    featureNames = {
%            'Class index';
            'Alcohol';
            'Malic acid';
            'Ash';
            'Alcalinity of ash';
            'Magnesium';
            'Total phenols';
            'Flavanoids';
            'Nonflavanoid phenols';
            'Proanthocyanins';
            'Color intensity';
            'Hue';
            'OD280/OD315 of diluted wines';
            'Proline'
    };

% k-NN
% Sei n die Anzahl Trainingsstichproben pro Klasse, und d die Anzahl 
% Merkmale. Das Verhaeltnis
% n/d soll > 10

alc=find(not(cellfun('isempty', strfind(featureNames,'Alcohol'))));
ash=find(not(cellfun('isempty', strfind(featureNames,'Ash'))));
aash=find(not(cellfun('isempty', strfind(featureNames,'Alcanity of Ash'))));
flav=find(not(cellfun('isempty', strfind(featureNames,'Flavanoids'))));
pro=find(not(cellfun('isempty', strfind(featureNames,'Proline'))));
prot=find(not(cellfun('isempty', strfind(featureNames,'Proanthocyanins'))));
col=find(not(cellfun('isempty', strfind(featureNames,'Color Intensity'))));
hue=find(not(cellfun('isempty', strfind(featureNames,'Hue'))));
mal=find(not(cellfun('isempty', strfind(featureNames,'Malic acid'))));
tphe=find(not(cellfun('isempty', strfind(featureNames,'Total phenols'))));

% Prozente bei thres = 50
% features = [pro hue]; % 88.888
%  features = [alc hue flav]; % 78.888
% features = [col flav]; % 84,4444
% features = [ash col]; % 48.8888
% features = [hue alc]; % 70
% features = [pro mal]; 78
% features = [pro mal ash]; 78,88
% features = [pro mal]; 78
% features = [pro hue ash]; % 91.1111 Prozent bei k = 55
 features = [pro col flav]; % 95.5555 Prozent bei k = 38
 
result = zeros(testSize,testSize);
for k = 1:size(srTraining,1)
    result(:,k) = knnclassify(srTest(:,features),srTraining(:,features),trainingClasses,k);
end

end

