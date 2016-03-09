%%
% $$ {x[m,n]} \rightarrow {x[m,N-n]}$$
% 
% $$ {F(u,v)}=\frac{1}{MN}\sum_{x=1}^{M}\sum_{y=1}^{N}{x[m,n]}
%   e^{-2j\pi(\frac{xu}{M} + \frac{yv}{N})}$$
%
% $$ {N-y} \rightarrow {q} \Rightarrow {y} \rightarrow {N-q}$$
%
% $$ {F(u,-v)e^{2j\pi(v)}}={\frac{1}{MN}\sum_{x=1}^{M}\sum_{y=1}^{N}{x[p,q]}
%   e^{-2j\pi(\frac{xu}{M} + \frac{(N-q)v}{N}) }}$$
%
% $$ {F(u,v)} \rightarrow {F(u,-v)e^{2j\pi(v)}} $$
%%
clc;
clear all;
close all;
%%
input = imread('rupee-symbol.jpg');
input = rgb2gray(input);
% input = double(input);
infft = fftshift(fft2(input));
[x y]=size(input);
%%
for i = 1 : x
    for j = 1 : y/2
        temp = input(i,j);
        G(i,j) = input(i, y - j);
        G(i,y - j) = temp;
        tempfft = infft(i,j);
        Gfft(i,j) = infft(i, y - j);
        Gfft(i,y - j) = tempfft;
    end
end

Gref_fft = fftshift(fft2(G));
GG = ifft2(ifftshift(Gfft));

%%
% G is the reflected image.
% Gfft is the reflected fourier tranform of original image.
% Gref_fft is the fourier transform of the reflected image.
% GG is the inverse fourier transform of the reflected fourier transform(of
% original image).
%%
figure,
subplot(121), imshow(input)
title('Original image');
subplot(122), imshow(uint8(abs(infft)))
title('Fourier Transform of original image');
figure,
subplot(121), imshow(G)
title('Reflected image');
subplot(122), imshow(uint8(abs(Gref_fft)))
title('Fourier transform of reflected image');
figure,
subplot(121), imshow(uint8(abs(GG)))
title({'Inverse fourier transform of the reflected','Fourier Transform of original image'});
subplot(122), imshow(uint8(abs(Gfft)))
title({'Reflection done on Fourier',' Transform of original image'});