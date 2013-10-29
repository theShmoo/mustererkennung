%% GETINPUT
% Loads the classes
% OUTPUT:
%   Images ... The loaded BW images
%   classnames ... The name of the class of the BW image
function [ Images, classnames ] = getInput()
disp('Loading Images...');


%This are just examples! This classes are not obligatory

classes = {'bat';'apple';'beetle';'bell';'chicken'};

Images = cell(length(classes),1);

for i = 1:length(classes)
   Images{i} = loadClass( classes{i},'../resources/');
end

% This is for numbers... meh.
% classnames = ones(length(classes)*20,1);
% for i = 1:length(classes)
%     classnames(1+(i-1)*20:i*20) = i;
% end

% This is with names
classnames = cell(length(classes)*20,1);
for i = 1:length(classes)
     classnames(1+(i-1)*20:i*20) = classes(i);
end
Images = vertcat(Images{:});
end

