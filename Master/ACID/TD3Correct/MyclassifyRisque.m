function  Res  = MyclassifyRisque(test, modelBar, modelSaumon, pBar, pSaumon, mcout)

    probBar     = normpdf(test,modelBar.mu, modelBar.sigma)*pBar;
    probSaumon  = normpdf(test,modelSaumon.mu, modelSaumon.sigma)*pSaumon;
    

    
    Res = probBar*(mcout(1, 1) - mcout(2, 1)) < probSaumon*(mcout(2, 2)-mcout(1, 2));
    
    % 1 si échantillon classifié comme bar, 0 si échantillon classifié comme saumon

end

