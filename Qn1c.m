clc;
clear all;
close all;
%%
% Normalized cross correlation 
% Image size is reduced by 1/4th
%%
imo = imread('vegan-modified.jpg'); 
im = imresize(imo, 0.25, 'bilinear');
templateo = imread('soy-dessert.jpg');
template = double(imresize(templateo, 0.25, 'bilinear'));
%%
% Equation for normalized cross correlation
% 
%%
[x1, y1] = size(im);
[x2, y2] = size(template);
maxncc = 0;
tic
for i = 1 : x1-x2
    for j = 1 : y1-y2
        block = double(im(i:i+x2-1,j:j+y2-1));  
        ncc = (1/numel(template)) * ((sum(sum((block - mean2(block)).*(template - mean2(template))))) / ((std2(block))*(std2(template))));
        if  ncc > maxncc
            maxncc = ncc;
            idx = i;
            idy = j;
        end
    end
end
toc
%%
% Works perfectly fine for vegan-modified.jpg.
% We can see that the brightness of the image and template vary a lot.So,
% the images have to be normalized first.
% The maximum of the cross-correlation function indicates the point where 
% the signals are similar.
% Marking a rectangle in both the original image and the resized image 
%%
figure, imshow(im)
title('Resized image')
rectangle('Position',[idy,idx,y2,x2],'EdgeColor','r','Linewidth',2)
figure, imshow(imo)
title('Original image')
rectangle('Position',[4*idy,4*idx,4*y2,4*x2],'EdgeColor','r','Linewidth',2)