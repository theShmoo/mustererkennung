function [ dist1, dist2, dist3 ] = calculateMahalanobis( class1, class2, class3, sample )
%CALCULATEMAHALANOBIS Summary of this function goes here
%   Detailed explanation goes here

    %calculate the mean vectors
    meanC1 = mean(class1(:,2:end));
    meanC2 = mean(class2(:,2:end));
    meanC3 = mean(class3(:,2:end));
    
    %calculate the covariance matrices
    covMat1 = cov(class1(:, 2:end));
    covMat2 = cov(class2(:, 2:end));
    covMat3 = cov(class3(:, 2:end));
   
    dist1 = ((sample - meanC1) * inv(covMat1) * transpose((sample - meanC1)));
    dist2 = ((sample - meanC2) * inv(covMat2) * transpose((sample - meanC2)));
    dist3 = ((sample - meanC3) * inv(covMat3) * transpose((sample - meanC3)));
    
    % either mahal(X,Y) x - sample; y - reference
    % or d(I) = (Y(I,:)-mu)*inv(SIGMA)*(Y(I,:)-mu)
    % see: http://www.mathworks.de/de/help/stats/mahal.html

end
