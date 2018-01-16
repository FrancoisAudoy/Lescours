function  Res  = MyclassifyN(test, modelC1, modelC2, pC1, pC2)
    probC1  = mvnpdf(test,modelC1.mu, modelC1.sigma)*pC1;
    probC2  = mvnpdf(test,modelC2.mu, modelC2.sigma)*pC2;
    
    
    Res = probC1 >= probC2; % 1 si échantillon classifié comme bar, 0 si échantillon classifié comme saumon
    
end

