function [ trainingSize ] = calculateTrainingSize( data, anz )
%CALCULATETRAININGSIZE Summary of this function goes here
%   Detailed explanation goes here

    %Threshold from the smallest class. 
    thres = 0.50; % 0 < thres < 1

    %Calculate classsizes
    classSize = zeros(anz,1);
    for i = 1:anz
        classSize(i) = length(find(data(:,end) == i));
    end    

    %Find smallest class and define trainingset size
    trainingSize = ceil(min(classSize)*thres);

end

