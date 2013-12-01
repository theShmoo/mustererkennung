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

    thres = 0.50; % 0 < thres < 1

    class1size = length(find(wines(:,1) == 1));
    class1 = wines(1:class1size,:);
    class1training = class1(1:floor(class1size*thres),:);
    class1test = class1(floor(class1size*thres)+1:end,:);
    
    assert(isequal(class1,[class1training; class1test]), 'Class 1 is not split correctly');
    
    class2size = length(find(wines(:,1) == 2));
    class2 = wines(class1size+1:class1size+class2size,:);
    class2training = class2(1:floor(class2size*thres),:);
    class2test = class2(floor(class2size*thres)+1:end,:);
    
    assert(isequal(class2,[class2training; class2test]), 'Class 2 is not split correctly');
    
    class3size = length(find(wines(:,1) == 3));
    class3 = wines(class1size+class2size+1:class1size+class2size+class3size,:);
    class3training = class3(1:floor(class3size*thres),:);
    class3test = class3(floor(class3size*thres)+1:end,:);
    
    assert(isequal(class3,[class3training; class3test]), 'Class 3 is not split correctly');

    assert(isequal(wines,[class1; class2; class3]), 'Classes are not split correctly');
    
    % divide training and test dataset
    training = vertcat(class1training,class2training,class3training);
    trainingClasses = training(:,1);
    training = training(:,2:end);
    test = vertcat(class1test,class2test,class3test);
    testClasses = test(:,1);
    test = test(:,2:end);
    
    %featureCount = size(wines,2); % Attention the first is the class name!

%% Standardize data
% standardize the data by dividing each column by its standard deviation.
% This code is from the matlab tutorial (TODO)

srTest = test./repmat(std(test),size(test,1),1);
srTraining = training./repmat(std(training),size(training,1),1);

% Normalize data
% srTest = srTest/norm(srTest);
% srTraining = srTraining/norm(srTraining);

%% Find principal components
%
[coefs,scores,variances,t2] = princomp(srTraining);
gscatter(scores(:,1),scores(:,2),trainingClasses);
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
% biplot(coefs(:,1:2), 'scores',scores(:,1:2),... 
% 'varlabels',featureNames);
% or in 3D
 biplot(coefs(:,1:3), 'scores',scores(:,1:3),...
 'varlabels',featureNames);

%% k-NN
% Sei n die Anzahl Trainingsstichproben pro Klasse, und d die Anzahl 
% Merkmale. Das Verh?ltnis
% n/d soll > 10
fprintf('The trainingset of class 1 has %d values! That means We should use %d features\n',floor(class1size*thres),floor(floor(class1size*thres)/10));
fprintf('The trainingset of class 2 has %d values! That means We should use %d features\n',floor(class2size*thres),floor(floor(class2size*thres)/10));
fprintf('The trainingset of class 3 has %d values! That means We should use %d features\n',floor(class3size*thres),floor(floor(class3size*thres)/10));

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

testSize = size(srTest,1);
result = zeros(testSize,testSize);
for k = 1:size(srTraining,1)
    result(:,k) = knnclassify(srTest(:,features),srTraining(:,features),trainingClasses,k);
end

% Plot Results
correct = zeros(testSize,1);
for k = 1 : testSize
    eval = result(:,k) == testClasses;
    correct(k,1) = sum(eval)/size(eval,1)*100;
end

xmax = find(max(correct) == correct);
imax = xmax(1);
figure('name','k-Error');
hold on;
plot(correct, 'LineWidth', 2);
axis([1 testSize 0 100]);
title('Results');
xlabel('k from k-NN');
ylabel('% of correct classification');
l = plot(imax,correct(imax),'ro');
legend(l,['Maximum =  ',num2str(correct(imax)), '% matches at k = ', num2str(imax)])
hold off;

%% BoxPlot Features
figure('name','The Features');
    
boxplot(srTest,'orientation','horizontal','labels',featureNames);

% for i = 2 : featureCount 
%     subplot(featureCount ,1,i);
%     boxplot(test(:,i),test(:,1));
%     title(featureNames{i});
% end
end

