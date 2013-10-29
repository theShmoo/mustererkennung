%% getFeatures
% Author _Matthias Gusenbauer_
% Author _David Pfahler_
% Select the features you want
% * 'Area'=             %1
% * 'BoundingBox'=      %2
% * 'Centroid'=         %1
% * 'ConvexArea'=       %3
% * 'ConvexHull'=       %4
% * 'ConvexImage'=      %5
% * 'Eccentricity'=     %6
% * 'EquivDiameter'=    %7
% * 'EulerNumber'=      %8
% * 'Extent'=           %9
% * 'Extrema'=          %10
% * 'FilledArea'=       %11
% * 'FilledImage'=      %12
% * 'Image'=            %13
% * 'MajorAxisLength'=  %14
% * 'MinorAxisLength'=  %15
% * 'Orientation'=      %16
% * 'Perimeter'=        %17
% * 'PixelIdxList'=     %18
% * 'PixelList'=        %19
% * 'Solidity'=         %20
% * 'SubarrayIdx'=      %21
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
    
    featureNames = cell(length(propertySelectionVec),1);
    for i = 1:length(propertySelectionVec)
         featureNames{i,1} = properties{propertySelectionVec(i)};
    end
end
