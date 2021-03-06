%% GETINPUT
% Loads the classes
% INPUT:
%   classes ... Load this classes from the database
% OUTPUT:
%   Images ... The loaded BW images
%   classnames ... The name of the class of the BW image

function [ Images, classnames ] = getInput(classes)

disp('Loading Images...');

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

disp('Loading Images finished');

end

