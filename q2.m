clc;
clear all;
close all;
%%
% Orientation of images.
%%
A = double(imread('son3.gif'));
B1 = double(imread('son3rot1.gif'));
B2 = double(imread('son3rot2.gif'));
B3 = double(imread('son3rot3.gif'));
B2 = imcomplement(B2);
B3 = imcomplement(B3);
%%
% Checking for angles which are multiples of 45
% Rotating the image and checking the similarity between the rotated image
% and the given image(A) using normalized cross correlation and finding the
% angle
%%
maxc1 = 0;
maxc2 = 0;
maxc3 = 0;
j = 1;
for i = 45 : 45 : 360
    Y = imrotate(A,i,'crop');
    c1 = normxcorr2(Y,B1);
    c2 = normxcorr2(Y,B2);
    c3 = normxcorr2(Y,B3);
    c1 = max(c1(:));
    c2 = max(c2(:));
    c3 = max(c3(:));
    if maxc1 < c1
        maxc1 = c1;
        ang1 = i;
    end
    if maxc2 < c2
        maxc2 = c2;
        ang2 = i;
    end
    if maxc3 < c3
        maxc3 = c3;
        ang3 = i;
    end
end

figure, imshow(B1);
title('Rotation = 315 degrees');
display(ang1);
figure, imshow(B2);
title('Rotation = 90 degrees');
display(ang2);
figure, imshow(B3);
title('Rotation = 45 degrees');
display(ang3);