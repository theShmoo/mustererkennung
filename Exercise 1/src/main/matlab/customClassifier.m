%% customClassifier
% Author _Matthias Vigele_
%
% This function returns the classes of a set of feature vectors by
% comparing their eccentricity,roundness and solidity values with manualy
% setted thresholds
%% INPUT
%   featureSet ... a matrix with values of extracted Features, values
%   describing the same image are in the same row
%% OUTPUT
%   classNames ... a cell vector containing the names of the detected
%   classes. Either 'Heart','device4','bat','device1' or 'Bone' can be
%   detected.
%% Example
% vec = customClassifier(featureSet);
function [classNames]= customClassifier(featureSet)

 classNames = cell(size(featureSet,1),1);
 
    for i = 1:size(featureSet,1)
       featureV=featureSet(i,:);
       %eccentricity threshold
       
       %eccentricity of 0-0.16->device1
       classNames{i}='device1';
       
       if(featureV(1)>=0.16)
               %device1 or device4  
               
               %roundness threshold
               %device4:  0.5-0.89 device1: 0.5-0.96
               
               
               %solidity threshold
               %device4:  0.47-0.99 device1: 0.43-0.86
               classNames{i}='device1';
               if(featureV(3)>=0.87)
               classNames{i}='device4';
               end
           
       end
       
       if(featureV(1)>=0.2)
               %device4   
               classNames{i}='device4';         
       end
       if(featureV(1)>=0.46)
               %heart
               classNames{i}='Heart';         
       end       
       if(featureV(1)>=0.8)
           %bat or heart
           classNames{i}='bat';         
           %roundness threshold
           if(featureV(2)>=0.4)
           %heart
           classNames{i}='Heart';                     
           end
       end
       if(featureV(1)>=0.96)
           %bone
           classNames{i}='Bone';          
       end
        
    end


end