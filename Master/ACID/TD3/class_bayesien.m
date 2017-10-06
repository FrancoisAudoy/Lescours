close all;
muSaumon = 12;
sigmaSaumon = 4;
muBar = 10;
sigmaBar = 2;
sizeVT = 1000;
sizeVTSaumon = 1000;
sizeVTBar = 500;
VTSaumon = mvnrnd(muSaumon, sigmaSaumon, sizeVTSaumon);
VTBar = mvnrnd(muBar, sigmaBar, sizeVTBar);

figure('Name','Histo VT');
hold on;
histogram(VTSaumon,'Normalization','pdf');
histogram(VTBar,'Normalization','pdf');
hold off;

mcost = [0 2 : 1 0];

nbIter = 100;
sizeTrain = 100;
nbBarErreur = zeros(nbIter);
nbSaumonErreur = zeros(nbIter);
for i=1:nbIter
    
    TrainSaumonIndice = randperm(sizeVTSaumon, sizeTrain);
    TrainBarIndice = randperm(sizeVTBar,sizeTrain);
    TrainSaumon = VTSaumon(TrainSaumonIndice);
    TrainBar = VTBar(TrainBarIndice);
    muSaumonTrain = mean(TrainSaumon);
    sigmaSaumonTrain = sqrt(var(TrainSaumon));
    muBarTrain = mean(TrainBar);
    sigmaBarTrain = sqrt(var(TrainBar));
    
    TestBar = VTBar;
    TestSaumon = VTSaumon;
    
    diffTestBar = setdiff(TestBar,TrainBar);
    diffTestSaumon = setdiff(TestSaumon,TrainSaumon);
    
    ResBar = Myclassify(diffTestBar,muBarTrain,sigmaBarTrain,muSaumonTrain,sigmaSaumonTrain, sizeVTBar, sizeVTSaumon, sizeVTSaumon + sizeVTBar);
    ResSaumon = Myclassify(diffTestSaumon,muBarTrain,sigmaBarTrain, muSaumonTrain,sigmaSaumonTrain,sizeVTBar, sizeVTSaumon, sizeVTSaumon + sizeVTBar);
    %ResBar = ClassifBayesien(diffTestBar,muBarTrain,sigmaBarTrain,muSaumonTrain,sigmaSaumonTrain,mcost, sizeVTBar, sizeVTSaumon, sizeVTSaumon + sizeVTBar);
    %ResSaumon = ClassifBayesien(diffTestBar,muBarTrain,sigmaBarTrain,muSaumonTrain,sigmaSaumonTrain,mcost,sizeVTBar, sizeVTSaumon, sizeVTSaumon + sizeVTBar);
    nbBarErreur(i) = size(ResBar,1)-sum(ResBar);
    nbSaumonErreur(i) = sum(ResSaumon);
end;

figure('Name','Error');
plot(1:1:100,nbBarErreur);
hold on;
plot(1:1:100,nbSaumonErreur);
hold off;
    
function res = Myclassify(test, mu1, sig1, mu2,sig2, size1, size2, sizetot)
    tmpbar = normpdf(test,mu1,sig1)*(size1/sizetot);
    tmpsaum = normpdf(test,mu2,sig2)*(size2/sizetot);

    res = tmpbar > tmpsaum;
end

function res = ClassifBayesien(test, mu1, sig1, mu2, sig2, mcost, size1, size2, sizetot)
probtest1 = normpdf(test,mu1,sig1);
probtest2 = normpdf(test,mu2,sig2);

diff1 = mcost(1:2) - mcost(2:2);
diff2 = mcost(2:1) - mcost(1:1);

res = (probtest1 / probtest2) > ((diff1/diff2) * (2/3 * 1/3)) 

end