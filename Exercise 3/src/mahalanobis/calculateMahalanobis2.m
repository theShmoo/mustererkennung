function [ distances ] = calculateMahalanobis2( class1, class2, sample, covOption )
%CALCULATEMAHALANOBIS Summary of this function goes here
%   Detailed explanation goes here
    
    if covOption ~= 3 
        
        meanC1 = mean(class1);
        meanC2 = mean(class2);
        

        %calculate the covariance matrices
        covMat1 = calculateCov(covOption, class1);
        covMat2 = calculateCov(covOption, class2);


        dist1 = ((sample - meanC1) * inv(covMat1) * transpose((sample - meanC1)));
        dist2 = ((sample - meanC2) * inv(covMat2) * transpose((sample - meanC2)));
      

        distances = [dist1, dist2];
    
    else%if  covOption == 4 
        
        dist1 = mahal(sample, class1);
        dist2 = mahal(sample, class2);
 
        
        distances = [dist1, dist2];
        
    end
    
    % either mahal(X,Y) x - sample; y - reference
    % or d(I) = (Y(I,:)-mu)*inv(SIGMA)*(Y(I,:)-mu)
    % see: http://www.mathworks.de/de/help/stats/mahal.html

end

