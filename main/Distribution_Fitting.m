%% Distributional fitting to verify model validity

%% 
close all;
filepath = 'C:\Users\11642\Desktop\Built-up-Area-Extraction_based_on_Sentinel1-main\data\Aug\C2';
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

%% get z
[supZ1,supZ2,supZ3,supZ4] = get_supZ(RGBimg1,12000,rows,cols,Z1,Z2,Z3,Z4);

%% L、C estimation
[avlogdetz,detsupsigma] = Estimation(supZ1,supZ2,supZ3,supZ4); 
logdetsupsigma = log10(detsupsigma); 
L=1:0.001:15;
fL=2*log10(L) - psi(0,L)/log(10) - psi(0,L-1)/log(10) + avlogdetz - logdetsupsigma; 
y1 = zeros(1,numel(L));
figure;plot(L,y1,'r--',L,fL,'b-','linewidth',1.5);
n = 12.622;
[finalvecsupz1,supfz1] = get_fz(supZ1,n);% n is read from pic above
