%% EFME 2013 LU Exercise 1
% Authors:
%
% * _David Pfahler_
% * _Matthias Gusenbauer_
% * _Matthias Vigele_

function main()
%% Get Input Images
classes = {'bat';'apple';'beetle';'bell';'chicken'};
classSize = 20;
[images,classnames] = getInput(classes);
% Classnames to numbers
% This is for numbers
% [ ~,~,class ] = unique(classnames,'stable'); geht bei matlab 2011/b ned...
[ ~,~,class ] = unique(classnames);

%% Get Features from Images
%Choose your Features here! (Choose wisely :P)
% possible Scalar Features:

%   'ConvexArea' = 4
%   'Eccentricity' = 7
%   'EquivDiameter' = 8
%   'EulerNumber' = 9
%   'Extent' = 10
%   'FilledArea' = 12
%   'MajorAxisLength' = 15
%   'MinorAxisLength' = 16
%   'Orientation' = 17
%   'Solidity' = 21


propertiesSelection = [4, 8, 21]; 
featureNames = selectFeatureNames(propertiesSelection);
features = zeros(length(images),length(featureNames));
%features = cell(length(images), length(featureNames));

disp('Starting Feature Detection...');
fprintf(' %s',featureNames{:});
fprintf('\n');
for i = 1:length(images)
    features(i,:) = getFeatures(images{i},featureNames);
end
disp('Feature Detection finished');
%% Scatter Plot Features
figure('name','The Dependency Of The Features');

plot = 1;
for i = 1 : length(featureNames) 
    for j = i+1 : length(featureNames)
            subplot(length(featureNames),1,plot);
            scatter(features(:,i),features(:,j),40,class,'filled');
            %scatter([features{:,i}],[features{:,j}],40,class,'filled');
            xlabel(featureNames{i});
            ylabel(featureNames{j});
            plot = plot + 1;
    end
end

%% BoxPlot Features
figure('name','The Features');

for i = 1 : length(featureNames)
    subplot(length(featureNames),1,i);
    boxplot(features(:,i),classnames);
    title(featureNames{i});
end

%% Norm Distribution abstraction plot
figure('name','Features as PDF')
cc=hsv(length(classes));

for i = 1 : length(featureNames)
    subplot(length(featureNames),1,i);
    
    for j = 1 : length(classes)
        f = features(1+(j-1)*classSize:j*classSize,i);
        h = histfit(f,9);
        set(h(1),'FaceColor',cc(j,:))
        set(h(2),'color',cc(j,:)/2);
        hold on;
    end
    title(featureNames{i});
end

end