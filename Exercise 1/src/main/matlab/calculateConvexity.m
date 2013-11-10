%% Calculate Convexity
% Author: _David Pfahler_
%
% Calculates the convexity of the input Binary Image
%% INPUT
% inputImage ... input binary Image
%% OUTPUT
% feature ... the convexity feature
%% EXAMPLE
% convexity=calculateConvexity( inputImage )
function [ feature ] = calculateConvexity( inputImage )

convexHull = regionprops(inputImage, 'ConvexImage');
pConvexHull = regionprops(convexHull.('ConvexImage'),'Perimeter');
pImage = regionprops(inputImage,'Perimeter');


convexity = pConvexHull.('Perimeter')/pImage.('Perimeter');
feature = struct('Convexity',convexity);

end

