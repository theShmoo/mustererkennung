function [classifiedTest] = classifyPerceptron(srTest,w)
%% Classifies the test set
% srTest ... the test data (the ith row X(i,:) contains
% the ith test example
    classifiedTest = zeros(size(srTest,2),1);
    
    if size(w,2) < 2

        for i = 1:size(srTest,2)
            %Dot product of weight vector and feature vector + bias!
            classifiedTest(i) = (w(1) + w(2:end)'*srTest(:,i)) > 0;
        end

        classifiedTest = classifiedTest*2-1;
   
    else
        %More classes
        
        for i = 1:size(srTest,2)
            [~,index] = max(w'*[1;srTest(:,i)]);
            classifiedTest(i) = index;
        end
    
    end
    
    
end