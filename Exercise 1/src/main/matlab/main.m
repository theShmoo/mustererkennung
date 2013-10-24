%% EFME 2013 LU Exercise 1
% Authors:
% * David Pfahler
% * Matthias Gusenbauer
% * Matthias Vigele

function main()

%% Get Input Images
[images,classnames] = getInput();

%% Get Features from Images
features = arrayfun(@getFeatures,images,classnames,'UniformOutput', false);
mat = cell2mat(features);

%% Plot Features
figure;
subplot(3,1,1);
scatter(mat(:,1),mat(:,2),10,mat(:,4),'filled');
subplot(3,1,2);
scatter(mat(:,2),mat(:,3),10,mat(:,4),'filled');
subplot(3,1,3);
scatter(mat(:,1),mat(:,3),10,mat(:,4),'filled');
end