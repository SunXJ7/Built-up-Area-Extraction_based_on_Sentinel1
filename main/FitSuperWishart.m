%% Distributional fitting to verify model validity

%% 
close all;
filepath = 'F:\data1\data1Dec\C2';
RGBimg1 = imread(fullfile(filepath,'RGB1.bmp'));
[rows,cols,~] = size(RGBimg1);
disp('Start to Read The Matlab Format C2 !');

%% Read C
fileID = fopen(fullfile(filepath,'C11.bin'));     data(:,:,1) = fread(fileID, [cols,rows], 'float32').';fclose(fileID);
fileID = fopen(fullfile(filepath,'C12_real.bin'));data(:,:,2) = fread(fileID, [cols,rows], 'float32').';fclose(fileID);
fileID = fopen(fullfile(filepath,'C12_imag.bin'));data(:,:,3) = fread(fileID, [cols,rows], 'float32').';fclose(fileID);
fileID = fopen(fullfile(filepath,'C22.bin'));     data(:,:,4) = fread(fileID, [cols,rows], 'float32').';fclose(fileID);
disp('The Matlab Format C2 is Read !');

Z1 = data(:,:,1);
Z2 = data(:,:,2);
Z3 = data(:,:,3);
Z4 = data(:,:,4);
clear data

%% superpixel segmentation
supZ1 = zeros(rows,cols);supZ2 = zeros(rows,cols);supZ3 = zeros(rows,cols);supZ4 = zeros(rows,cols);
pn = zeros(rows,cols);
numsupPixel = 4000;
[label,num] = superpixels(RGBimg1,numsupPixel);
BW = boundarymask(label);
STATS = regionprops(label, 'all');
supsize = zeros(num,1);
N = zeros(rows,cols);

for t = 1:num
    supsize(t,1) = STATS(t).Area;   
end
suptable = tabulate(supsize); 
PNmax = max(max(suptable(:,2))); 
[PNmax_N,~]=find(suptable(:,2)==PNmax); 

for i=1:num
    i
    pixel_num = STATS(i).Area;  
    pixelind = STATS(i).PixelIdxList;   
    sumZ1 = 0; sumZ2 = 0; sumZ3 = 0; sumZ4 = 0; 
    for j = 1:pixel_num
        sumZ1 = sumZ1 + Z1(pixelind(j));
        sumZ2 = sumZ2 + abs(Z2(pixelind(j)));
        sumZ3 = sumZ3 + abs(Z3(pixelind(j)));
        sumZ4 = sumZ4 + Z4(pixelind(j));
    end 
    meanZ1 = sumZ1/pixel_num;meanZ2 = sumZ2/pixel_num;meanZ3 = sumZ3/pixel_num;meanZ4 = sumZ4/pixel_num;  
    supZ1(pixelind) = meanZ1;supZ2(pixelind) = meanZ2;supZ3(pixelind) = meanZ3;supZ4(pixelind) = meanZ4; 

    [x,~] = find(suptable(:,1)==pixel_num);  
    pn(pixelind) = suptable(x,3);  
    N(pixelind) = pixel_num;  
end
Nidx=find(N==PNmax_N); 
[length,~] = size(Nidx); 

vecsamplez1 = zeros(length,1);vecsamplez2 = zeros(length,1);vecsamplez3 = zeros(length,1);vecsamplez4 = zeros(length,1);
for ii = 1:length
    vecsamplez1(ii,1) = Z1(Nidx(ii)); 
    vecsamplez2(ii,1) = abs(Z2(Nidx(ii)));
    vecsamplez3(ii,1) = abs(Z3(Nidx(ii)));
    vecsamplez4(ii,1) = Z4(Nidx(ii));
end

%% fitting

%%%%%%%%%%L¡¢C estimation
supZ(:,1) = supZ1(:);supZ(:,2) = supZ2(:);supZ(:,3) = supZ3(:);supZ(:,4) = supZ4(:);  
unisupZ = unique(supZ,'rows','stable');  
detZ = unisupZ(:,1).*unisupZ(:,4) - complex(unisupZ(:,2),unisupZ(:,3)).*conj(complex(unisupZ(:,2),unisupZ(:,3)));
logdetz = log10(detZ); 
[numlogdetz,~] = size(logdetz); 
avlogdetz = sum(sum(logdetz))/numlogdetz;  
supsigma = [sum(sum(unisupZ(:,1)))/numlogdetz,complex(sum(sum(unisupZ(:,2)))/numlogdetz,sum(sum(unisupZ(:,3)))/numlogdetz);
            conj(complex(sum(sum(unisupZ(:,2)))/numlogdetz,sum(sum(unisupZ(:,3)))/numlogdetz)),sum(sum(unisupZ(:,4)))/numlogdetz]; 
detsupsigma = det(supsigma);
logdetsupsigma = log10(detsupsigma); 
L=1:1:100;
fL=2*log10(L) - psi(0,L)/log(10) - psi(0,L-1)/log(10) + avlogdetz - logdetsupsigma; 
y1 = zeros(1,numel(L));
figure;plot(L,y1,'r--',L,fL,'b-','linewidth',1.5);
legend('y=0','f(L)');

%%%%%%%%%%

%%%%%%%%%%
n = 7.621;
finalvecsupz1 = unique(supZ1(:),'rows','sorted'); 
[numfinalvecsupz1,~] = size(finalvecsupz1); 
supsigma1 = sum(sum(finalvecsupz1))/numfinalvecsupz1; 
supup1 = (n^n).*(finalvecsupz1.^(n-1)); 
supdown1 = gamma(n)*(supsigma1^n);
supright1 = exp(-n/supsigma1.*finalvecsupz1); 
supfz1 = supup1.*supright1./supdown1; 
figure;histogram(supZ1,200,'Normalization','pdf');set(gca,'XLim',[0,0.3]);hold on
plot(finalvecsupz1,supfz1,'LineWidth',2); 
title(['N = ' num2str(PNmax_N) ', Estimate_L = ' num2str(n) ', Estimate_C = ' num2str(detsupsigma)]);

%%%%%%%%%%%
finalvecsupz2 = unique(abs(supZ2(:)),'rows','sorted'); 
[numfinalvecsupz2,~] = size(finalvecsupz2); 
supsigma2 = sum(sum(finalvecsupz2))/numfinalvecsupz2;
supup2 = (n^n).*(finalvecsupz2.^(n-1));
supdown2 = gamma(n)*(supsigma2^n); 
supright2 = exp((-n/supsigma2).*finalvecsupz2); 
supfz2 = supup2.*supright2./supdown2; 
figure;histogram(abs(supZ2(:)),200,'Normalization','pdf');set(gca,'XLim',[0,0.05]);hold on
plot(finalvecsupz2,supfz2,'LineWidth',2);
title(['N = ' num2str(PNmax_N) ', Estimate_L = ' num2str(n) ', Estimate_C = ' num2str(detsupsigma)]);

%%%%%%%%%%%
finalvecsupz3 = unique(abs(supZ3(:)),'rows','sorted'); 
[numfinalvecsupz3,~] = size(finalvecsupz3); 
supsigma3 = sum(sum(finalvecsupz3))/numfinalvecsupz3; 
supup3 = (n^n).*(finalvecsupz3.^(n-1)); 
supdown3 = gamma(n)*(supsigma3^n); 
supright3 = exp((-n/supsigma3).*finalvecsupz3); 
supfz3 = supup3.*supright3./supdown3; 
figure;histogram(abs(supZ3(:)),400,'Normalization','pdf');set(gca,'XLim',[0,0.05]);hold on
plot(finalvecsupz3,supfz3,'LineWidth',2);
title(['N = ' num2str(PNmax_N) ', Estimate_L = ' num2str(n) ', Estimate_C = ' num2str(detsupsigma)]);

%%%%%%%%%%%
finalvecsupz4 = unique(abs(supZ4(:)),'rows','sorted'); 
[numfinalvecsupz4,~] = size(finalvecsupz4); 
supsigma4 = sum(sum(finalvecsupz4))/numfinalvecsupz4; 
supup4 = (n^n).*(finalvecsupz4.^(n-1)); 
supdown4 = gamma(n)*(supsigma4^n);
supright4 = exp((-n/supsigma4).*finalvecsupz4);
supfz4 = supup4.*supright4./supdown4; 
figure;histogram(abs(supZ4(:)),150,'Normalization','pdf');set(gca,'XLim',[0,0.3]);hold on
plot(finalvecsupz4,supfz4,'LineWidth',2);
title(['N = ' num2str(PNmax_N) ', Estimate_L = ' num2str(n) ', Estimate_C = ' num2str(detsupsigma)]);

