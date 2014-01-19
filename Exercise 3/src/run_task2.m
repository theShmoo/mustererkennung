function run_task2()    
%% Run Task2 1    

    rng(123401234);

    maxI = 4;
    load strokefeatures.mat;  
    strokefeatures=features_class;
        
    result = zeros(8,1);
    
    for i = 1:maxI
        [resultMahalanobis2C, resultMahalanobis6C, resultkNN2C, ...
            resultkNN6C, resultPerceptron2C, resultPerceptron6C,...
            resultNN2C, resultNN6C] = classifyWithAll(strokefeatures);
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