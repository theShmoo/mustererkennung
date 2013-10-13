%% EFME 2013 LU Exercise 1
% Authors:
% * David Pfahler
% * Matthias Gusenbauer
% * Matthias Vigele

function main()

%% Get Input Images
images = getInput();

%% Get Features from Images
features = arrayfun(getFeatures,images);

end


