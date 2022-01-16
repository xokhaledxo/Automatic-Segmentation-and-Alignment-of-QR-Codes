function [] = correctProspective(idxC, idxX, idxY, markers, I)
Y = [markers(idxY,:); markers(idxC,:)];
X = [markers(idxX,:); markers(idxC,:)];
H = pdist(Y,'euclidean');
W = pdist(X,'euclidean');

fixedPoints = [0 0;80 0;80 80;0 80];
pts = [markers(idxX,1), markers(idxY,2)];

movingPoints = [markers(idxC,:); markers(idxX,:); pts; markers(idxY,:)];

tform = fitgeotrans(movingPoints,fixedPoints,'projective');
B = imwarp(I,tform.T);
figure,imshow(B), title('Corrected Image');

end