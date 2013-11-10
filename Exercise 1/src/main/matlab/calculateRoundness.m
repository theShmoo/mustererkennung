function [ feature ] = calculateRoundness( inputImage )
%CALCULATEROUNDNESS Summary of this function goes here
%   Detailed explanation goes here

    A = regionprops(inputImage, 'Area');
    major = regionprops(inputImage, 'MajorAxisLength');
    roundness = (4 * A.('Area'))/(pi * (major.('MajorAxisLength') * major.('MajorAxisLength')));
    feature = struct('Roundness', roundness);
    
end

