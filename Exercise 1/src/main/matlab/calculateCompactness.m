function [ feature ] = calculateCompactness( inputImage )
%CALCULATECOMPACTNESS Summary of this function goes here
%   Detailed explanation goes here

    roundness = calculateRoundness(inputImage);
    compactness = sqrt(roundness.('Roundness'));
    feature = struct('Roundness',compactness);

end

