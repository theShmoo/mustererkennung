%% MAIN Summary of this function goes here
%   Detailed explanation goes here
function main()

% Random Number generator with seedpoint
rng(123401234);

% Import data: 
wines = importfile('wine.data',1,178);

%% Analyse Data:
% BoxPlot Features

featureNames = getFeatureNames();
srWine = wines(:,2:end)./repmat(std(wines(:,2:end)),size(wines(:,2:end),1),1);
figure('name','The Features');
boxplot( srWine, 'orientation','horizontal', 'labels',featureNames);
plotPrincipalComponents(srWine,wines(:,1),featureNames);

%% Classify

%Threshold from the smallest class. 
thres = 0.50; % 0 < thres < 1
%Number of classes in the dataset
anz = 3;

%Calculate classsizes
classSize = zeros(anz,1);
for i = 1:anz
    classSize(i) = length(find(wines(:,1) == i));
end    

%Find smallest class and define trainingset size
trainingSize = ceil(min(classSize)*thres);

fprintf('The trainingset has %d values per class! That means We should use %d features\n',trainingSize,floor(trainingSize/10));

iterations = 30;

% Type of covariance matrix you want
% 0 = identity
% 1 = diagonal covariance matrix
% 2 = full covariance matrix
% 3 = matlab implementation of mahab
covMatType = 1;

%Data for the results:
best = zeros (iterations,1);
bestK = zeros (iterations,1);
requiredData = [1 11 21];
kData = zeros (iterations,size(requiredData,2));
mahabResults = zeros (iterations, 1);

for i = 1:iterations
   [training, trainingClasses, test, testClasses] = getTrainingAndTestSet(wines,trainingSize,anz);

   % standardize the data by dividing each column by its standard deviation.
   srTest = test./repmat(std(test),size(test,1),1);
   srTraining = training./repmat(std(training),size(training,1),1);

   % plotPrincipalComponents(srTraining);
   
   mahabResults(i) = classifyWithMahalanobis(trainingClasses, srTraining, testClasses, srTest);

   result = classifyWithKNN(srTest,srTraining,trainingClasses,featureNames);

   [best(i),bestK(i),kData(i,:)] = getResults(result, testClasses, requiredData, 0);

end
kData = 100 - kData;
%% Plot results

%Lineplot of best results
figure('name','Lineplot of best results');
meanB = median(best);
meanK = median(bestK);
L2 = plot(best);
L1 = line([1 size(best,1)],[meanB meanB],'Color','r');
line([1 size(best,1)],[meanK meanK],'Color','r');
axis([1 iterations 0 100])
hold on;
L3 = plot(bestK,'Color','g');
hold off;

legend([L1,L2,L3],{ ...
    ['Median ',num2str(meanB),'% and Median k = ',num2str(meanK)], ...
    'Performance of the classifier',...
    'best k from kNN classifier'}, ...
    'Location','NorthOutside');
title('Best results');

%Boxplot
figure('name','Boxplot');
boxplot([best bestK],'orientation','horizontal','labels',{'Erfolg','k'});
L1 = findobj(gca,'Tag','Median'); 

legend(L1(1,1),['Median ',num2str(meanB),'% and Median k = ',num2str(meanK)], ...
    'Location','NorthOutside');
title('Classification performance and best k');

%Lineplot of errors with k = 1,21,22
figure('name',['Lineplot of errors with k = ',num2str(requiredData)]);
bar(median(kData));
set(gca, 'XTickLabel',requiredData)
xlabel('k from k-NN');
ylabel('Median of classification error [%]');
title(['Lineplot of errors with k = ',num2str(requiredData)]);

%Barplot of Mahalanobis quality
figure('name', 'Results of Testset 1...3 in %');
bar((1:iterations), mahabResults)
axis([0 31 0 100]);
xlabel('# of Testrun');
ylabel('Successrate in percent');
title('Barplot of Mahalanobis results');

end

