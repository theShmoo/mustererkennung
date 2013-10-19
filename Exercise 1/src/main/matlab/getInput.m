%% GETINPUT 
% Loads the classes
% OUTPUT:
%   Images ... The loaded BW images
function [ Images ] = getInput()
disp('Loading Images...');
res = '../resources/';
%This are just examples! This classes are not obligatory
bats = loadClass('bat' , res);
apples = loadClass('apple' , res);
beetles = loadClass('beetle' , res);
bells = loadClass('bell' , res);
chicken = loadClass('chicken' , res);

Images = [bats;apples;beetles;bells;chicken];
end

