function [idx, idy] = compare(im,template)

[x1, y1] = size(im);
[x2, y2] = size(template);
minsum = 1000000000;
for i = 1 : x1-x2
    for j = 1 : y1-y2
        block = im(i:i+x2-1,j:j+y2-1);
        dif = imabsdiff(template,block);
        minsumdiff = (sum(dif(:)));
        if minsumdiff < minsum
            minsum = minsumdiff;
            idx = i;
            idy = j;
        end
    end
end

end