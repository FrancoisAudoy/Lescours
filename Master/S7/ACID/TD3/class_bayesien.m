close all;
muSaumon = 12;
sigmaSaumon = 4;
muBar = 10;
sigmaBar = 2;
sizeVT = 1000;
sizeVTSaumon = 1000;
sizeVTBar = 1000;
VTSaumon = mvnrnd(muSaumon, sigmaSaumon, sizeVTSaumon);
VTBar = mvnrnd(muBar, sigmaBar, sizeVTBar);

figure('Name','Histo VT');
hold on;
histogram(VTSaumon);
histogram(VTBar);
hold off;

mcost = [0 0 ; 10 10];

nbIter = 100;
sizeTrain = 100;
ErreurClassif = zeros(nbIter);
ErreurBay = zeros(nbIter);
for i=1:nbIter
    
    SaumonIndice = randperm(sizeVTSaumon, sizeVTSaumon);
    BarIndice = randperm(sizeVTBar,sizeVTBar);
    
    TrainSaumonIndice = SaumonIndice(1:sizeTrain);
    TrainBarIndice = BarIndice(1:sizeTrain);
    TrainSaumon = VTSaumon(TrainSaumonIndice);
    TrainBar = VTBar(TrainBarIndice);
    muSaumonTrain = mean(TrainSaumon);
    sigmaSaumonTrain = sqrt(var(TrainSaumon));
    muBarTrain = mean(TrainBar);
    sigmaBarTrain = sqrt(var(TrainBar));
    
    TestBarIndice =  BarIndice(sizeTrain+1:sizeVTBar);
    TestSaumonIndice =  SaumonIndice(sizeTrain+1:sizeVTSaumon);
    TestBar =  VTBar(TestBarIndice);
    TestSaumon = VTSaumon(TestSaumonIndice);
    
    ResBar = Myclassify(TestBar,muBarTrain,sigmaBarTrain,muSaumonTrain,sigmaSaumonTrain, sizeVTBar, sizeVTSaumon);
    ResSaumon = Myclassify(TestSaumon,muBarTrain,sigmaBarTrain, muSaumonTrain,sigmaSaumonTrain,sizeVTBar, sizeVTSaumon);
    
    nbBarErreur = size(ResBar,1)-sum(ResBar);
    nbSaumonErreur = sum(ResSaumon);
    ErreurClassif(i) = nbBarErreur + nbSaumonErreur;
    
    ResBar = ClassifBayesien(TestBar,muBarTrain,sigmaBarTrain,muSaumonTrain,sigmaSaumonTrain,mcost, sizeVTBar, sizeVTSaumon);
    ResSaumon = ClassifBayesien(TestSaumon,muBarTrain,sigmaBarTrain,muSaumonTrain,sigmaSaumonTrain,mcost,sizeVTBar, sizeVTSaumon);
   
    nbBarErreur = size(ResBar,1)-sum(ResBar);
    nbSaumonErreur = sum(ResSaumon);
    ErreurBay(i) = nbBarErreur + nbSaumonErreur;
end;

erreurmoyenne = (ErreurClassif + ErreurBay) / 2;

figure('Name','Error');
plot(1:1:nbIter,ErreurClassif,'color','g');
hold on;
plot(1:1:nbIter,ErreurBay,'color','b');
plot(1:1:nbIter,erreurmoyenne,'color','r');
hold off;
    
function res = Myclassify(test, mu1, sig1, mu2,sig2, size1, size2)
    tmpbar = normpdf(test,mu1,sig1)*(size1/(size1 + size2));
    tmpsaum = normpdf(test,mu2,sig2)*(size2/(size1 + size2));

    res = tmpbar > tmpsaum;
end

function res = ClassifBayesien(test, mu1, sig1, mu2, sig2, mcost, size1, size2)

probtest = normpdf(test,mu1,sig1) ./ normpdf(test,mu2,sig2);

diff1 = mcost(1,2) - mcost(2,2);
diff2 = mcost(2,1) - mcost(1,1);

diff = diff1 / diff2;

res = (probtest > (diff * ((size2/(size1+size2)) / (size1/(size1+size2)))));

end