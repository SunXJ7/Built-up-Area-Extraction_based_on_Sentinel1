function [avlogdetz,detsupsigma] = Estimation(supZ1,supZ2,supZ3,supZ4)
supZ(:,1) = supZ1(:);supZ(:,2) = supZ2(:);supZ(:,3) = supZ3(:);supZ(:,4) = supZ4(:);
unisupZ = unique(supZ,'rows','stable');  
detZ = unisupZ(:,1).*unisupZ(:,4) - complex(unisupZ(:,2),unisupZ(:,3)).*conj(complex(unisupZ(:,2),unisupZ(:,3)));
logdetz = log10(detZ); 
[numlogdetz,~] = size(logdetz); 
avlogdetz = sum(sum(logdetz))/numlogdetz;  
supsigma = [sum(sum(unisupZ(:,1)))/numlogdetz,complex(sum(sum(unisupZ(:,2)))/numlogdetz,sum(sum(unisupZ(:,3)))/numlogdetz);
            conj(complex(sum(sum(unisupZ(:,2)))/numlogdetz,sum(sum(unisupZ(:,3)))/numlogdetz)),sum(sum(unisupZ(:,4)))/numlogdetz];   
detsupsigma = det(supsigma); 
end

