function [ covMat ] = calculateCov( covType, data )
%CALCULATECOV Summary of this function goes here
%   Detailed explanation goes here
%      

    matSize = size(data, 1);

    if covType == 0 % identity
        
        covMat = eye(matSize);
        
    elseif covType == 1 % diagonal covMat
        
        for i=1:matSize
            
            logic = logical(eye(matSize));
            data = data - (sum(data,1)/m);
            covMat = (data' * data) / matSize;
            covMat(~logic) = 0;
            
        end
        
    elseif covType == 2 % full covMat
        
        data = data - (sum(data,1)/m);
        covMat = (data' * data) / matSize;
        
    end
end

