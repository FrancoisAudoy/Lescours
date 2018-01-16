close all;
clear all;
clc;

muSaumon    = 12;
sigmaSaumon = 4;
muBar       = 10;
sigmaBar    = 2;
sizeVTSaumon = 1000;
sizeVTBar = 500;

%mcout = [1 3; 2 2];% equivalent a MAP avec ces coefficients!
mcout = [0 2; 3 0];

%proba a priori
pBar=sizeVTBar/(sizeVTBar+sizeVTSaumon);
pSaumon=sizeVTSaumon/(sizeVTBar+sizeVTSaumon);
VTSaumon = mvnrnd(muSaumon,sigmaSaumon*sigmaSaumon, sizeVTSaumon);
VTBar    = mvnrnd(muBar, sigmaBar*sigmaBar, sizeVTBar);

%visualisation des echantillons 
figure(1)
plot(VTSaumon,'.');
hold on
plot(VTBar,'.g');

%%
%figure(2)
%histogram(VTSaumon,'Normalization','pdf');
%hold on
%histogram(VTBar,'Normalization','pdf');
%plot(0:0.1:25,normpdf(0:0.1:25,muSaumon,sigmaSaumon),'r')
%plot(0:0.1:25,normpdf(0:0.1:25,muBar,sigmaBar),'g')

%%
nbIter   = 100;
sizeTrain = 100;
errorBarML = zeros(nbIter,1);
errorSaumonML = zeros(nbIter, 1);
errorML = zeros(nbIter, 1);
errorBarMAP = zeros(nbIter,1);
errorSaumonMAP = zeros(nbIter, 1);
errorMAP = zeros(nbIter, 1);
errorBarRisque = zeros(nbIter,1);
errorSaumonRisque = zeros(nbIter, 1);
errorRisque = zeros(nbIter, 1);

for i=1:nbIter
    
        [TrainSaumon,TestSaumon,TrainBar, TestBar] = extractTestAndTrain(VTSaumon, VTBar, sizeTrain);
        [modelSaumon] = TrainModel(TrainSaumon);
        [modelBar] = TrainModel(TrainBar);
       
        % maximum de vraissemblance 
        ResBar    =    Myclassify(TestBar,modelBar, modelSaumon, 0.5, 0.5);
        ResSaumon =    Myclassify(TestSaumon,modelBar, modelSaumon, 0.5, 0.5);
        [SaumonError, BarError] = computeError(ResSaumon, ResBar);
        errorSaumonML(i) = SaumonError*100;
        errorBarML(i) = BarError*100;
        errorML(i) = (length(TestSaumon) * errorSaumonML(i) + length(TestBar) *  errorBarML(i) )/ (length(TestSaumon) + length(TestBar));
        
        % MAP (utilisation des proba a priori)
        ResBar    =    Myclassify(TestBar,modelBar, modelSaumon, pBar, pSaumon);
        ResSaumon =    Myclassify(TestSaumon,modelBar, modelSaumon, pBar, pSaumon);
        [SaumonError, BarError] = computeError(ResSaumon, ResBar);
        errorSaumonMAP(i) = SaumonError*100;
        errorBarMAP(i) = BarError*100;
        errorMAP(i) = (length(TestSaumon) * errorSaumonMAP(i) + length(TestBar) *  errorBarMAP(i) )/ (length(TestSaumon) + length(TestBar))
        
        % Risque (utilisation de la matrice de cout)
        ResBar    =    MyclassifyRisque(TestBar,modelBar, modelSaumon, pBar, pSaumon, mcout);
        ResSaumon =    MyclassifyRisque(TestSaumon,modelBar, modelSaumon, pBar, pSaumon, mcout);
        [SaumonError, BarError] = computeError(ResSaumon, ResBar);
        errorSaumonRisque(i) = SaumonError*100;
        errorBarRisque(i) = BarError*100;
        errorRisque(i) = (length(TestSaumon) * errorSaumonRisque(i) + length(TestBar) *  errorBarRisque(i) )/ (length(TestSaumon) + length(TestBar))
   
end;

MeanErrorBarML    = mean(errorBarML);
MeanErrorSaumonML = mean(errorSaumonML);
MeanErrorML = mean(errorML);

MeanErrorBarMAP    = mean(errorBarMAP);
MeanErrorSaumonMAP = mean(errorSaumonMAP);
MeanErrorMAP = mean(errorMAP);

MeanErrorBarRisque    = mean(errorBarRisque);
MeanErrorSaumonRisque = mean(errorSaumonRisque);
MeanErrorRisque = mean(errorRisque);

figure(3);
plot(1:nbIter, errorBarML, 'g')
hold on
plot(1:nbIter, errorSaumonML)
plot(1:nbIter, errorML, 'k')
hold off
ylim([0 100])

figure(4);
plot(1:nbIter, errorBarMAP, 'g')
hold on
plot(1:nbIter, errorSaumonMAP)
plot(1:nbIter, errorMAP, 'k')
hold off
ylim([0 100])

figure(5);
plot(1:nbIter, errorBarRisque, 'g')
hold on
plot(1:nbIter, errorSaumonRisque)
plot(1:nbIter, errorRisque, 'k')
hold off
ylim([0 100])
