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
    training = vertcat(class1(1:floor(class1size/2),:),class2(1:floor(class2size/2),:),class3(1:floor(class3size/2),:));
    test = vertcat(class1(ceil(class1size/2):end,:),class2(ceil(class2size/2):end,:),class3(ceil(class3size/2):end,:));
    
    featureCount = size(wines,2); % Attention the first is the class name!

%% Standardize data
% standardize the data by dividing each column by its standard deviation.
% This code is from the matlab tutorial (TODO)
stdr = std(test);
sr = test./repmat(stdr,size(test,1),1);

%% Find principal components
%
[coefs,scores,variances,t2] = princomp(sr);
plot(scores(:,1),scores(:,2),'+')
xlabel('1st Principal Component')
ylabel('2nd Principal Component')
% Identify points (if you want to)
% gname
figure;
% Calculate the percent of the total variability
percent_explained = 100*variances/sum(variances);
pareto(percent_explained)
xlabel('Principal Component')
ylabel('Variance Explained (%)')

%The Variable t2 is the Hotelling's T^2, it can be used to find extreme
%points
figure;
biplot(coefs(:,1:2), 'scores',scores(:,1:2),... 
'varlabels',featureNames);

%% k-NN
% Sei n die Anzahl Trainingsstichproben pro Klasse, und d die Anzahl 
% Merkmale. Das Verhältnis
% n/d soll > 10
fprintf('The trainingset of class 1 has %d values! That means We should use %d features\n',floor(class1size/2),floor(floor(class1size/2)/10));
fprintf('The trainingset of class 2 has %d values! That means We should use %d features\n',floor(class2size/2),floor(floor(class2size/2)/10));
fprintf('The trainingset of class 3 has %d values! That means We should use %d features\n',floor(class3size/2),floor(floor(class3size/2)/10));

a=find(not(cellfun('isempty', strfind(featureNames,'Alcohol'))));
b=find(not(cellfun('isempty', strfind(featureNames,'Flavanoids'))));
c=find(not(cellfun('isempty', strfind(featureNames,'Proline'))));
features = [a b];

testSize = size(test,1);
result = zeros(testSize,testSize);
for k = 1:size(training,1)
    result(:,k) = knnclassify(test(:,features),training(:,features),training(:,1),k);
end

%% Plot Results
correct = zeros(testSize,1);
for k = 1 : testSize
    eval = result(:,k) == test(:,1);
    correct(k,1) = sum(eval);
end

xmax = find(max(correct) == correct);
imax = xmax(1);
figure('name','k-Error');
hold on;
plot(correct, 'LineWidth', 2);
axis([0 100 0 100]);
title('Results');
xlabel('k from k-NN');
ylabel('% of correct classification');
l = plot(imax,correct(imax),'ro');
legend(l,['Maximum =  ',num2str(correct(imax)), '% matches at k = ', num2str(imax)])
hold off;

%% BoxPlot Features
figure('name','The Features');
    
boxplot(sr,'orientation','horizontal','labels',featureNames);

% for i = 2 : featureCount 
%     subplot(featureCount ,1,i);
%     boxplot(test(:,i),test(:,1));
%     title(featureNames{i});
% end
end

