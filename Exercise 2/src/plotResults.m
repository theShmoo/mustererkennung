function [best,imax,kData] = plotResults(result, testSize, testClasses, requiredData, doPlot)
% plotResults This function plots the results of a classification
%
% AUTHOR _David Pfahler_
% INPUT
%   result ... The results from the classification
%   testSize ... The size of the test set
%   testClasses ... The labels of the test set
%   requiredData ... the k's you are interested in
%   doPlot ... 1 if it should plot, 0 if not
% OUTPUT
%   best ... the best result from all knn classifications
%   imax ... the k of the best result
%   kData ... the results from the requiredData k's
%
% DESCRIPTION
%   This function plots the results of a classification

correct = zeros(testSize,1);
for k = 1 : size(result,2)
    eval = result(:,k) == testClasses;
    correct(k,1) = sum(eval)/size(eval,1)*100;
end

kData = correct(requiredData);

xmax = find(max(correct) == correct);
imax = xmax(1);
best = correct(imax);

if doPlot == 1
    figure('name','k-Error');
    hold on;
    plot(correct, 'LineWidth', 2);
    axis([1 testSize 0 size(result,2)]);
    title('Results');
    xlabel('k from k-NN');
    ylabel('% of correct classification');
    l = plot(imax,correct(imax),'ro');
    legend(l,['Maximum =  ',num2str(correct(imax)), '% matches at k = ', num2str(imax)])
    hold off;
end

end

