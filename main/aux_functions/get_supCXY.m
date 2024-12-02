function [N,supC11,sup1C11,supC12,sup1C12,supC21,sup1C21,supC22,sup1C22] = get_supCXY(num,STATS,suptable,rows,cols,C11,C12,C21,C22,C111,C112,C121,C122)
supC11 = zeros(rows,cols);supC12 = zeros(rows,cols);supC21 = zeros(rows,cols);supC22 = zeros(rows,cols);
sup1C11 = zeros(rows,cols);sup1C12 = zeros(rows,cols);sup1C21 = zeros(rows,cols);sup1C22 = zeros(rows,cols);
N = zeros(rows,cols);pn = zeros(rows,cols);
for i=1:num  
    pixel_num = STATS(i).Area;   
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

end

