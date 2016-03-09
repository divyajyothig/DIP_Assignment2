%%
% $$ {x[m,n]} \rightarrow a{x[m,n]}$$
% 
% $$ {F(u,v)}=\frac{1}{MN}\sum_{x=1}^{M}\sum_{y=1}^{N}{x[m,n]}
%   e^{-2j\pi\frac{xu}{M} + \frac{yv}{N} }$$
%
% $$ a{F(u,v)}=a{\frac{1}{MN}\sum_{x=1}^{M}\sum_{y=1}^{N}{x[m,n]}
%   e^{-2j\pi\frac{xu}{M} + \frac{yv}{N} }}$$
%
% $$ {F(u,v)} \rightarrow a{F(u,v)} $$
%%
clc;
clear all;
close all;
%%
x = imread('rupee-symbol.jpg');
x = rgb2gray(x);
x = double(x);
xfft = fftshift(fft2(x));
%%
% Scaling in time domain and taking the fourier transform of the scaled
% image. 
% Scaling factor = 3.
%%
x_scale = 3 .* x;
xfft_scale = fftshift(fft2(x_scale));
%%
% Scaling in frequency domain.
x_scalefft = 3 .* xfft;
%%
figure, imshow(uint8(abs(xfft)))
title('Fourier transform of original image');
figure, imshow(uint8(abs(xfft_scale)))
title('Fourier transform of scaled image');
figure, imshow(uint8(abs(x_scalefft)))
title('Scaled Fourier transform');
%%
% Difference in the fourier transform of scaled image and scaled fourier
% transform
% As the scaling factor is increased,
%%
dif = sum(sum(uint8(abs(xfft_scale)) - uint8(abs(x_scalefft))))