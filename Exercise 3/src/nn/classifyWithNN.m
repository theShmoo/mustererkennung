function [ errorRate, performance, result ] = classifyWithNN( testData, testTarget, trainData, trainTarget )
%classifyWithNN Summary of this function goes here
%   For a in-depth Explanation please follow the link to the MATHWORKS 
%   documentation at: http://www.mathworks.de/de/help/nnet/gs/classify-patterns-with-a-neural-network.html

      %size of hidden layer
      hidden = 10;
      
      %create net(for pattern recognition) object
      nnet = patternnet(hidden);
      
      %set trainings algorithm
      nnet.trainFcn = 'trainrp' %resilient backpropagation for full list 
                                %see: http://www.mathworks.de/de/help/nnet/ug/train-and-apply-multilayer-neural-networks.html#bss331l-2
      
      %set up the ammount of training-, validation- and testdata
      nnet.divideParam.trainRatio = 70/100; %70percent of the data is used for training
      nnet.divideParam.valRatio = 15/100; %15percent for validation
      nnet.divideParam.testRatio = 15/100; %15percent for testing
      
      %train the network
      [nnet, tr] = train(nnet, trainData, trainTarget);
      
      %test the network error rate and performance
      result = nnet(testData);
      errorRate = gsubtract(testTarget, result);
      performance = perform(nnet, testTarget, result);
      
      %view the used network
      %view(nnet);

%     %create NN object
%     nnet = network;
% 
%     %set number of input layers
%     nnet.numInputs = 1;
%     
%     %set the number of neurons in input layer
%     nnet.inputs{1}.size = dimensionality;
%     
%     %set number of hidden layers(including output layer)
%     nnet.numLayers = 2;
%     
%     %set the number of neurons in the hidden and output layer
%     nnet.layers{1}.size = 1; %hidden layer
%     nnet.layers{2}.size = 1; %output layer
%     
%     %set network connections for the NN
%     nnet.inputConnect(1) = 1; %set input layer
%     nnet.layerConnect(2 ,1) = 1; %set output of layer 1 to input of layer 2
%     nnet.outputConnect(2) = 1; %set the output layer of the NN
%     nnet.targetConnect(2) = 1; %connect output layer to target values for supervised learning
%     
%     %set the transfer function - check perceptron slides or google for
%     %information
%     nnet.layers{1}.transferFcn = 'logsig';
%     nnet.layers{2}.transferFcn = 'purelin';
%     
%     %set weights and biases and initializes the net
%     nnet.biasConnect = [1 ; 1]; %attach a bias to each layer
%     nnet = init(nnet); %initialize the set net
%     nnet.initFcn = 'initlay'; %chose initialization function
%     nnet.layers{1}.initFcn = 'initnw'; %chose initFunctions for the hiddenlayer 1
%     nnet.layers{2}.initFcn = 'initwb'; %and outputlayer 2
%     %nnet.inputWeights{1, 1}.initFcn = 'rands'; %random weight function for input layer
%     nnet.biases{2}.initFcn = 'rands'; %set bias for outputlayer
%     nnet.layerWeights{2, 1}.initFcn = 'rands'; %set random weights from layer 1 to layer 2
%     
%     %set the performance function for training
%     nnet.performFcn = 'mae' %'mae' for classification and 'mse' for function approximation
%     
%     %set the train parameters

end
