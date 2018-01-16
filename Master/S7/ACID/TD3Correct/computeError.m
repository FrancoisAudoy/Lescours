function [SaumonError, BarError ] = computeError(ResSaumon, ResBar)
    nbBarError    = size(ResBar,1) - sum(ResBar); % pas d'erreur :
                                                  % que des 1 (les
                                                  % 0 sont des erreurs)
    BarError = nbBarError / size(ResBar,1);
    
    nbSaumonError = sum(ResSaumon); % pas d'erreur : que des 0 (les
                                    % 1 sont des erreurs)
    SaumonError = nbSaumonError / size(ResSaumon,1);
end

