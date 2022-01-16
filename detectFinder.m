function [Centroid, bw2, flag] = detectFinder(img)
bwo = ~img;
bw = imclearborder(bwo);
%figure,imshow(bw), title('level 1');

bw2 = imopen(bw, ones(5));
bw2 = imclose(bw2, ones(25));
%figure,imshow(bw2), title('level 1');

%bw = imclose(bw, ones(3)); %%%%%%%%%%%%%%%%%%%%
%bwo = imclose(bwo, ones(3)); %%%%%%%%%%%%%%%%%%%%2

bw = bwpropfilt(bw, 'EulerNumber', [0, 0]);
%figure,imshow(bw), title('level 1');

bwa = imfill(bw, 'holes');
%figure,imshow(bwa), title('level 1');

stats = regionprops(bwa, 'Centroid');
Centroid = cat(1, stats.Centroid);
sz = size(Centroid,1);
flag = zeros(sz(1),1);
bwl = bwlabel(bwa);
bw2 = bw;
for i = 1:sz(1)
    roi = bwl == i;
    area = bwo;
    area(~roi) = 0;
    xy = round(Centroid(i,:));
    x = area(:, xy(1));

    pw = pulsewidth(double(x));
    ps = pulsesep(double(x));
    
    flagout = ~(size(ps, 1) == 2 && size(pw, 1) == 3);
    if flagout == 1
        bw2(bwl == i) = 0;
    else
        width = sum([pw;ps]) / 7;
        pat = [pw(1), ps(2), pw(2), ps(2), pw(3)] / width;
        if pdist2(pat, [1 1 3 1 1]) < 0.9
            flag(i) = 1;
        else
            bw2(bwl == i) = 0;
        end
    end
end