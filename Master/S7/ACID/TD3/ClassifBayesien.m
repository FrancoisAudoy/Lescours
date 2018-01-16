function res = ClassifBayesien(test, mu1, sig1, mu2, sig2, mcost, size1, size2)

probtest = normpdf(test,mu1,sig1) ./ normpdf(test,mu2,sig2);

diff1 = mcost(1,2) - mcost(2,2);
diff2 = mcost(2,1) - mcost(1,1);

diff = diff1 / diff2;

res = (probtest > (diff * ((size2/(size1+size2)) / (size1/(size1+size2)))));

end

