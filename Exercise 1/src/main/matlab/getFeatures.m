%% getFeatures
% Author _Matthias Gusenbauer_
% Author _David Pfahler_
%
% This function returns the feature vector of an bw input image from the
% MPEG7 CE Shape-1 Part B Database
%% INPUT
%   inputImage ... a bw image of the MPEG7 CE Shape-1 Part B Database
%   class ... the class of the image
%% OUTPUT
%   featureVector ... a vector with the values of the extracted Features
%% Example
% vec = getFeatures( inputImage );

function [ featureVector ] = getFeatures( inputImage)

    inputImage = inputImage{1};

    properties = {
        'Area';             %1
        'BoundingBox';      %2
        'Centroid';         %1
        'ConvexArea';       %3
        'ConvexHull';       %4
        'ConvexImage';      %5
        'Eccentricity';     %6
        'EquivDiameter';    %7
        'EulerNumber';      %8
        'Extent';           %9
        'Extrema';          %10
        'FilledArea';       %11
        'FilledImage';      %12
        'Image';            %13
        'MajorAxisLength';  %14
        'MinorAxisLength';  %15
        'Orientation';      %16
        'Perimeter';        %17
        'PixelIdxList';     %18
        'PixelList';        %19
        'Solidity';         %20
        'SubarrayIdx'       %21
        };
    
    %needs to be length = featureCount
    propertySelectionVec = [9, 15, 16];
    featureCount = length(propertySelectionVec);
    featureVector = zeros(1,featureCount+1);
    for i = 1 : featureCount
       propname = properties{propertySelectionVec(i)};
       feature = regionprops(inputImage, propname);
       featureVector(1,i) =  feature.(propname);
    end
    featureVector(1,featureCount+1) = class;

end

