function run_task2()    
%% Run Task2 1    

    rng(123401234);
    load strokefeatures.mat;  
    strokefeatures=features_class;
%% Analyse Data:
% BoxPlot Features
srStroke = strokefeatures(:,1:end-1)./repmat(std(strokefeatures(:,1:end-1)),size(strokefeatures(:,1:end-1),1),1);
figure('name','The Features');
boxplot( srStroke, 'orientation','horizontal', 'labels',[1:20]);
    featureNames = {'1';'2';'3';'4';'5';'6';'7';'8';'9';'10';'11';'12';'13';
                    '14';'15'; '16';'17';'18';'19';'20';
    };
labels=strokefeatures(:,21);
    labels(labels<4)=1;
    labels(labels>3)=2;
plotPrincipalComponents(srStroke,labels,strokefeatures(:,21), featureNames);

goodFeatures = [18,16,1,6,21]; %Features plus labels

%% Evaluate

evaluateAll(strokefeatures);
evaluateAll(strokefeatures(:,goodFeatures));
    

end

function evaluateAll(strokeFeatures)
    maxI = 4;
    result = zeros(10,1);
    mahabResults2C = zeros (maxI, 1);
    mahabResults6C = zeros (maxI, 1);  
    NN1Results2C = zeros (maxI, 1);
    NN1Results6C = zeros (maxI, 1);
    kNNResults2C = zeros (maxI, 1);   
    kNNResults6C = zeros (maxI, 1); 
    percepResults2C = zeros (maxI, 1);
    percepResults6C = zeros (maxI, 1);
    NNResults2C = zeros (maxI, 1);   
    NNResults6C = zeros (maxI, 1);
    
    for i = 1:maxI
        [resultMahalanobis2C, resultMahalanobis6C, result1NN2C, ...
             result1NN6C, resultkNN2C, resultkNN6C, ...
             resultPerceptron2C, resultPerceptron6C,...
            resultNN2C, resultNN6C] = classifyWithAll(strokeFeatures);
        result(1) = result(1) + resultMahalanobis2C;
        result(2) = result(2) + resultMahalanobis6C;
        result(3) = result(3) + result1NN2C;
        result(4) = result(4) + result1NN6C;        
        result(5) = result(5) + resultkNN2C;
        result(6) = result(6) + resultkNN6C;
        result(7) = result(7) + resultPerceptron2C;
        result(8) = result(8) + resultPerceptron6C;
        result(9) = result(9) + resultNN2C;
        result(10) = result(10) + resultNN6C;
        
        mahabResults2C(i)=resultMahalanobis2C;
        mahabResults6C(i)=resultMahalanobis6C;
        NN1Results2C(i)=result1NN2C;
        NN1Results6C(i)=result1NN6C;
        kNNResults2C(i)=resultkNN2C;
        kNNResults6C(i)=resultkNN6C;
        percepResults2C(i)=resultPerceptron2C;
        percepResults6C(i)=resultPerceptron6C;      
        NNResults2C(i)=resultNN2C;
        NNResults6C(i)=resultNN6C;
    end
    
    result = result / maxI
%% Plot results
%Barplots of Mahalanobis quality
barplot_results(mahabResults2C,maxI,'Barplot of Mahalanobis results (2 Classes)');
barplot_results(mahabResults6C,maxI,'Barplot of Mahalanobis results (6 Classes)');
%Barplots of Nearest Neighbour quality
barplot_results(NN1Results2C,maxI,'Barplot of Nearest Neighbour results (2 Classes)');
barplot_results(NN1Results6C,maxI,'Barplot of Nearest Neighbour results (6 Classes)');
%Barplots of knn quality
barplot_results(kNNResults2C,maxI,'Barplot of k-NN results (2 Classes)');
barplot_results(kNNResults6C,maxI,'Barplot of k-NN results (6 Classes)');
%Barplots of perceptron quality
barplot_results(percepResults2C,maxI,'Barplot of Perceptron results (2 Classes)');
barplot_results(percepResults6C,maxI,'Barplot of Perceptron results (6 Classes)');
%Barplots of Neural Network quality
barplot_results(NNResults2C,maxI,'Barplot of Neural Network results (2 Classes)');
barplot_results(NNResults6C,maxI,'Barplot of Neural Network results (6 Classes)');


%Barplot of the mean values
figure('name', 'Results of Testset 1...4 in %');
bar((1:10), result)
axis([0 11 0 100]);
set(gca,'XTickLabel',{'Ma2C', 'Ma6C', '1N2C', '1N6C', 'kN2C', 'kN6C', 'Pe2C', 'Pe6C', 'NN2C', 'NN6C'});
xlabel('Different Classifiers');
ylabel('Successrate in percent');
title('Barplot of the mean values');


end