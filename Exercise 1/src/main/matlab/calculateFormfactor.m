function [ feature ] = calculateFormfactor( inputImage )
%CALCULATEROUNDNESS Summary of this function goes here
%   Detailed explanation goes here

    A = regionprops(inputImage, 'Area');
    U = regionprops(inputImage, 'Perimeter');
    formfactor = 4*pi*A.('Area')/(U.('Perimeter')*U.('Perimeter'));
    feature = struct('Formfactor',formfactor);


end

