function plot_perco_results(w,X,classLabel1,titleName)
%Plots the results of the perceptron

%% define function and plot it
    f1=@(x,y) w(1)+w(2)*x+w(3)*y;
    figure;
    ezplot(f1); 
    class1 = X(:,(classLabel1==1));    
    class2 = X(:,(classLabel1==-1));    
    minX = min(X,[],2);
    maxX = max(X,[],2);
    maxBorder = max([abs(minX(2:3)); abs(maxX(2:3))]);
    maxBorder = maxBorder * 0.1;
    axis([minX(2)-maxBorder maxX(2)+maxBorder minX(3)-maxBorder maxX(3)+maxBorder])
    hold on;
    plot(class1(2,:),class1(3,:), 'g*')
    plot(class2(2,:),class2(3,:), 'r+')
    
    title(titleName);
    hold off;

end

