function [supZ1,supZ2,supZ3,supZ4] = get_supZ(RGBimg1,supnum,rows,cols,Z1,Z2,Z3,Z4)
supZ1 = zeros(rows,cols);supZ2 = zeros(rows,cols);supZ3 = zeros(rows,cols);supZ4 = zeros(rows,cols);
[label,num] = superpixels(RGBimg1,supnum);
BW = boundarymask(label);
figure;imshow(imoverlay(RGBimg1,BW));
STATS = regionprops(label, 'all');
supsize = zeros(num,1);
for t = 1:num
    supsize(t,1) = STATS(t).Area;   
end
suptable = tabulate(supsize); 
PNmax = max(max(suptable(:,2))); 
[~,~]=find(suptable(:,2)==PNmax);  
for i=1:num
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
end
end

