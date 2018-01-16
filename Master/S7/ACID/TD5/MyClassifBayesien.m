function [ res ] = MyClassyfBayesien(test,mu1, cov1, mu2, cov2, mcost, size1, size2)
%MYCLASSYFBAYESIEN Summary of this function goes here
% 1 si échantillon classifié comme bar, 0 si échantillon classifié comme saumon


probtest1 = mvnpdf(test,mu1,cov1) * size1;
probtest2 = mvnpdf(test,mu2,cov2) * size2;

% diff1 = mcost(1,2) - mcost(2,2);
% diff2 = mcost(2,1) - mcost(1,1);

% diff = diff1 / diff2;

res = probtest1 * (mcost(1,1) - mcost(2,1)) < probtest2 * (mcost(2,2) - mcost(1,2)); 

end

