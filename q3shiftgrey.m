%%
% $$ {x[m,n]} \rightarrow {x[m+X,n+Y]}$$
% 
% $$ {F(u,v)}=\frac{1}{MN}\sum_{x=1}^{M}\sum_{y=1}^{N}{x[m,n]}
%   e^{-2j\pi(\frac{xu}{M} + \frac{yv}{N})}$$
%
% $$ {x+X} \rightarrow {p} \Rightarrow {x} \rightarrow {p-X}$$
%
% $$ {y+Y} \rightarrow {q} \Rightarrow {y} \rightarrow {q-Y}$$
%
% $$ {F(u,v)e^{2j\pi(\frac{Xu}{M}+\frac{Yv}{N}})}={\frac{1}{MN}\sum_{x=1}^{M}\sum_{y=1}^{N}{x[p,q]}
%   e^{-2j\pi(\frac{(p-X)u}{M} + \frac{(q-Y)v}{Na}) }}$$
% 
% $$ {F(u,v)} \rightarrow {F(u,v)e^{2j\pi(\frac{Xu}{M}+\frac{Yv}{N}})} $$
%%
clc;
clear all;
close all;
%%
input = imread('rupee-symbol.jpg');
input = rgb2gray(input);
infft = fftshift(fft2(input));
%%
% Shifting to x0 = -500,y0=-500
%%
x0=-500; 
y0=-500;
[xF,yF] = meshgrid(-size(input,2)/2:size(input,2)/2-1,-size(input,1)/2:size(input,1)/2-1);

H = infft.*exp(-i*2*pi.*((xF*x0./size(input,1))+(yF*y0./size(input,2))));
IF_image=ifft2(ifftshift(H));
%%
% Shifting done in time domain and the finding the fourier transform of the
% result. Aliasing occurs during the shifting in frequnecy domain(since
% when we convert from time domain to frequency domain, replicas occur)
%%
input_shift = padarray(input, [size(input,1),size(input,2)]);
for i = 1:size(input,1)
    for j = 1:size(input,2)
        final(i,j) = input_shift(i - x0, j - y0);
    end
end
final_fft = fftshift(fft2(final));
%%
figure;
subplot(1,2,1), imshow(input);
title('Original image');
subplot(1,2,2), imshow(angle(infft));
title('Fourier transform of original image');

figure;
subplot(1,2,1),imshow(IF_image);
title({'Shifting done in frequency domain' ,'and converting back to time domain'});
subplot(1,2,2), imshow(angle(H));
title('Shifting done in frequency domain');

figure, 
subplot(1,2,1);imshow(final);
title('Shifting done in time domain');
subplot(1,2,2), imshow(angle(final_fft));
title({'Fourier transform of the image where','shifting is done in time domain'});