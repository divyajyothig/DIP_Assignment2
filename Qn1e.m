clc;
clear all;
close all;
%%
% Using inbuilt normxcorr2 function 
%%
im = imread('vegan.jpg');
im1 = imread('vegan-modified.jpg');
temp = imread('soy-dessert.jpg');

c = normxcorr2( temp, im );
[yp,xp] = find(c==max(c(:)));
yoff = yp-size(temp,1);
xoff = xp-size(temp,2);
figure, imshow(im)
rectangle('Position', [xoff, yoff, size(temp,2),size(temp,1)],'EdgeColor','r','Linewidth',2);

c1 = normxcorr2( temp, im1 );
[yp1,xp1] = find(c1==max(c1(:)));
yoff1 = yp1-size(temp,1);
xoff1 = xp1-size(temp,2);
figure, imshow(im1)
rectangle('Position', [xoff, yoff, size(temp,2),size(temp,1)],'EdgeColor','r','Linewidth',2);
%%
% In compare function, we can see that we are muliplying in the time
% domain. Instead we can also use convolution in frequnecy domain (since
% multiplication in time domain is equivalent to convolution in frequnecy
% domain and vice versa.
% Convolution of two matrices takes less time compared to multiplication.
% Hence time taken will be less if we do the comparision using convolution
% in frequency domain.