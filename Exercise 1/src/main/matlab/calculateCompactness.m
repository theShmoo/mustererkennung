function [ feature ] = calculateCompactness( inputImage )
%CALCULATECOMPACTNESS Summary of this function goes here
%   Detailed explanation goes here

    roundness = calculateRoundness(inputImage);
    feature = sqrt(roundness.('Roundness'));

end

