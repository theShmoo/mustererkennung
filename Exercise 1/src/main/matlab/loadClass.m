%% Load Class
% _Author David Pfahler_
%
% This function returns an image vector with the 20 binary images of the given
% class name of the MPEG7 CE Shape-1 Part B Database
%% INPUT
%    className ... the name of the image class (e.g.: 'bat','apple',...
%    directory ... the name of the directory
%% OUTPUT
%   I ... the image cells with 20 binary images
%% Example
% I = loadClass( 'bat' , '../resources/' );
function [ I ] = loadClass( className, directory )

currentDir = pwd;
D = dir(directory);
cd(directory);

I = cell( 20 , 1 ) ;
j = 1 ;

%% Loading the images, converting to bw and removing areas smaller than 50 pixels(should remove multiple results from regionprops)
% This code is adapted from the specification
for i = 1 : size( D, 1 )
    if D( i ).isdir == 0 && strcmp( D( i ).name( 1 : length(className) ) , className)
        I_temp = imread ( [D( i ).name ] ) ;
        I{j} = bwareaopen(im2bw( I_temp , graythresh ( I_temp ) ), 50) ;
        j = j +1;
    end
end

%% Navigate back
cd(currentDir);

fprintf('\tLoading \"%s\" Images finished\n',className);
end

