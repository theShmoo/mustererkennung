%% getFeatures
% Author _Matthias Gusenbauer_
% Author _David Pfahler_
%
% This function returns the feature vector of an bw input image from the
% MPEG7 CE Shape-1 Part B Database
%% INPUT
%   inputImage ... a bw image of the MPEG7 CE Shape-1 Part B Database
%   featureNames ... a vector countaining the names of the features to use
%% OUTPUT
%   featureVector ... a vector with the values of the extracted Features
%% Example
% vec = getFeatures( inputImage );

function [ featureVector ] = getFeatures( inputImage , featureNames)
    featureCount = length(featureNames);
    featureVector = zeros(1,featureCount);
    
    % Extract every feature given in the featureNames vector
    for i = 1 : featureCount
       
       % In case of multiple blobs in the image only the first one gets
       % stored
       propname = featureNames{i};
       
       if strcmp(propname,'AspectRatio')
            minor = regionprops(inputImage, 'MinorAxisLength');
            major = regionprops(inputImage, 'MajorAxisLength');
            aspectRatio = minor.('MinorAxisLength')/major.('MajorAxisLength');
            feature = struct('AspectRatio',aspectRatio);
       elseif strcmp(propname,'Formfactor')
            A = regionprops(inputImage, 'Area');
            U = regionprops(inputImage, 'Perimeter');
            formfactor = 4*pi*A.('Area')/(U.('Perimeter')*U.('Perimeter'));
            feature = struct('Formfactor',formfactor);
       else
            feature = regionprops(inputImage, propname);
            
       end
       featureVector(1,i) =  feature.(propname);
       
    end

end

