function [result] = classifyPerceptron(srTest,testClasses,w)
%% Classifies the test set
    classifiedTest = zeros(size(srTest),1);

    for i = 1:size(srTest,1)
        classifiedTest(i,1) = f1(srTest(i,:)',w)>0;
    end
    
    classifiedTest = classifiedTest*2-1;
    result = classifiedTest == testClasses;
   
end

function [out] = f1 (in,w)
% f(w_1 + w_2*in_1 + w_3*in_2 + .... + w_n*in_n
    out = dot(w,[1;in]);
end