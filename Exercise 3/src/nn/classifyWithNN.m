function [ output_args ] = classifyWithNN( dimensionality )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    %create NN object
    nnet = network;

    %set number of input layers
    nnet.numInputs = 1;
    
    %set the number of neurons in input layer
    nnet.inputs{1}.size = dimensionality;
    
    %set number of hidden layers(including output layer)
    nnet.numLayers = 2;
    
    %set the number of neurons in the hidden and output layer
    nnet.layers{1}.size = 1; %hidden layer
    nnet.layers{2}.size = 1; %output layer
    
    %set network connections for the NN
    nnet.inputConnect(1) = 1; %set input layer
    nnet.layerConnect(2 ,1) = 1; %set output of layer 1 to input of layer 2
    nnet.outputConnect(2) = 1; %set the output layer of the NN
    nnet.targetConnect(2) = 1; %connect output layer to target values for supervised learning
    
    %set the transfer function - check perceptron slides or google for
    %information
    nnet.layers{1}.transferFcn = 'logsig';
    nnet.layers{2}.transferFcn = 'purelin';
    
    %TODO weights and biases, training, and checking
    

end
