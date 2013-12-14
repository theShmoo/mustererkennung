function main()
%% MAIN Summary of this function goes here
%   Detailed explanation goes here
% Random Number generator with seedpoint
rng(123401234);

% Import data: 
    wines = importfile('wine.data',1,178);

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
    
    iterations = 100;
    
    best = zeros (iterations,1);
    bestK = zeros (iterations,1);
    
    for i = 1:iterations
       [training, trainingClasses, test, testClasses] = getTrainingAndTestSet(wines,trainingSize,anz);
       
       % standardize the data by dividing each column by its standard deviation.
       srTest = test./repmat(std(test),size(test,1),1);
       srTraining = training./repmat(std(training),size(training,1),1);
       
       % plotPrincipalComponents(srTraining);
       
       testSize = size(srTest,1);
       
       result = classifyWithKNN(srTest,srTraining,trainingClasses,trainingSize, testSize);
       
       [best(i),bestK(i)] = plotResults(result, testSize, testClasses, 0);
       
    end
    %% Plot results
    meanB = mean(best);
    meanK = mean(bestK);
    plot(best);
    line([0 100],[meanB meanB],'Color','r');
    line([0 100],[meanK meanK],'Color','r');
    hold on;
    plot(bestK);
    
    hold off;
    figure;
    boxplot([best bestK],'orientation','horizontal','labels',{'Erfolg','k'});
    L1 = findobj(gca,'Tag','Median'); 

    legend(L1(1,1),['Median ',num2str(meanB),'% und k = ',num2str(meanK)]);
    

%% BoxPlot Features
%figure('name','The Features');
    
%boxplot(srTest,'orientation','horizontal','labels',featureNames);

% for i = 2 : featureCount 
%     subplot(featureCount ,1,i);
%     boxplot(test(:,i),test(:,1));
%     title(featureNames{i});
% end
end

