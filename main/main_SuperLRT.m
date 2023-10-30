
%% main_SuperLRT

close all;
filepath = 'E:\data1\data1Aug\C2';
filepath1 = 'E:\data1\data1Dec\C2';
sigma0 = 0.1;
sigma1 = 10;
ymax=255;
ymin=0;
RGBimg1 = imread(fullfile(filepath1,'RGB1.bmp'));
[rows,cols,~] = size(RGBimg1);
disp('Start to Read The Matlab Format C2 !');

%% Read C11-C22

fileID = fopen(fullfile(filepath,'C11.bin'));     data(:,:,1) = fread(fileID, [cols,rows], 'float32').';fclose(fileID);
fileID = fopen(fullfile(filepath,'C12_real.bin'));data(:,:,2) = fread(fileID, [cols,rows], 'float32').';fclose(fileID);
fileID = fopen(fullfile(filepath,'C12_imag.bin'));data(:,:,3) = fread(fileID, [cols,rows], 'float32').';fclose(fileID);
fileID = fopen(fullfile(filepath,'C22.bin'));     data(:,:,4) = fread(fileID, [cols,rows], 'float32').';fclose(fileID);

fileID = fopen(fullfile(filepath1,'C11.bin'));     data(:,:,5) = fread(fileID, [cols,rows], 'float32').';fclose(fileID);
fileID = fopen(fullfile(filepath1,'C12_real.bin'));data(:,:,6) = fread(fileID, [cols,rows], 'float32').';fclose(fileID);
fileID = fopen(fullfile(filepath1,'C12_imag.bin'));data(:,:,7) = fread(fileID, [cols,rows], 'float32').';fclose(fileID);
fileID = fopen(fullfile(filepath1,'C22.bin'));     data(:,:,8) = fread(fileID, [cols,rows], 'float32').';fclose(fileID);

%% C2

C11 = data(:,:,1);                       supC11 = zeros(rows,cols);
C12 = complex(data(:,:,2), data(:,:,3)); supC12 = zeros(rows,cols);
C21 = conj(C12);                         supC21 = zeros(rows,cols);
C22 = data(:,:,4);                       supC22 = zeros(rows,cols);


C111 = data(:,:,5);                       sup1C11 = zeros(rows,cols);
C112 = complex(data(:,:,6), data(:,:,7)); sup1C12 = zeros(rows,cols);
C121 = conj(C112);                        sup1C21 = zeros(rows,cols);
C122 = data(:,:,8);                       sup1C22 = zeros(rows,cols);
clear data
disp('The Matlab Format C2 is Read !');

%% superpixel segmentation
numsupPixel = 4000;
[label,num] = superpixels(RGBimg1,numsupPixel,'compactness',20);
BW = boundarymask(label);
STATS = regionprops(label, 'all');

%% NL
supsize = zeros(num,1);
N = zeros(rows,cols);pn = zeros(rows,cols);
for t = 1:num
    supsize(t,1) = STATS(t).Area;   
end
suptable = tabulate(supsize); 

%% SuperPixel Averaging
for i=1:num  
    i
    pixel_num = STATS(i).Area;  
    %pixel_xy = STATS(i).PixelList;  
    pixelind = STATS(i).PixelIdxList;   
    sumC11 = 0; sumC12 = 0; sumC21 = 0; sumC22 = 0; 
    sum1C11 = 0; sum1C12 = 0; sum1C21 = 0; sum1C22 = 0;
    for j = 1:pixel_num   
        sumC11 = sumC11 + C11(pixelind(j));
        sumC12 = sumC12 + C12(pixelind(j));
        sumC21 = sumC21 + C21(pixelind(j));
        sumC22 = sumC22 + C22(pixelind(j));
        
        sum1C11 = sum1C11 + C111(pixelind(j));
        sum1C12 = sum1C12 + C112(pixelind(j));
        sum1C21 = sum1C21 + C121(pixelind(j));
        sum1C22 = sum1C22 + C122(pixelind(j));
    end

   
    meanC11 = sumC11/pixel_num; meanC12 = sumC12/pixel_num; meanC21 = sumC21/pixel_num; meanC22 = sumC22/pixel_num;
    supC11(pixelind) = meanC11; supC12(pixelind) = meanC12; supC21(pixelind) = meanC21; supC22(pixelind) = meanC22;
   
    mean1C11 = sum1C11/pixel_num; mean1C12 = sum1C12/pixel_num; mean1C21 = sum1C21/pixel_num; mean1C22 = sum1C22/pixel_num;
    sup1C11(pixelind) = mean1C11; sup1C12(pixelind) = mean1C12; sup1C21(pixelind) = mean1C21; sup1C22(pixelind) = mean1C22;
    [x,~] = find(suptable(:,1)==pixel_num);
    pn(pixelind) = suptable(x,3)/100;  
    N(pixelind) = pixel_num;  
end


%% lnQ

supZC11 = supC11+sup1C11;
supZC12 = supC12+sup1C12;
supZC21 = supC21+sup1C21;
supZC22 = supC22+sup1C22;

supXdet = supC11.* supC22 -  supC12.* supC21;
supYdet = sup1C11.* sup1C22 -  sup1C12.* sup1C21;
supZdet = supZC11.* supZC22 -  supZC12.* supZC21;

suplnQ = 4*log(2) + log(abs(supXdet)) + log(abs(supYdet)) - 2*log(abs(supZdet));
supsim = -sigma0*suplnQ.*N;

xmax = max(max(supsim)); 
xmin = min(min(supsim));
supsimNorm = round((ymax-ymin)*(supsim-xmin)/(xmax-xmin) + ymin); 

supsal = exp(-supsimNorm./sigma1);
xmax = max(max(supsal)); 
xmin = min(min(supsal));
supsalNorm = round((ymax-ymin)*(supsal-xmin)/(xmax-xmin) + ymin); 


