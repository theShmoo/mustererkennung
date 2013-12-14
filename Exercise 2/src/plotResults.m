function [best,imax] = plotResults(result, testSize, testClasses, doPlot)
%PLOTRESULTS Summary of this function goes here
%   Detailed explanation goes here

correct = zeros(testSize,1);
for k = 1 : testSize
    eval = result(:,k) == testClasses;
    correct(k,1) = sum(eval)/size(eval,1)*100;
end

xmax = find(max(correct) == correct);
imax = xmax(1);
best = correct(imax);

if doPlot == 1
    figure('name','k-Error');
    hold on;
    plot(correct, 'LineWidth', 2);
    axis([1 testSize 0 100]);
    title('Results');
    xlabel('k from k-NN');
    ylabel('% of correct classification');
    l = plot(imax,correct(imax),'ro');
    legend(l,['Maximum =  ',num2str(correct(imax)), '% matches at k = ', num2str(imax)])
    hold off;
end

end

