function [ target ] = prepareTargets( targets, classCount )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

target = zeros(classCount, size(targets,1));

for i = 1:classCount
    
   target(i,:) = targets == i;
    
end

end

