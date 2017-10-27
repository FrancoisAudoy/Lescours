function  Res  = Myclassify(test, modelBar, modelSaumon, pBar, pSaumon)

    probBar     = normpdf(test,modelBar.mu, modelBar.sigma)*pBar;
    probSaumon  = normpdf(test,modelSaumon.mu, modelSaumon.sigma)*pSaumon;
    
        
    Res = probBar >= probSaumon; % 1 si échantillon classifié comme bar, 0 si échantillon classifié comme saumon
    
end

