function res = Myclassify(test, mu1, sig1, mu2,sig2, size1, size2)
    tmpbar = mvnpdf(test,mu1,sig1)*(size1/(size1 + size2));
    tmpsaum = mvnpdf(test,mu2,sig2)*(size2/(size1 + size2));

    res = tmpbar > tmpsaum;
end

