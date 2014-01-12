function [ perc ] = evaluate_perco(w,X,classLabel,titleName,plotBool)
%Evaluates the results of the perceptron

%% define function and plot it
    f1=@(x,y) w(1)+w(2)*x+w(3)*y;
    
    class1 = X(:,(classLabel==1));    
    class2 = X(:,(classLabel==-1));
    
    errorClass1 = f1(class1(2,:),class1(3,:))<0;
    errorClass2 = f1(class2(2,:),class2(3,:))>0;
    
    entries = size(class1,2)+size(class2,2);
    error = sum(errorClass1)+sum(errorClass2);
    perc = error/entries * 100;
    
    if plotBool == 1
        fprintf('The error of the %s is:\n %d from %d data entries\n That is an Error Rate of %3.2f%%\n',titleName,error,entries,perc);
    end

end

