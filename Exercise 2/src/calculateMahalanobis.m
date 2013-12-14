function [ distances ] = calculateMahalanobis( class1, class2, class3, sample, covOption )
%CALCULATEMAHALANOBIS Summary of this function goes here
%   Detailed explanation goes here

    %calculate the mean vectors
    % meanC1 = mean(class1(:,2:end));
    % meanC2 = mean(class2(:,2:end));
    % meanC3 = mean(class3(:,2:end));
    
    %calculate the covariance matrices
    % covMat1 = calculateCov(1, class1(:, 2:end));
    % covMat2 = calculateCov(1, class2(:, 2:end));
    % covMat3 = calculateCov(1, class3(:, 2:end));
    
    meanC1 = mean(class1);
    meanC2 = mean(class2);
    meanC3 = mean(class3);
    
    %calculate the covariance matrices
    covMat1 = calculateCov(covOption, class1);
    covMat2 = calculateCov(covOption, class2);
    covMat3 = calculateCov(covOption, class3);
   
    dist1 = ((sample - meanC1) * inv(covMat1) * transpose((sample - meanC1)));
    dist2 = ((sample - meanC2) * inv(covMat2) * transpose((sample - meanC2)));
    dist3 = ((sample - meanC3) * inv(covMat3) * transpose((sample - meanC3)));
    
    distances = [dist1, dist2, dist3];
    
    % either mahal(X,Y) x - sample; y - reference
    % or d(I) = (Y(I,:)-mu)*inv(SIGMA)*(Y(I,:)-mu)
    % see: http://www.mathworks.de/de/help/stats/mahal.html

end

