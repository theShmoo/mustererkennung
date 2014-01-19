function main()
%Main Function that starts all the code for the Exercise 3
% Author
%   * David Pfahler
%   * Matthias Gusenbauer
%   * Matthias Vigele
%    run_perceptron(10);
    run_perceptron(100);
    
    %LOAD stroke data
    %strokefeatures.mat is a matrix consisting of 21 columns and 155 rows. 
    %Columns 1 - 10 contain the mean of the reflected infrared light at the 
    %corresponding wavelength. Columns 11 - 20 contain the standard 
    %deviation of columns 1 - 10 respectively. Column 21 contains the class 
    %of the strokes, where:
    %"dry strokes":
    %Black lead = 1 (row 1-24)total: 24
    %Black chalk = 2 (row 25-56) 32
    %Silver point = 3 (row 57-82) 26
    %"wet strokes":
    %Paint brush = 4 (row 83-102) 20
    %Reed pen = 5 (row 103-120) 18
    %Goose quill = 6 (row 121-155) 35
    load strokefeatures.mat;  
    strokefeatures=features_class;
    
%% Get test and Trainingsdata

    [training2C, trainingClasses2C, test2C, testClasses2C] = getSets(strokefeatures, 2);
    [training6C, trainingClasses6C, test6C, testClasses6C] = getSets(strokefeatures, 6);
    
    % standardize the data by dividing each column by its standard deviation.
    test2C = test2C./repmat(std(test2C),size(test2C,1),1);
    training2C = training2C./repmat(std(training2C),size(training2C,1),1);
    test6C = test6C./repmat(std(test6C),size(test6C,1),1);
    training6C = training6C./repmat(std(training6C),size(training6C,1),1);
    
    features=[12 17 19 20];
    
%% 2 Class Problem
    %"dry strokes"=1 (row 1-82) 82
    %"wet strokes"=2 (row 83-155)73
    stroketraining= strokefeatures(1:41,1:end);
    stroketraining=[stroketraining;strokefeatures(83:119,:)];
    
    training=stroketraining(:,1:20); 
    trainingClasses=stroketraining(:,21);
    trainingClasses(trainingClasses<4)=1;
    trainingClasses(trainingClasses>3)=2;
    
    stroketest= strokefeatures(42:82,:);   
    stroketest=[stroketest;strokefeatures(120:155,:)];  
    
    test=stroketest(:,1:20); 
    testClasses=stroketest(:,21);
    testClasses(testClasses<4)=1;
    testClasses(testClasses>3)=2;
    
    %RUN methods
    
   % standardize the data by dividing each column by its standard deviation.
   srTest = test./repmat(std(test),size(test,1),1);
   srTraining = training./repmat(std(training),size(training,1),1);

%% K-NN   
   
   %Calculate classsizes
classSize = zeros(2,1);
for i = 1:2
    classSize(i) = length(find([trainingClasses;testClasses] == i));
end    

%Find smallest class and define trainingset size
trainingSize = ceil(min(classSize)*0.5);

fprintf('The trainingset has %d values per class! That means We should use %d feature(s)\n',trainingSize,round(trainingSize/10));
    
%features=[1 2 3 4]; % 53.2468 Prozent bei k = 75
%features=[1]; % 53.2468 Prozent bei k = 75

%features=[19]; % 90.9091 Prozent (bei k = 29)
%features=[20]; % 90.9091 Prozent (bei k von 1 bis 78)

%features=[15 19]; % 90.9091 Prozent (bei k = 55)
%features=[19 20]; % 90.9091 Prozent (bei k von 1 bis 78)

%features=[15 17 19]; % 89.6104 Prozent (bei k von 1 bis 78)
%features=[15 18 19]; % 89.6104 Prozent (bei k von 1 bis 78)
%features=[12 19 20]; % 90.9091 Prozent (bei k von 1 bis 78)

features=[12 17 19 20]; % 92.2078 Prozent (bei k = 53)

%features=[12 17 18 19 20]; % 92.2078 Prozent (bei k von 1 bis 78)

%features=[2 12 17 18 19 20]; % 92.2078 Prozent (bei k von 1 bis 78)

%features=[2 11 12 17 18 19 20]; % 87.0130 Prozent (bei k von 1 bis 78)


   %result = zeros(size(srTest,1));
    successRate=zeros(1,size(srTraining,1));
    for k=1:size(srTraining,1)
    %for features=1:20 % 57.1429 Prozent bei k = 23 und feature 3  
    result = knnclassify(srTest(:, features),srTraining(:, features),trainingClasses,k);
    eval = result == testClasses;
    correct=0;
    for j = 1 : size(eval)
        if eval(j)==1
            correct=correct+1;
        end
    %end
    
    %error rate in percent
    successRate(1,k)=correct/size(srTest,1)*100;  
    
    end
    end
    %maximum=max(successRate,[],2);
    
    %% Mahalanobis
    % Type of covariance matrix you want
    % 0 = identity
    % 1 = diagonal covariance matrix
    % 2 = full covariance matrix
    % 3 = matlab implementation of mahab
    covMatType = 1;
    
 
    

    %result = zeros(size(srTest,1));
    addpath('mahalanobis');

    result = classifyWithMahalanobis2(trainingClasses, srTraining, testClasses, srTest, covMatType);
   
  
   

    
%% 6 Class Problem  
    %FIND training set
    stroketraining= strokefeatures(1:12,1:end);
    stroketraining=[stroketraining;strokefeatures(25:40,:)];
    stroketraining=[stroketraining;strokefeatures(57:69,:)];
    stroketraining=[stroketraining;strokefeatures(83:92,:)];
    stroketraining=[stroketraining;strokefeatures(103:111,:)];
    stroketraining=[stroketraining;strokefeatures(121:138,:)];
    
    training=stroketraining(:,1:20); 
    trainingClasses=stroketraining(:,21); 
    
    %FIND test set
    stroketest= strokefeatures(13:24,:);   
    stroketest=[stroketest;strokefeatures(41:56,:)];
    stroketest=[stroketest;strokefeatures(70:82,:)];    
    stroketest=[stroketest;strokefeatures(93:102,:)];  
    stroketest=[stroketest;strokefeatures(112:120,:)];
    stroketest=[stroketest;strokefeatures(139:155,:)];
    
    test=stroketest(:,1:20); 
    testClasses=stroketest(:,21);
    
    %RUN methods
    
   % standardize the data by dividing each column by its standard deviation.
   srTest = test./repmat(std(test),size(test,1),1);
   srTraining = training./repmat(std(training),size(training,1),1);

%% K-NN
%Calculate classsizes
classSize = zeros(6,1);
for i = 1:6
    classSize(i) = length(find(strokefeatures(:,21) == i));
end    

%Find smallest class and define trainingset size
trainingSize = ceil(min(classSize)*0.5);

fprintf('The trainingset has %d values per class! That means We should use %d feature(s)\n',trainingSize,round(trainingSize/10));
   
   
    %features=[1:20]; % 64.9351 Prozent bei k = 20    
    features=[1:5 16:20]; % 64.9351 Prozent bei k = 4
    %features=[6:10 11:15]; %63.6364 Prozent bei k = 17;61.0390 bei k = 1
   
    %features=[1:5 11:15]; % 62.3377 Prozent bei k = 1
    %features=[6:10 16:20]; % 63.6364 Prozent bei k = 6; 55.8442 Prozent bei k = 1
    
   %result = zeros(size(srTest,1));
    successRate=zeros(1,size(srTraining,1));
    for k=1:size(srTraining,1)
    %for features=1:20 % 57.1429 Prozent bei k = 23 und feature 3  
    result = knnclassify(srTest(:, features),srTraining(:, features),trainingClasses,k);
    eval = result == testClasses;
    correct=0;
    for j = 1 : size(eval)
        if eval(j)==1
            correct=correct+1;
        end
    %end
    
    %error rate in percent
    successRate(1,k)=correct/size(srTest,1)*100;  
    
    end
    end
    
    %% Mahalanobis
    % Type of covariance matrix you want
    % 0 = identity
    % 1 = diagonal covariance matrix
    % 2 = full covariance matrix
    % 3 = matlab implementation of mahab
    covMatType = 1;   

    %result = zeros(size(srTest,1));
    addpath('mahalanobis');

    result = classifyWithMahalanobis6(trainingClasses, srTraining, testClasses, srTest, covMatType);
    
    %% Neural Network
    % defines data to use for the NN
    % then runs classification with NN
    addpath('nn');
    data = features_class(:, 1:(end-1));
    target2Classes = features_class(:, end);
    target2Classes(target2Classes < 4) = 1;
    target2Classes(target2Classes > 3) = 2;
    target6Classes = features_class(:, end);
    
    [error2C performance2C, percent2CError] = classifyWithNN(test2C, prepareTargets(testClasses2C, 2), training2C, prepareTargets(trainingClasses2C, 2));
    [error6C performance6C, percent6CError] = classifyWithNN(test6C, prepareTargets(testClasses6C, 6), training6C, prepareTargets(trainingClasses6C, 6));
    
    %do NN plotting here
    
    %% Perceptron
    % classify with the perceptron
    resultPerceptron2C = classifyWithPerceptron( training2C, trainingClasses2C, test2C, testClasses2C, 200);
    resultPerceptron6C = classifyWithPerceptron( training6C, trainingClasses6C, test6C, testClasses6C, 200);
    
    fprintf('%d from %d correct classified! That are %3.2f%%\n',sum(resultPerceptron2C),size(resultPerceptron2C,1),sum(resultPerceptron2C)/size(resultPerceptron2C,1)*100);
    fprintf('%d from %d correct classified! That are %3.2f%%\n',sum(resultPerceptron6C),size(resultPerceptron6C,1),sum(resultPerceptron6C)/size(resultPerceptron6C,1)*100);

end

