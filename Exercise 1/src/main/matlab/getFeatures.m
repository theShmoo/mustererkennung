%% getFeatures
% Author _Matthias Gusenbauer_
% Author _David Pfahler_
%
% This function returns the feature vector of an bw input image from the
% MPEG7 CE Shape-1 Part B Database
%% INPUT
%   inputImage ... a bw image of the MPEG7 CE Shape-1 Part B Database
%   featureCount ... the length of the feature vector and number of
%   features to extract
%% OUTPUT
%   featureVector ... a vector with the values of the extracted Features
%% Example
% vec = getFeatures( inputImage );

function [ featureVector ] = getFeatures( inputImage )

    inputImage = inputImage{1};

    properties = {'Area'; 'BoundingBox'; 'Centroid'; 'ConvexArea'; 
        'ConvexHull'; 'ConvexImage'; 'Eccentricity'; 'EquivDiameter';
        'EulerNumber'; 'Extent'; 'Extrema'; 'FilledArea'; 'FilledImage';
        'Image'; 'MajorAxisLength'; 'MinorAxisLength'; 'Orientation';
        'Perimeter'; 'PixelIdxList'; 'PixelList'; 'Solidity'; 'SubarrayIdx'};
    
    %needs to be length = featureCount
    propertySelectionVec = [9, 15, 16];
    featureCount = length(propertySelectionVec);
    featureVector = cell( featureCount, 1 );
    
    for i = 1 : featureCount
        
       featureVector{i} = regionprops(inputImage, properties{propertySelectionVec(i)});
        
    end

end

