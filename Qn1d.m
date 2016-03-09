clc;
clear all;
close all;
%%
% Using Integral images
%%
imo = imread('vegan-modified.jpg'); 
im = imresize(imo, 0.5, 'bilinear');
templateo = imread('soy-dessert.jpg');
template = double(imresize(templateo, 0.5, 'bilinear'));
[x1, y1] = size(im);
[x2, y2] = size(template);

%%
% Cumulative sum across all rows and then across all columns is calaulated
% which is a matrix.
% The last element in the above matrix will be the sum of all the pixels in the block.
%%
maxncc = 0;
tic
t_m = cumsum(cumsum(template),2);
t_mean = t_m(x2,y2)/numel(template);
t_s = (template - t_mean).^2;
t_s1 = cumsum(cumsum(t_s),2);
t_std = sqrt(t_s1(x2,y2)/numel(template));
for i = 1 : x1-x2
    for j = 1 : y1-y2
        block = double(im(i:i+x2-1,j:j+y2-1));
        b_m = cumsum(cumsum(block),2);
        b_mean = b_m(x2,y2)/numel(block);
        b_s = (block - b_mean).^2;
        b_s1 = cumsum(cumsum(b_s),2);
        b_std = sqrt(b_s1(x2,y2)/numel(block));
        ncc = (1/numel(template)) * (((sum(sum((block - b_mean).*(template - t_mean)))) / ((b_std)*(t_std))));
        if  ncc > maxncc
            maxncc = ncc;
            idx = i;
            idy = j;
        end
    end
end
toc
%%
% 
% Marking a rectangle in both the original image and the resized image
%%
figure, imshow(im)
rectangle('Position',[idy,idx,y2,x2],'EdgeColor','r','EdgeColor','r','Linewidth',2)
figure, imshow(imo)
rectangle('Position',[2*idy,2*idx,2*y2,2*x2],'EdgeColor','r','Linewidth',2)