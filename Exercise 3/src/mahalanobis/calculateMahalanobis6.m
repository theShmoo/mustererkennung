function [ distances ] = calculateMahalanobis6( class1, class2, class3, class4, class5, class6,sample, covOption )
%CALCULATEMAHALANOBIS Summary of this function goes here
%   Detailed explanation goes here
    
    if covOption ~= 3 
        
        meanC1 = mean(class1);
        meanC2 = mean(class2);
        meanC3 = mean(class3);
        meanC4 = mean(class4);
        meanC5 = mean(class5);
        meanC6 = mean(class6);
        

        %calculate the covariance matrices
        covMat1 = calculateCov(covOption, class1);
        covMat2 = calculateCov(covOption, class2);
        covMat3 = calculateCov(covOption, class3);
        covMat4 = calculateCov(covOption, class4);
        covMat5 = calculateCov(covOption, class5);
        covMat6 = calculateCov(covOption, class6);


        dist1 = ((sample - meanC1) * inv(covMat1) * transpose((sample - meanC1)));
        dist2 = ((sample - meanC2) * inv(covMat2) * transpose((sample - meanC2)));
        dist3 = ((sample - meanC3) * inv(covMat3) * transpose((sample - meanC3)));
        dist4 = ((sample - meanC4) * inv(covMat4) * transpose((sample - meanC4)));
        dist5 = ((sample - meanC5) * inv(covMat5) * transpose((sample - meanC5)));
        dist6 = ((sample - meanC6) * inv(covMat6) * transpose((sample - meanC6)));
      

        distances = [dist1, dist2, dist3, dist4, dist5, dist6];
    
    else%if  covOption == 4 
        
        dist1 = mahal(sample, class1);
        dist2 = mahal(sample, class2);
        dist3 = mahal(sample, class3);
        dist4 = mahal(sample, class4);
        dist5 = mahal(sample, class5);
        dist6 = mahal(sample, class6);
                                        
        
        distances = [dist1, dist2, dist3, dist4, dist5, dist6];
        
    end
    
    % either mahal(X,Y) x - sample; y - reference
    % or d(I) = (Y(I,:)-mu)*inv(SIGMA)*(Y(I,:)-mu)
    % see: http://www.mathworks.de/de/help/stats/mahal.html

end

