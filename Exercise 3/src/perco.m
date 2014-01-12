function [ w ] = perco( X,t,maxEpoches )
%PERCO calculates the perceptron weight vector w fort the training set (X;
%t) usiing the training method described in the lectures. The training set
%is in the format described in the lectures (the ith column X(:,i) contains
%the ith training example and t(i) contains the ith target (class label), 
%the latter using +1/1 coding). In maxEpoches, one gives the maximal 
%permissible number of training epochs.
% AUTHORS
%   * David Pfahler
% INPUT
%   X ... the training example
%   t ... the training target (class label)
%   maxEpoches ... the maximal permissible number of training epochs

%Implemented using the Online Perceptron Training Algorithmus

%% Initialise w,y

sX = size(X);

w = zeros(sX(1),1);
y = 1; %Learningrate
n = 0; %iteration of the epoche
failClass = true; %number of errors in one iteration

assert(y > 0);

%%Iterate until all patterns correctly classified or maxEpoches is reached
while n < maxEpoches && failClass == true
    n = n + 1;
    failClass = false;
    
    for i = 1:sX(2)
        if w'*(X(:,i)*t(i)) <= 0
            w = w + y*X(:,i)*t(i);
            failClass = true;
        end
    end
end

if failClass == false
   fprintf('The algorithm classified all patterns correctly at the epoche %d!\n',n) 
end


end

