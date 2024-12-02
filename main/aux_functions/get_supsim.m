function [supsalNorm] = get_supsim(N,supC11,sup1C11,supC12,sup1C12,supC21,sup1C21,supC22,sup1C22,sigma0,sigma1)

supZC11 = supC11+sup1C11;
supZC12 = supC12+sup1C12;
supZC21 = supC21+sup1C21;
supZC22 = supC22+sup1C22;

supXdet = supC11.* supC22 -  supC12.* supC21;
supYdet = sup1C11.* sup1C22 -  sup1C12.* sup1C21;
supZdet = supZC11.* supZC22 -  supZC12.* supZC21;

suplnQ = 4*log(2) + log(abs(supXdet)) + log(abs(supYdet)) - 2*log(abs(supZdet));

supsim = -suplnQ.*N.*sigma0;
supsal = exp(-supsim./sigma1);
ymax=255;ymin=0;
xmax = max(max(supsal)); 
xmin = min(min(supsal));
supsalNorm = round((ymax-ymin)*(supsal-xmin)/(xmax-xmin) + ymin); 
end

