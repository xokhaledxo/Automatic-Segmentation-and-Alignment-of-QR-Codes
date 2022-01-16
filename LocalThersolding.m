function [I] = LocalThersolding(I)
[H, W, L]=size(I);

Temp = sort((I(:)));

MIN = sum(Temp(1:15))/15;

I=rgb2gray(I);

I = medfilt2(I, [3 3]);

I=I-MIN;Sampel=20;
for i = 1 : (H/Sampel)
    for j = 1 : (W/Sampel)
        
        i1=i*Sampel;
        j1=j*Sampel;
        
        x=I(i1-Sampel+1:i1,j1-Sampel+1:j1);
        
        min_=min(x(:));
        
        x=sort(x(:));
        
        c=Sampel*Sampel;
        
        range = sum(x(c-14:c))/15 - sum(x(1:15))/15;
        
        Threshold=min_+range/1.5;
        
        if range>50
            
            Z=I(i1-Sampel+1:i1,j1-Sampel+1:j1)>Threshold;
            
            I(i1-Sampel+1:i1,j1-Sampel+1:j1)=Z*255;
            
        end
        
    end
    
end
imshow(I);
end