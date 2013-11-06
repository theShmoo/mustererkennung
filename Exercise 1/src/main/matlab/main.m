%% EFME 2013 LU Exercise 1
% Authors:
%
% * _David Pfahler_
% * _Matthias Gusenbauer_
% * _Matthias Vigele_

function main()
%% Get Input Images
classes = {'Heart';'device4';'rat';'device1';'Bone'};
classSize = 20;
[images,classnames] = getInput(classes);
imageCount = length(images);
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


propertiesSelection = [4, 7, 17]; 
featureNames = selectFeatureNames(propertiesSelection);
featureCount = length(featureNames);
features = zeros(imageCount,featureCount );

%% Logging
disp('Starting Feature Detection...');
fprintf(' %s',featureNames{:});
fprintf('\n');

%% Retrieves features for every image
for i = 1:imageCount
    features(i,:) = getFeatures(images{i},featureNames);
end
disp('Feature Detection finished');

%% Plotting image features

% Scatter Plot Features
figure('name','The Dependency Of The Features');
plot = 1;
for i = 1 : featureCount  
    for j = i+1 : featureCount 
            subplot(featureCount ,1,plot);
            gscatter(features(:,i),features(:,j),classnames);
            %scatter([features{:,i}],[features{:,j}],40,class,'filled');
            xlabel(featureNames{i});
            ylabel(featureNames{j});
            plot = plot + 1;
    end
end
legend(classes);


% BoxPlot Features
figure('name','The Features');

for i = 1 : featureCount 
    subplot(featureCount ,1,i);
    boxplot(features(:,i),classnames);
    title(featureNames{i});
end

% Norm Distribution abstraction plot
figure('name','Features as PDF')
cc=hsv(length(classes));

for i = 1 : featureCount 
    subplot(featureCount ,1,i);
    
    for j = 1 : length(classes)
        f = features(1+(j-1)*classSize:j*classSize,i);
        h = histfit(f,9);
        set(h(1),'FaceColor',cc(j,:))
        set(h(2),'color',cc(j,:)/2);
        hold on;
    end
    title(featureNames{i});
end

%% k-NN
result = cell(imageCount,imageCount-1);
for k = 1: imageCount-1
    fprintf('k = %d\n',k);
    for i = 1:imageCount
        bufferCell = k_NN(features(i,:),[features(1:i-1,:);features(1+i:end,:)],[classnames(1:i-1,:);classnames(1+i:end,:)],k);
%         bufferCell = knnclassify(features(i,:),[features(1:i-1,:);features(1+i:end,:)],[classnames(1:i-1,:);classnames(1+i:end,:)],k);
        result{i,k} = bufferCell{1};
    end
end

%% Plot Results
correct = zeros(imageCount-1,1);
for k = 1 : imageCount-1
    eval = cellfun(@strcmp, classnames, result(:,k));
    correct(k,1) = sum(eval);
end

xmax = find(max(correct) == correct);
imax = xmax(1);
figure('name','k-Error');
hold on;
plot(correct, 'LineWidth', 2);
axis([0 100 0 100]);
title('Grand Canion');
xlabel('k from k-NN');
ylabel('% of correct classification');
text(imax,correct(imax),['Maximum =  ',num2str(correct(imax))],...
    'VerticalAlignment','bottom',...
    'HorizontalAlignment','left',...
    'FontSize',11);
plot(imax,correct(imax),'ro');
hold off;

end