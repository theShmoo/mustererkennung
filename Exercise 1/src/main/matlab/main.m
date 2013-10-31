%% EFME 2013 LU Exercise 1
% Authors:
%
% * _David Pfahler_
% * _Matthias Gusenbauer_
% * _Matthias Vigele_

function main()
%% Get Input Images
classes = {'bat';'apple';'beetle';'bell';'chicken'};
[images,classnames] = getInput(classes);
% Classnames to numbers
% This is for numbers
% [ ~,~,class ] = unique(classnames,'stable'); geht bei matlab 2011/b ned...
[ ~,~,class ] = unique(classnames);

%% Get Features from Images
features = cell(length(images),1);
%Choose your Features here! (Choose wisely :P)
propertiesSelection = [4, 8, 16]; 
featureNames = selectFeatureNames(propertiesSelection);

disp('Starting Feature Detection...');
fprintf(' %s',featureNames{:});
fprintf('\n');
for i = 1:length(images)
    features{i,1} = getFeatures(images{i},featureNames);
end

mat = cell2mat(features);
disp('Feature Detection finished');
%% Scatter Plot Features
figure('name','The Dependency Of The Features');

plot = 1;
for i = 1 : length(featureNames) 
    for j = i+1 : length(featureNames)
            subplot(length(featureNames),plot);
            scatter(mat(:,i),mat(:,j),40,class,'filled');
            xlabel(featureNames{i});
            ylabel(featureNames{j});
            plot = plot + 1;
    end
end

%% BoxPlot Features
figure('name','The Features');

for i = 1 : length(featureNames)
    subplot(length(featureNames),1,i);
    boxplot(mat(:,i),classnames);
    title(featureNames{i});
end

end