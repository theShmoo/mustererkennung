function [classifiedTest] = classifyPerceptron(srTest,w)
%% Classifies the test set
    classifiedTest = zeros(size(srTest,1),1);

    for i = 1:size(srTest,1)
        classifiedTest(i,1) = w'*[1;srTest(i,:)']>0;
    end
    
    classifiedTest = classifiedTest*2-1;
   
end