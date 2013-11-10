function [ feature ] = calculateAspectRatio( inputImage )
%CALCULATE Summary of this function goes here
%   Detailed explanation goes here

    minor = regionprops(inputImage, 'MinorAxisLength');
    major = regionprops(inputImage, 'MajorAxisLength');
    aspectRatio = minor.('MinorAxisLength')/major.('MajorAxisLength');
    feature = struct('AspectRatio',aspectRatio);

end

