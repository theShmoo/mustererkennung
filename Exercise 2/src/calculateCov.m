function [ covMat ] = calculateCov( covType, data )
%CALCULATECOV Summary of this function goes here
%   Detailed explanation goes here
%      

    dataCount = size(data, 1);
    finalSize = size(data, 2);

    if covType == 0 % identity
        
        covMat = eye(finalSize);
        
    elseif covType == 1 % diagonal covMat
        
        logic = logical(eye(finalSize));
        data = bsxfun(@minus, data,sum(data,1)/dataCount);
        covMat = (data' * data) / dataCount;
        covMat(~logic) = 0;
        
    elseif covType == 2 % full covMat
        
        data = bsxfun(@minus, data,sum(data,1)/dataCount);
        covMat = (data' * data) / dataCount;
        
    end
end

