%function [ errorRate, performance, percentErrors ] = classifyWithNN( testData, testTarget, trainData, trainTarget )
function [ result ] = classifyWithNN( testData, testTarget, trainData, trainTarget )
%classifyWithNN Summary of this function goes here
%   For a in-depth Explanation please follow the link to the MATHWORKS 
%   documentation at: http://www.mathworks.de/de/help/nnet/gs/classify-patterns-with-a-neural-network.html

      %size of hidden layer
      hidden = 10;
      
      %create net(for pattern recognition) object
      nnet = patternnet(hidden);
      
      %set trainings algorithm
      nnet.trainFcn = 'trainrp'; %resilient backpropagation for full list 
                                %see: http://www.mathworks.de/de/help/nnet/ug/train-and-apply-multilayer-neural-networks.html#bss331l-2
      
      %%set up the ammount of training-, validation- and testdata
      %nnet.divideParam.trainRatio = 70/100; %70percent of the data is used for training
      %nnet.divideParam.valRatio = 15/100; %15percent for validation
      %nnet.divideParam.testRatio = 15/100; %15percent for testing
      
      %prepare data
      trainData = trainData';
      %trainTarget = trainTarget';
      testData = testData';
      %testTarget = testTarget';
      
      %train the network
      [nnet, tr] = train(nnet, trainData, trainTarget);
      
      %test the network error rate and performance
      result = nnet(testData);
      result =  (1 - (sum(vec2ind(testTarget) ~= vec2ind(result))/numel(vec2ind(testTarget)))) * 100;
      %errorRate = gsubtract(testTarget, result);
      %percentErrors = sum(vec2ind(testTarget) ~= vec2ind(result))/numel(vec2ind(testTarget));
      %performance = perform(nnet, testTarget, result);
      
      %figure, plotperform(tr)
      %figure, plottrainstate(tr)
      %figure, ploterrhist(errorRate)
      
end
