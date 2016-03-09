clc;
clear all;
close all;
%%
% Image : vegan.jpg.
% Using a simple absolute sum of difference metric for the comparisions.
% Image size is reduced to 1/2.
%%
imo = imread('vegan.jpg');
imo1 = imread('vegan-modified.jpg');
im = imresize(imo, 0.5, 'bilinear');
im1 = imresize(imo1, 0.5, 'bilinear');
templateo = imread('soy-dessert.jpg');
template = imresize(templateo, 0.5, 'bilinear');
%%
% Comparisions using absolute sum of differences
% A function "compare" is used which computes the minimum absolute sum of
% difference.
%%
[x1, y1] = size(im);
[x11, y11] = size(im1);
[x2, y2] = size(template);
[idx, idy] = compare(im,template);
[idx1, idy1] = compare(im1,template);
%%
% Not working for vegan-modified.jpg. As we can see, the image has a layer
% of white on top. Most of the pixels are white hence while taking the
% difference, we get a wrong value and hence matching is done incorrectly. 
%%
figure, imshow(imo)
title('Original image')
rectangle('Position',[2*idy,2*idx,2*y2,2*x2],'EdgeColor','r','Linewidth',2)
figure, imshow(imo1)
title('Original image')
rectangle('Position',[2*idy1,2*idx1,2*y11,2*x11],'EdgeColor','r','Linewidth',2)