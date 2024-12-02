function [finalvecsupz1,supfz1] = get_fz(supZ1,n)
finalvecsupz1 = unique(supZ1(:),'rows','sorted'); 
[numfinalvecsupz1,~] = size(finalvecsupz1); 
supsigma1 = sum(sum(finalvecsupz1))/numfinalvecsupz1;
supup1 = (n^n).*(finalvecsupz1.^(n-1)); 
supdown1 = gamma(n)*(supsigma1^n); 
supright1 = exp(-n/supsigma1.*finalvecsupz1); 
supfz1 = supup1.*supright1./supdown1; 
figure;histogram(supZ1,1200,'Normalization','pdf');set(gca,'XLim',[0,0.3]);hold on
plot(finalvecsupz1,supfz1,'LineWidth',2); 
end

