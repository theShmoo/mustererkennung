function [featureNames] = getFeatureNames()
%getFeatureNames get the feature Names of the dataset
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
end