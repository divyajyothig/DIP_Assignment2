%%
% $$ {x[m,n]} \rightarrow {x[am,bn]}$$
%
% $$ {F(u,v)}=\frac{1}{MN}\sum_{x=1}^{M}\sum_{y=1}^{N}{x[m,n]}
%   e^{-2j\pi(\frac{xu}{M} + \frac{yv}{N})}$$
%
% $$ {ax} \rightarrow {p} \Rightarrow {x} \rightarrow {\frac{p}{a}}$$
%
% $$ {by} \rightarrow {q} \Rightarrow {y} \rightarrow {\frac{q}{b}}$$
%
% $$ {F(u,v)} \rightarrow \frac{1}{|ab|}{F(\frac{1}{a}u,\frac{1}{b}v)}$$
%%
clc;
clear all;
close all;
%%
% Scaling the argument with a = 2.
%% 
input = imread('rupee-symbol.jpg');
input = rgb2gray(input);
infft = fftshift(fft2(input));
a = 2; b = 2;

inre = imresize(input,a,'bilinear');
inre_fft = fftshift(fft2(inre));

inrefft = imresize(infft,1/a,'bilinear');
inrefft = (1/abs(a*b)) .* inrefft;
%%
figure,
subplot(121),imshow(input)
title('Original image');
subplot(122),imshow(uint8(abs(infft)))
title('Fourier Transform of original image')
figure,
subplot(121),imshow(inre)
title('Scaling the argument in time domain');
subplot(122),imshow(uint8(abs(inre_fft)))
title('Fourier transform of resized image');
figure, imshow(uint8(abs(inrefft)))
title('Scaling the argument in Frequency domain');