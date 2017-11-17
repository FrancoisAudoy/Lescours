function res = MyClassify(test, mu1, cov1, mu2,cov2, size1, size2)
    tmpbar = mvnpdf(test,mu1,cov1)*(size1/(size1 + size2));
    tmpsaum = mvnpdf(test,mu2,cov2)*(size2/(size1 + size2));

    res = tmpbar > tmpsaum;
end

