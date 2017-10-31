close all;
muSaumon = [8 8];
sigmaSaumon = [1 0; 0 1];
muBar = [12 12];
sigmaBar = [4 0; 0 4];
sizeVT = 1000;
sizeVTSaumon = 1500;
sizeVTBar = 1000;
VTSaumon = mvnrnd(muSaumon, sigmaSaumon, sizeVTSaumon);
VTBar = mvnrnd(muBar, sigmaBar, sizeVTBar);

hold on;
hist3(VTSaumon);
hist3(VTBar);
hold off;

mcost = [0 1 ; 5 0];

nbIter = 100;
sizeTrain = 100;
nbBarErreur = zeros(nbIter);
nbSaumonErreur = zeros(nbIter);
erreurmoyenne = zeros(nbIter);
for i=1:nbIter
    
    SaumonIndice = randperm(sizeVTSaumon, sizeVTSaumon);
    TrainSaumonIndice = SaumonIndice(1:sizeTrain);
    Train1Saumon = VTSaumon(TrainSaumonIndice,:);
    muSaumonTrain = mean(Train1Saumon);
    sigmaSaumonTrain = cov(Train1Saumon);
    
    BarIndice = randperm(sizeVTBar,sizeVTBar);
    TrainBarIndice = BarIndice(1:sizeTrain);
    Train1Bar = VTBar(TrainBarIndice,:);
    muBarTrain = mean(Train1Bar);
    sigmaBarTrain = cov(Train1Bar);
    
    TestBarIndice =  BarIndice(sizeTrain+1:sizeVTBar);
    TestSaumonIndice =  SaumonIndice(sizeTrain+1:sizeVTSaumon);
    
    TestBar =  [VTBar(TestBarIndice,:); VTBar(TestBarIndice,:)];
    TestSaumon = [VTSaumon(TestSaumonIndice,:); VTSaumon(TestSaumonIndice,:)];
    
    ResBar = MyClassifBayesien(TestBar,muBarTrain,sigmaBarTrain,muSaumonTrain,sigmaSaumonTrain,mcost, sizeVTBar, sizeVTSaumon);
    ResSaumon = Classif2Bayesien(TestSaumon,muBarTrain,sigmaBarTrain,muSaumonTrain,sigmaSaumonTrain,mcost,sizeVTBar, sizeVTSaumon);
    nbBarErreur(i) = size(ResBar,1)-sum(ResBar);
    nbSaumonErreur(i) = sum(ResSaumon);
    
    erreurmoyenne(i) = ((nbBarErreur(i) * length(TestBar)) + (nbSaumonErreur(i) * length(TestSaumon)))./ (length(TestSaumon) + length(TestBar));
end;

figure('Name','Error');
plot(1:1:nbIter,nbBarErreur,'color','g');
hold on;
plot(1:1:nbIter,nbSaumonErreur,'color','b');
plot(1:1:nbIter,erreurmoyenne,'color','r');
hold off;
    
echantillons = [VTBar; VTSaumon];
figure('Name','ACP');
hold on
scatter(echantillons(:,1),echantillons(:,2))

[myacp, C, moy]= CalculACP(echantillons);
W = transpose((myacp(:,1)));
CProj = Proj(W,C);
x = 1:20;

yacp = droite2DVd(C,W,moy);
plot(C,yacp);

yproj = droite2DVd(CProj,W,moy);  
scatter(CProj,yproj);
hold off

function res = Classif2Bayesien(test,mu1, cov1, mu2, cov2, mcost, size1, size2)
probtest = mvnpdf(test,mu1,cov1) ./ mvnpdf(test,mu2,cov2);

diff1 = mcost(1,2) - mcost(2,2);
diff2 = mcost(2,1) - mcost(1,1);

diff = diff1 / diff2;

res = (probtest > (diff * ((size2/(size1+size2)) / (size1/(size1+size2)))));
end