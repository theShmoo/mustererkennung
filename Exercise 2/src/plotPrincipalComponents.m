function plotPrincipalComponents( data,labels,featureNames )
%plotPrincipalComponents Plots the principal components of the data set
%
% AUTHOR _David Pfahler_
% INPUT
%   data ... The standardized data.
%   labels ... The labels of the data
%   featureNames ... the feature names
%
% DESCRIPTION
%  Plots the principal components of the data set

[coefs,scores,variances,t2] = princomp(data);
gscatter(scores(:,1),scores(:,2),labels);
xlabel('1st Principal Component')
ylabel('2nd Principal Component')
% Identify points (if you want to)
% gname
figure;
% Calculate the percent of the total variability
percent_explained = 100*variances/sum(variances);
pareto(percent_explained)
xlabel('Principal Component')
ylabel('Variance Explained (%)')

%The Variable t2 is the Hotelling's T^2, it can be used to find extreme
%points

figure;
% biplot(coefs(:,1:2), 'scores',scores(:,1:2),... 
% 'varlabels',featureNames);
% or in 3D
 biplot(coefs(:,1:3), 'scores',scores(:,1:3),...
 'varlabels',featureNames);
end

