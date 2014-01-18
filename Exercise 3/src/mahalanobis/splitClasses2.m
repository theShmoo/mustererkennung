function [ trainingClass1, trainingClass2 ] = splitClasses2( trainingClasses, srTraining )
%SPLITCLASSES Summary of this function goes here
%   Detailed explanation goes here

    logicalAdressCl1 = trainingClasses == 1;
    logicalAdressCl2 = trainingClasses == 2;

    
    trainingClass1 = srTraining(logicalAdressCl1, :);
    trainingClass2 = srTraining(logicalAdressCl2, :);



end