%% Peceptron
% This file runs the code for the first report
% Author
%   * David Pfahler

function run_perceptron(maxEpoches)
%RUN_PERCEPTRON Runs the code for the first report

%% Load data
% For training
training = load('dataperceptron/perceptrondata.dat');

% For targetdata for both training cases
classLabel1 = load('dataperceptron/perceptrontarget1.dat');
classLabel2 = load('dataperceptron/perceptrontarget2.dat');
% classLabel1 = classLabel1*2-1; Apparently we are not allowed to use this
% classLabel2 = classLabel2*2-1;
classLabel1(classLabel1==0) = -1;
classLabel2(classLabel2==0) = -1;

sTraining = size(training);

% Transpose the trainingset and add an additional column for the bias
X = ones(sTraining(2)+1,sTraining(1));
X(2:size(X,1),:) = transpose(training);

w1 = perco(X,transpose(classLabel1),maxEpoches);
w2 = perco(X,transpose(classLabel2),maxEpoches);

plot_perco_results(w1,X,classLabel1,['Decision boundary for target data set 1 with ',num2str(maxEpoches),' epochs']);
plot_perco_results(w2,X,classLabel2,['Decision boundary for target data set 2 with ',num2str(maxEpoches),' epochs']);

evaluate_perco(w1,X,classLabel1,['Decision boundary for target data set 1 with ',num2str(maxEpoches),' epochs'],1);
evaluate_perco(w2,X,classLabel2,['Decision boundary for target data set 2 with ',num2str(maxEpoches),' epochs'],1);
%% Evaluate
eval = zeros(100,1);
for maxE = 1:100
    w2 = perco(X,transpose(classLabel2),maxE);
    eval(maxE,1) = evaluate_perco(w2,X,classLabel2,['Decision boundary for target data set 2 with ',num2str(maxE),' epochs'],0);
end

figure;
plot(eval);
xlabel('epochs')
ylabel('%')

axis([0 100 0 50])
%% Logical Problems

X = [1,1,1,1;0,1,0,1;0,0,1,1];

%AND-problem
yAND = [-1 -1 -1 1];

% plot_perco_results(w1,X,yAND,'AND-Problem for class labels 1');
% plot_perco_results(w2,X,yAND,'AND-Problem for class labels 2');

%OR-problem
yOR = [-1 1 1 1];

% plot_perco_results(w1,X,yOR,'OR-Problem for class labels 1');
% plot_perco_results(w2,X,yOR,'OR-Problem for class labels 2');

%XOR-problem
yXOR = [-1 1 1 -1];

% plot_perco_results(w1,X,yXOR,'XOR-Problem for class labels 1');
% plot_perco_results(w2,X,yXOR,'XOR-Problem for class labels 2');

% Result of perceptron classification

%result1 = sign(w1'*X);
%result2 = sign(w2'*X);

% plot_perco_results(w1,X,result1,'Result of perceptron classification for class label 1');
% plot_perco_results(w2,X,result2,'Result of perceptron classification for class label 2');

wAND = perco(X,yAND, maxEpoches);
plot_perco_results(wAND,X,yAND,'AND-Problem');

wOR = perco(X,yOR, maxEpoches);
plot_perco_results(wOR,X,yOR,'OR-Problem');

wXOR = perco(X,yXOR, maxEpoches);
plot_perco_results(wXOR,X,yXOR,'XOR-Problem');



end

