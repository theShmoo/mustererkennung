function [ trainingClass1, trainingClass2, trainingClass3, trainingClass4, trainingClass5, trainingClass6 ] = splitClasses6( trainingClasses, srTraining )
%SPLITCLASSES Summary of this function goes here
%   Detailed explanation goes here

    logicalAdressCl1 = trainingClasses == 1;
    logicalAdressCl2 = trainingClasses == 2;
    logicalAdressCl3 = trainingClasses == 3;
    logicalAdressCl4 = trainingClasses == 4;
    logicalAdressCl5 = trainingClasses == 5;
    logicalAdressCl6 = trainingClasses == 6;
    
    trainingClass1 = srTraining(logicalAdressCl1, :);
    trainingClass2 = srTraining(logicalAdressCl2, :);
    trainingClass3 = srTraining(logicalAdressCl3, :);
    trainingClass4 = srTraining(logicalAdressCl4, :);
    trainingClass5 = srTraining(logicalAdressCl5, :);
    trainingClass6 = srTraining(logicalAdressCl6, :);


end

