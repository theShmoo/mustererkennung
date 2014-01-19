function [resultMahalanobis2C, resultMahalanobis6C, result1NN2C, result1NN6C, resultkNN2C, resultkNN6C, resultPerceptron2C, resultPerceptron6C, resultNN2C, resultNN6C] = classifyWithAll(strokefeatures)
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
    % features=[18 16 1 6]; % 67.90%(with k=1) 76.54%(with k=11)

    successRate=zeros(1,size(training2C,1));
    for k=1:size(training2C,1)
        result = knnclassify(test2C,training2C,trainingClasses2C,k);
        eval = result == testClasses2C;
        correct=0;
        for j = 1 : size(eval)
            if eval(j)==1
                correct=correct+1;
            end

        %error rate in percent
        successRate(1,k)=correct/size(test2C,1)*100;  
        end
    end
    
    result1NN2C=max(successRate(1,1));
    resultkNN2C=max(successRate);
    
    %maxk=find(successRate==maximum);
    %fprintf('k-NN: %3.2f%%(with k=1) were correctly classified!\n',  successRate(1,1));
    %fprintf(' %3.2f%%(with k=%d)!\n', maximum, maxk(1));   
    
    % 6 Class   
    successRate=zeros(1,size(training6C,1));
    for k=1:size(training6C,1)  
        result = knnclassify(test6C,training6C,trainingClasses6C,k);
        eval = result == testClasses6C;
        correct=0;
        for j = 1 : size(eval)
            if eval(j)==1
                correct=correct+1;
            end

        %Success rate in percent
        successRate(1,k)=correct/size(test6C,1)*100;  

        end
    end
    
    result1NN6C=max(successRate(1,1));
    resultkNN6C=max(successRate);
    
    
    %maxk=find(successRate==maximum);
    %fprintf('k-NN: %3.2f%%(with k=1) were correctly classified!\n',  successRate(1,1));
    %fprintf(' %3.2f%%(with k=%d)!\n', maximum, maxk(1)); 
    
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
    
    resultNN2C = classifyWithNN(test2C, prepareTargets(testClasses2C, 2), training2C, prepareTargets(trainingClasses2C, 2));
    resultNN6C = classifyWithNN(test6C, prepareTargets(testClasses6C, 6), training6C, prepareTargets(trainingClasses6C, 6));

    
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