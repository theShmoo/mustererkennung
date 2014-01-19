function barplot_results(results,maxI,plottitle)
%Plots the results of the classifier

figure('name', 'Results of Testset 1...4 in %');
bar((1:maxI), results)
axis([0 maxI+1 0 100]);
xlabel('# of Testrun');
ylabel('Successrate in percent');
title(plottitle);

end

