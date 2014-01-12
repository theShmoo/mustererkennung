function plot_perco_results(w,X,classLabel,titleName)
%Plots the results of the perceptron

%% define function and plot it
    f1=@(x,y) w(1)+w(2)*x+w(3)*y;
    figure;
    h = ezplot(f1); 
    set(h, 'Color', 'm');
    class1 = X(:,(classLabel==1));    
    class2 = X(:,(classLabel==-1));    
    minX = min(X,[],2);
    maxX = max(X,[],2);
    maxBorder = max([abs(minX(2:3)); abs(maxX(2:3))]);
    maxBorder = maxBorder * 0.1;
    axis([minX(2)-maxBorder maxX(2)+maxBorder minX(3)-maxBorder maxX(3)+maxBorder])
    hold on;
    plot(class1(2,:),class1(3,:), 'g*')
    plot(class2(2,:),class2(3,:), 'r+')
    legend1 = legend('decision boundary','class 1','class -1');
    set(legend1,'Location','SouthOutside');
    title(titleName);
    hold off;

end

