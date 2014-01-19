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
    result = zeros(8,1);
    
    for i = 1:maxI
        [resultMahalanobis2C, resultMahalanobis6C, resultkNN2C, ...
            resultkNN6C, resultPerceptron2C, resultPerceptron6C,...
            resultNN2C, resultNN6C] = classifyWithAll(strokeFeatures);
        result(1) = result(1) + resultMahalanobis2C;
        result(2) = result(2) + resultMahalanobis6C;
        result(3) = result(3) + resultkNN2C;
        result(4) = result(4) + resultkNN6C;
        result(5) = result(5) + resultPerceptron2C;
        result(6) = result(6) + resultPerceptron6C;
        result(7) = result(7) + resultNN2C;
        result(8) = result(8) + resultNN6C;
    end
    
    result = result / maxI
end