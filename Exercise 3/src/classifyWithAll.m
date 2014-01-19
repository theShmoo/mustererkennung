function [resultMahalanobis2C, resultMahalanobis6C, resultkNN2C, resultkNN6C, resultPerceptron2C, resultPerceptron6C, resultNN2C, resultNN6C] = classifyWithAll(strokefeatures)
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
    %% Get test and Trainingsdata
    
    
    [training2C, trainingClasses2C, test2C, testClasses2C] = getSets(strokefeatures, 2);
    [training6C, trainingClasses6C, test6C, testClasses6C] = getSets(strokefeatures, 6);
    
    % standardize the data by dividing each column by its standard deviation.
    test2C = test2C./repmat(std(test2C),size(test2C,1),1);
    training2C = training2C./repmat(std(training2C),size(training2C,1),1);
    test6C = test6C./repmat(std(test6C),size(test6C,1),1);
    training6C = training6C./repmat(std(training6C),size(training6C,1),1);
    
    %% K-NN   
   
    % 2 Class
    %Calculate classsizes
    classSize = zeros(2,1);
    for i = 1:2
        classSize(i) = length(find([trainingClasses2C;testClasses2C] == i));
    end

    %Find smallest class and define trainingset size
    %trainingSize = ceil(min(classSize)*0.5);

    %fprintf('The trainingset has %d values per class! That means We should use %d feature(s)\n',trainingSize,round(trainingSize/10));   

    features=[12 17 19 20]; % 92.2078 Prozent (bei k = 53)


    successRate=zeros(1,size(training2C,1));
    for k=1:size(training2C,1)
        %for features=1:20 % 57.1429 Prozent bei k = 23 und feature 3  
        result = knnclassify(test2C(:, features),training2C(:, features),trainingClasses2C,k);
        eval = result == testClasses2C;
        correct=0;
        for j = 1 : size(eval)
            if eval(j)==1
                correct=correct+1;
            end
        %end

        %error rate in percent
        successRate(1,k)=correct/size(test2C,1)*100;  
        end
    end
    
    
    
    resultkNN2C=max(successRate);
%     maxk=find(successRate==maximum);
%     fprintf('k-NN: %3.2f%%(with k=1) were correctly classified!\n',  successRate(1,1));
%     fprintf(' %3.2f%%(with k=%d)!\n', maximum, maxk(1));   
    
    %Calculate classsizes
    classSize = zeros(6,1);
    for i = 1:6
        classSize(i) = length(find(strokefeatures(:,21) == i));
    end    

    %Find smallest class and define trainingset size
    %trainingSize = ceil(min(classSize)*0.5);

    %fprintf('The trainingset has %d values per class! That means We should use %d feature(s)\n',trainingSize,round(trainingSize/10));
     
    features=[1:5 16:20]; % 64.9351 Prozent bei k = 4

    successRate=zeros(1,size(training6C,1));
    for k=1:size(training6C,1)
        %for features=1:20 % 57.1429 Prozent bei k = 23 und feature 3  
        result = knnclassify(test6C(:, features),training6C(:, features),trainingClasses6C,k);
        eval = result == testClasses6C;
        correct=0;
        for j = 1 : size(eval)
            if eval(j)==1
                correct=correct+1;
            end
        %end

        %error rate in percent
        successRate(1,k)=correct/size(test6C,1)*100;  

        end
    end
    
      resultkNN6C=max(successRate);
%     maxk=find(successRate==maximum);
%     fprintf('k-NN: %3.2f%%(with k=1) were correctly classified!\n',  successRate(1,1));
%     fprintf(' %3.2f%%(with k=%d)!\n', maximum, maxk(1));
    
    %% Mahalanobis
    % Type of covariance matrix you want
    % 0 = identity
    % 1 = diagonal covariance matrix
    % 2 = full covariance matrix
    % 3 = matlab implementation of mahab
    covMatType = 1;

    %result = zeros(size(srTest,1));
    addpath('mahalanobis');

    resultMahalanobis2C = classifyWithMahalanobis2(trainingClasses2C, training2C, testClasses2C, test2C, covMatType);
    resultMahalanobis6C = classifyWithMahalanobis6(trainingClasses6C, training6C, testClasses6C, test6C, covMatType);
     
%     fprintf('Mahalanobis: %3.2f%% were correctly classified!\n',result); 
    
    %% Neural Network
    % defines data to use for the NN
    % then runs classification with NN
    addpath('nn');
    
    [error2C, resultNN2C, percent2CError] = classifyWithNN(test2C, prepareTargets(testClasses2C, 2), training2C, prepareTargets(trainingClasses2C, 2));
    [error6C, resultNN6C, percent6CError] = classifyWithNN(test6C, prepareTargets(testClasses6C, 6), training6C, prepareTargets(trainingClasses6C, 6));
    
%     fprintf('The neural network has %3.2f%% percent errors for the 2 class problem.\n', percent2CError);
%     fprintf('The neural network has %3.2f%% percent errors for the 6 class problem.\n', percent6CError);
    
    %% Perceptron
    % classify with the perceptron
    resultPerceptron2C = classifyWithPerceptron( training2C, trainingClasses2C, test2C, testClasses2C, 200);
    resultPerceptron6C = classifyWithPerceptron( training6C, trainingClasses6C, test6C, testClasses6C, 200);
    
    resultPerceptron2C = sum(resultPerceptron2C)/size(resultPerceptron2C,1)*100;
    resultPerceptron6C = sum(resultPerceptron6C)/size(resultPerceptron6C,1)*100;
    
%     fprintf('%d from %d correct classified! That are %3.2f%%\n',sum(resultPerceptron2C),size(resultPerceptron2C,1),sum(resultPerceptron2C)/size(resultPerceptron2C,1)*100);
%     fprintf('%d from %d correct classified! That are %3.2f%%\n',sum(resultPerceptron6C),size(resultPerceptron6C,1),sum(resultPerceptron6C)/size(resultPerceptron6C,1)*100);
    
    
end