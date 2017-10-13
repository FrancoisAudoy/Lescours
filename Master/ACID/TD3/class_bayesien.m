close all;
muSaumon = [8 8];
sigmaSaumon = [1 0; 0 1];
muBar = [12 12];
sigmaBar = [4 0; 0 4];
sizeVT = 1000;
sizeVTSaumon = 1000;
sizeVTBar = 1000;
VTSaumon = mvnrnd(muSaumon, sigmaSaumon, sizeVTSaumon);
VTBar = mvnrnd(muBar, sigmaBar, sizeVTBar);

figure('Name','Histo VT');
hold on;
hist3(VTSaumon);
hist3(VTBar);
hold off;

mcost = [0 1 ; 5 0];

nbIter = 100;
sizeTrain = 100;
nbBarErreur = zeros(nbIter);
nbSaumonErreur = zeros(nbIter);
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
    
    %ResBar = Myclassify(TestBar,muBarTrain,sigmaBarTrain,muSaumonTrain,sigmaSaumonTrain, sizeVTBar, sizeVTSaumon);
    %ResSaumon = Myclassify(TestSaumon,muBarTrain,sigmaBarTrain, muSaumonTrain,sigmaSaumonTrain,sizeVTBar, sizeVTSaumon);
    %ResBar = ClassifBayesien(TestBar,muBarTrain,sigmaBarTrain,muSaumonTrain,sigmaSaumonTrain,mcost, sizeVTBar, sizeVTSaumon);
    %ResSaumon = ClassifBayesien(TestSaumon,muBarTrain,sigmaBarTrain,muSaumonTrain,sigmaSaumonTrain,mcost,sizeVTBar, sizeVTSaumon);
    ResBar = Classif2Bayesien(TestBar,muBarTrain,sigmaBarTrain,muSaumonTrain,sigmaSaumonTrain,mcost, sizeVTBar, sizeVTSaumon);
    ResSaumon = Classif2Bayesien(TestSaumon,muBarTrain,sigmaBarTrain,muSaumonTrain,sigmaSaumonTrain,mcost,sizeVTBar, sizeVTSaumon);
    nbBarErreur(i) = size(ResBar,1)-sum(ResBar);
    nbSaumonErreur(i) = sum(ResSaumon);
end;

erreurmoyenne = (nbBarErreur./length(TestBar) + nbSaumonErreur./length(TestSaumon))./ (length(TestSaumon) + length(TestBar));

figure('Name','Error');
plot(1:1:nbIter,nbBarErreur,'color','g');
hold on;
plot(1:1:nbIter,nbSaumonErreur,'color','b');
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

function res = Classif2Bayesien(test,mu1, cov1, mu2, cov2, mcost, size1, size2)
probtest = mvnpdf(test,mu1,cov1) ./ mvnpdf(test,mu2,cov2);

diff1 = mcost(1,2) - mcost(2,2);
diff2 = mcost(2,1) - mcost(1,1);

diff = diff1 / diff2;

res = (probtest > (diff * ((size2/(size1+size2)) / (size1/(size1+size2)))));
end