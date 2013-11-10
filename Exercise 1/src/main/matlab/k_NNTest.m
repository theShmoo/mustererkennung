%% k_NN Test
featureSet=[5 4 3;25 35 21;170 80 120];
trainingSet=[150 90 115;6 8 4;23 36 27];
trainingLabels={'class1';'class2';'class3'};
%Expected output: class2 class3 class1
vec = k_NN(featureSet, trainingSet,trainingLabels,1)

featureSet=[5 4 3;25 35 21;170 80 120];
trainingSet=[150 90 115;6 8 4;23 36 27;145 88 117;21 34 26];
trainingLabels={'class1';'class2';'class3';'class1';'class3'};
%Expected output: class2 class3 class1
vec = k_NN(featureSet, trainingSet,trainingLabels,1)

featureSet=[5;25];
trainingSet=[10;20;23;9;26];
trainingLabels={'class1';'class2';'class2';'class1';'class2'};
%Expected output: class1 class2
vec = k_NN(featureSet, trainingSet,trainingLabels,1)

%Expected output: class2 class2
vec = k_NN(featureSet, trainingSet,trainingLabels,5)