function [num,STATS,suptable] = get_suppixel_table(RGBimg1,supnum)
[label,num] = superpixels(RGBimg1,supnum,'compactness',20);
BW = boundarymask(label);
figure;imshow(imoverlay(RGBimg1,BW));
STATS = regionprops(label, 'all');
%% 加入NL
supsize = zeros(num,1);
for t = 1:num
    supsize(t,1) = STATS(t).Area;   
end
suptable = tabulate(supsize); 
end

