%% GETINPUT 
% Loads the classes
% OUTPUT:
%   Images ... The loaded BW images
function [ Images ] = getInput()
disp('Loading Images...');
%This are just examples! This classes are not obligatory
bats = loadClass('bat' , '../resources/');
apples = loadClass('apple' , '../resources/');
beetles = loadClass('beetle' , '../resources/');
bells = loadClass('bell' , '../resources/');
chicken = loadClass('chicken' , '../resources/');

Images = [bats;apples;beetles;bells;chicken];
end

