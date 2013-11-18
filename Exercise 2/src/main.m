function main()
%% MAIN Summary of this function goes here
%   Detailed explanation goes here

% Import data: 
    wines = importfile('wine.data',1,178);
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
            'Class index';
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

    class1size = length(find(wines(:,1) == 1));
    class1 = wines(1:class1size,1:end);
    class2size = length(find(wines(:,1) == 2));
    class2 = wines(class1size+1:class1size+class2size,1:end);
    class3size = length(find(wines(:,1) == 3));
    class3 = wines(class1size+class2size+1:class1size+class2size+class3size,1:end);
    
    % divide training and test dataset in half
    training = vertcat(class1(1:floor(class1size/2),:),class2(1:floor(class2size/2),:),class3(1:floor(class3size/2),:))
    test = vertcat(class1(ceil(class1size/2):end,:),class2(ceil(class2size/2):end,:),class3(ceil(class3size/2):end,:))
    
    featureCount = size(wines,2); % Attention the first is the class name!
    
%% BoxPlot Features
figure('name','The Features');

for i = 2 : featureCount 
    subplot(featureCount ,1,i);
    boxplot(test(:,i),test(:,1));
    title(featureNames{i});
end
end

