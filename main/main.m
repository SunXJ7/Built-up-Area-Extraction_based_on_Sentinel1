
%% main_SuperLRT

close all;
filepath = 'C:\Users\11642\Desktop\data4\Aug_SUB\C2';
filepath1 = 'C:\Users\11642\Desktop\data4\Dec_SUB\C2';
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

C11 = data(:,:,1);                       
C12 = complex(data(:,:,2), data(:,:,3)); 
C21 = conj(C12);                         
C22 = data(:,:,4);                       


C111 = data(:,:,5);                       
C112 = complex(data(:,:,6), data(:,:,7)); 
C121 = conj(C112);                        
C122 = data(:,:,8);                       
clear data
disp('The Matlab Format C2 is Read !');

%% get_suppixel_table
[num,STATS,suptable] = get_suppixel_table(RGBimg1,15000);
%% SuperPixel Averaging
[N,supC11,sup1C11,supC12,sup1C12,supC21,sup1C21,supC22,sup1C22] = get_supCXY(num,STATS,suptable,rows,cols,C11,C12,C21,C22,C111,C112,C121,C122);%N is pixelnum of superpixel which the pixel belongs
%% lnQ
sigma0 = 0.1;
sigma1 = 7;
[supsalNorm] = get_supsim(N,supC11,sup1C11,supC12,sup1C12,supC21,sup1C21,supC22,sup1C22,sigma0,sigma1);



