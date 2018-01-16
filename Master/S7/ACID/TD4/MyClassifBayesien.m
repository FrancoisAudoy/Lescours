function [ res ] = MyClassifBayesien(test,mu1, cov1, mu2, cov2, mcost, size1, size2)
%MYCLASSYFBAYESIEN Summary of this function goes here
% 1 si échantillon classifié comme bar, 0 si échantillon classifié comme saumon

probtestBar = mvnpdf(test,mu1,cov1) * size1;
probtestSaumon = mvnpdf(test,mu2,cov2) * size2;
res = probtestBar * (mcost(1,1) - mcost(2,1)) < probtestSaumon * (mcost(2,2) - mcost(1,2)); 

end

