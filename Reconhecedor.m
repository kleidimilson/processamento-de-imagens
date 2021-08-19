% Ler a imagem original

I = imread('albino.jpg');



out=  uint8(zeros(size(I,1),size(I,2),size(I,3)));

%R,G,B pegando componentes da imagem
R = I(:,:,1);
G = I(:,:,2);
B = I(:,:,3);

% obtenho o inverso dos valores médios do RGB
mR = 1/(mean(mean(R)));
mG = 1/(mean(mean(G)));
mB = 1/(mean(mean(B)));

% menor valor médio
maxRGB = max(max(mR, mG), mB);

% calculo os fatores de escala
mR = mR/maxRGB;
mG = mG/maxRGB;
mB = mB/maxRGB;

% escalar os valores
out(:,:,1)=R*mR;
out(:,:,2)=G*mG;
out(:,:,3)=B*mB;

% converto a imagem RGB para YCbCr
img_ycbcr=rgb2ycbcr(out);



% tirando os components da imagem

y = img_ycbcr(:,:,1);



Cb = img_ycbcr(:,:,2);



Cr = img_ycbcr(:,:,3);




[r,c,v] = find(Cb>=77 & Cb<=127 & Cr>=133 & Cr<=193);
numind=size(r,1);

bin=false(size(I,1),size(I,2));

% marcar pixels de pele

for i=1:numind
    bin(r(i),c(i))=1;
end




bin = imfill(bin,'holes');

bin=bwareaopen(bin,1000);




R(~bin)=0;
G(~bin)=0;
B(~bin)=0;

out=cat(3,R,G,B);

figure,imshow(out);

