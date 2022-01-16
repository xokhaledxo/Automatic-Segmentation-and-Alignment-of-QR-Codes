function main()
clear, close all,  clc;
I = imread('6.1.bmp');
res = LocalThersolding(I);
bw = imbinarize(res);
[Centroid, bw2, flag] = detectFinder(bw);
markers = Centroid(logical(flag),:);
%figure,imshow(bw2), title('level 1');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%% Level 2 %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[idxC, idxX, idxY] = finderPos(markers);
[I, bw2, ~] = RotateTheBigShape(I, bw2, idxC, idxX, idxY, markers);
%figure, imshow(I), title('level 2');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%% Level 3 %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[cropped] = CropTheShape(I, bw2);
figure,imshow(cropped),  title('THE FINAL RESULT');
end