function [ dist1, dist2, dist3 ] = calculateMahalanobis( class1, class2, class3, sample )
%CALCULATEMAHALANOBIS Summary of this function goes here
%   Detailed explanation goes here

    %calculate the mean vectors
    meanC1 = mean(class1);
    meanC2 = mean(class2);
    meanC3 = mean(class3);
    
    %calculate the covariance matrices
    covMat1 = cov(class1(1, 2:end));
    covMat2 = cov(class2(1, 2:end));
    covMat3 = cov(class3(1, 2:end));
    
    % either mahal(X,Y) x - sample; y - reference
    % or d(I) = (Y(I,:)-mu)*inv(SIGMA)*(Y(I,:)-mu)
    % see: http://www.mathworks.de/de/help/stats/mahal.html

end

