function plotPrincipalComponents( data,labels1,labels2,featureNames )
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

[coefs,scores] = princomp(data);

%% 2 Class Plot
figure('name','Principal Components');
gscatter(scores(:,1),scores(:,2),labels1);
xlabel('1st Principal Component')
ylabel('2nd Principal Component')

%% 6 Class Plot
figure('name','Principal Components');
gscatter(scores(:,1),scores(:,2),labels2);
xlabel('1st Principal Component')
ylabel('2nd Principal Component')

%The Variable t2 is the Hotelling's T^2, it can be used to find extreme
%points

figure;
% biplot(coefs(:,1:2), 'scores',scores(:,1:2),... 
% 'varlabels',featureNames);
% or in 3D
 biplot(coefs(:,1:3), 'scores',scores(:,1:3),...
 'varlabels',featureNames);
end

