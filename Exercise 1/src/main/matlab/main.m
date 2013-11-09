%% EFME 2013 LU Exercise 1
% Authors:
%
% * _David Pfahler_
% * _Matthias Gusenbauer_
% * _Matthias Vigele_

function main()
%% Get Input Images
classes = {'Heart';'device4';'bat';'device1';'Bone'};
classSize = 20;
tic;
[images,classnames] = getInput(classes);
imageCount = length(images);
toc;

%% Get Features from Images
disp('################################');
disp('Starting Feature Detection...');
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
%   'AspectRatio' = 23
%   'Formfactor' = 24
%   'Roundness'=        %25
%   'Compactness'=      %26
%   'Convexity'= 27


% propertiesSelection = [7, 25];      % 99 Prozent!
% propertiesSelection = [21, 24, 25]; % 96 Prozent!
% propertiesSelection = [7, 26, 21];  % 99 Prozent!
  propertiesSelection = [7, 25, 21];  % 99 Prozent
% propertiesSelection = [7,21,23,25];  % 99 Prozent
% propertiesSelection = [7,21,23,24,25,26,27];  % 99 Prozent

featureNames = selectFeatureNames(propertiesSelection);
featureCount = length(featureNames);
features = zeros(imageCount,featureCount );

% Retrieves features for every image
fprintf('\t');
fprintf('%s ',featureNames{:});
fprintf('\n');
tic;
for i = 1:imageCount
    features(i,:) = getFeatures(images{i},featureNames);
end
disp('Feature Detection finished');
toc;
%% customClassifier
disp('################################');
disp('Starting Custom classifier...');
bufferCell = customClassifier(features);
eval = cellfun(@strcmp, classnames, bufferCell);
correctC = sum(eval);
fprintf('%d',correctC);
disp('% of correct classification');
disp('Custom classification finished');

%% k-NN
disp('################################');
disp('Starting k-NN classifier...');
result = cell(imageCount,imageCount-1);
tic;
for k = 1: imageCount-1
    fprintf('\tk = %d\n',k);
    for i = 1:imageCount
        bufferCell = k_NN(features(i,:),[features(1:i-1,:);features(1+i:end,:)],[classnames(1:i-1,:);classnames(1+i:end,:)],k);
        result{i,k} = bufferCell{1};
    end
end
disp('k-NN classification finished');
toc;

%% Plotting image features

% Scatter Plot Features
figure('name','The Dependency Of The Features');
p = 1; %the plot
for i = 1 : featureCount  
    for j = i+1 : featureCount 
            subplot(sum(1:featureCount-1) ,1,p);
            gscatter(features(:,i),features(:,j),classnames);
            %scatter([features{:,i}],[features{:,j}],40,class,'filled');
            xlabel(featureNames{i});
            ylabel(featureNames{j});
            p = p + 1;
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
text(imax,correct(imax),['Maximum =  ',num2str(correct(imax)), '% matches at k = ', num2str(imax)],...
    'VerticalAlignment','bottom',...
    'HorizontalAlignment','left',...
    'FontSize',11);
plot(imax,correct(imax),'ro');
hold off;

end