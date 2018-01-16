function [C2Error, C1Error ] = computeErrorMAP(ResC2, ResC1)
    nbC1Error    = size(ResC1,1) - sum(ResC1); % pas d'erreur :
                                                  % que des 1 (les
                                                  % 0 sont des erreurs)
    C1Error = nbC1Error / size(ResC1,1);
    
    nbC2Error = sum(ResC2); % pas d'erreur : que des 0 (les
                                    % 1 sont des erreurs)
    C2Error = nbC2Error / size(ResC2,1);
end

