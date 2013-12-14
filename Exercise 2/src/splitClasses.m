function [ trainingClass1, trainingClass2, trainingClass3 ] = splitClasses( trainingClasses, srTraining )
%SPLITCLASSES Summary of this function goes here
%   Detailed explanation goes here

    logicalAdressCl1 = trainingClasses == 1;
    logicalAdressCl2 = trainingClasses == 2;
    logicalAdressCl3 = trainingClasses == 3;
    
    trainingClass1 = srTraining(logicalAdressCl1, :);
    trainingClass2 = srTraining(logicalAdressCl2, :);
    trainingClass3 = srTraining(logicalAdressCl3, :);


end

