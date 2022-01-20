% CS194-26 (cs219-26): Project 1, starter Matlab code

% name of the input file
    imname = 'data/00125v_22222.jpg';

% read in the image
fullim = imread(imname);

% convert to double matrix (might want to do this later on to same memory)
fullim = im2double(fullim);

% compute the height of each part (just 1/3 of total)
height = floor(size(fullim,1)/3);
% separate color channels
B = fullim(1:height,:);
G = fullim(height+1:height*2,:);
% G =[B(4:end,:);B(1:3,:)];
% R =[B(:,1:4),B(:,1:end-4)];
R = fullim(height*2+1:height*3,:);

% Align the images
% Functions that might be useful to you for aligning the images include: 
% "circshift", "sum", and "imresize" (for multiscale)
[aR,rowinx1,colinx1] = align(R,B);
[aG,rowinx2,colinx2] = align(G,B);
rowinx = intersect(rowinx1,rowinx2);
colinx = intersect(colinx1,colinx2);
colorIm = cat(3,aR,aG,B);
colorIm = colorIm(rowinx,colinx,:);
% open figure
 figure();
 imshow(colorIm,[]);title('align using RGB');
%%bells
%%Automatic contrasting
R = colorIm(:,:,1);
G = colorIm(:,:,2);
B = colorIm(:,:,3);
aR = auto_con(R);
aG = auto_con(G);
aB = auto_con(B);
colorImCd = cat(3,aR,aG,aB);
 figure();
 imshow(colorImCd,[]);title('Automatic contrasting');
%%automatic croping
colorImCd_cut = findborder(colorImCd);
figure;imshow(colorImCd_cut);title('automatic croping');
[aR] = align_using_gradient(R,B);
[aG] = align_using_gradient(G,B);
colorIm2 = cat(3,aR,aG,B);
colorIm2_cut = findborder(colorIm2);
 figure();
 imshow(colorIm2_cut,[]);title('align using gradient');
% imwrite(colorIm,['result-' imname]);

