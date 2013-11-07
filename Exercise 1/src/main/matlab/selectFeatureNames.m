%% getFeatures
% Author _Matthias Gusenbauer_
% Author _David Pfahler_
% Select the features you want
% * 'Area'=             1
% * 'BoundingBox'=      2
% * 'Centroid'=         3
% * 'ConvexArea'=       4
% * 'ConvexHull'=       5
% * 'ConvexImage'=      6
% * 'Eccentricity'=     7
% * 'EquivDiameter'=    8
% * 'EulerNumber'=      9
% * 'Extent'=           10
% * 'Extrema'=          11
% * 'FilledArea'=       12
% * 'FilledImage'=      13
% * 'Image'=            14
% * 'MajorAxisLength'=  15
% * 'MinorAxisLength'=  16
% * 'Orientation'=      17
% * 'Perimeter'=        18
% * 'PixelIdxList'=     19
% * 'PixelList'=        20
% * 'Solidity'=         21
% * 'SubarrayIdx'=      22
% * 'AspectRatio'=      %23
% * 'Formfactor'=       %24 
% * 'Roundness'=        %25
% * 'Compactness'=      %26
%% INPUT
%   propertySelectionVec ... a vector with the numbers representing the
%   features
%% OUTPUT
%   featureNames ... a cell vector with the the names of the chosen
%   features

function [featureNames] = selectFeatureNames (propertySelectionVec)
    properties = {
        'Area';             %1
        'BoundingBox';      %2
        'Centroid';         %3
        'ConvexArea';       %4
        'ConvexHull';       %5
        'ConvexImage';      %6
        'Eccentricity';     %7
        'EquivDiameter';    %8
        'EulerNumber';      %9
        'Extent';           %10
        'Extrema';          %11
        'FilledArea';       %12
        'FilledImage';      %13
        'Image';            %14
        'MajorAxisLength';  %15
        'MinorAxisLength';  %16
        'Orientation';      %17
        'Perimeter';        %18
        'PixelIdxList';     %19
        'PixelList';        %20
        'Solidity';         %21
        'SubarrayIdx';      %22
        'AspectRatio';      %23
        'Formfactor';       %24 
        'Roundness';        %25
        'Compactness'       %26
        
        };
    
    featureNames = cell(length(propertySelectionVec),1);
    for i = 1:length(propertySelectionVec)
         featureNames{i,1} = properties{propertySelectionVec(i)};
    end
end
