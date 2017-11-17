close all;
%% Init
muSaumon = [8 8];
sigmaSaumon = [1 0 ; 0 1];
muBar = [10 16];
sigmaBar = [4 0; 0 4];
% sizeVT = 1000;
sizeVTSaumon = 1000;
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
nbBarErreur = zeros(nbIter,1);
nbSaumonErreur = zeros(nbIter,1);
erreurmoyenne = zeros(nbIter,1);

ACPnbBarErreur = zeros(nbIter,1);
ACPnbSaumonErreur = zeros(nbIter,1);
ACPerreurmoyenne = zeros(nbIter,1);

ACInbBarErreur = zeros(nbIter,1);
ACInbSaumonErreur = zeros(nbIter,1);
ACIerreurmoyenne = zeros(nbIter,1);
%% 
for i=1:nbIter
    
    SaumonIndice = randperm(sizeVTSaumon, sizeVTSaumon);
    TrainSaumonIndice = SaumonIndice(1:sizeTrain);
    TrainSaumon = VTSaumon(TrainSaumonIndice,:);
    muSaumonTrain = mean(TrainSaumon);
    sigmaSaumonTrain = cov(TrainSaumon);
    
    BarIndice = randperm(sizeVTBar,sizeVTBar);
    TrainBarIndice = BarIndice(1:sizeTrain);
    TrainBar = VTBar(TrainBarIndice,:);
    muBarTrain = mean(TrainBar);
    sigmaBarTrain = cov(TrainBar);
    
    TestBarIndice =  BarIndice(sizeTrain+1:sizeVTBar);
    TestSaumonIndice =  SaumonIndice(sizeTrain+1:sizeVTSaumon);
    
    TestBar =  [VTBar(TestBarIndice,:); VTBar(TestBarIndice,:)];
    TestSaumon = [VTSaumon(TestSaumonIndice,:); VTSaumon(TestSaumonIndice,:)];
    %% MAP
    ResBar = MyClassifBayesien(TestBar,muBarTrain,sigmaBarTrain,muSaumonTrain,sigmaSaumonTrain,mcost, sizeVTBar, sizeVTSaumon);
    ResSaumon = MyClassifBayesien(TestSaumon,muBarTrain,sigmaBarTrain,muSaumonTrain,sigmaSaumonTrain,mcost,sizeVTBar, sizeVTSaumon);
    nbBarErreur(i) = ((size(ResBar,1)-sum(ResBar)) / sizeVTBar) * 100;
    nbSaumonErreur(i) = (sum(ResSaumon) / sizeVTSaumon) * 100;
    
    erreurmoyenne(i) = ((nbBarErreur(i) * length(TestBar)) + (nbSaumonErreur(i) * length(TestSaumon)))./ (length(TestSaumon) + length(TestBar));
    
    %% ACP + MAP
    echantillons = [TrainBar; TrainSaumon];
    [myacp, C, moy]= CalculACP(echantillons);
    ACPTrainW = transpose(myacp(:,1));
    ACPBarTrainCentre = TrainBar - moy;
    ACPSaumonTrainCentre = TrainSaumon - moy;
    
    ACPBarTrainProj = transpose(ACPTrainW * ACPBarTrainCentre');
    ACPSaumonTrainProj = transpose(ACPTrainW * ACPSaumonTrainCentre');

    ACPmuBarTrain = mean(ACPBarTrainProj);
    ACPsigmaBarTrain = cov(ACPBarTrainProj);
    
    ACPmuSaumonTrain = mean(ACPSaumonTrainProj);
    ACPsigmaSaumonTrain = cov(ACPSaumonTrainProj);
    
    echantillons = [TestBar; TestSaumon];
    [myacp, C, moy] = CalculACP(echantillons);
    
    ACPTestW = transpose(myacp(:,1));
    ACPBarTestCentre = TestBar - moy;
    ACPSaumonTestCentre = TestSaumon - moy;
    
    ACPBarTestProj = transpose(ACPTestW * ACPBarTestCentre');
    ACPSaumonTestProj = transpose(ACPTestW * ACPSaumonTestCentre');
    
    sizeBarProj = length(ACPBarTestProj);
    sizeSaumonProj = length(ACPSaumonTestProj);
    
    ACPResBar = MyClassifBayesien(ACPBarTestProj,ACPmuBarTrain,ACPsigmaBarTrain,ACPmuSaumonTrain,ACPsigmaSaumonTrain,mcost, sizeBarProj, sizeSaumonProj);
    ACPResSaumon = MyClassifBayesien(ACPSaumonTestProj,ACPmuBarTrain,ACPsigmaBarTrain,ACPmuSaumonTrain,ACPsigmaSaumonTrain,mcost,sizeBarProj, sizeSaumonProj);
    ACPnbBarErreur(i) = ((size(ACPResBar,1)-sum(ACPResBar)) / sizeBarProj) * 100;
    ACPnbSaumonErreur(i) = (sum(ACPResSaumon) / sizeSaumonProj) * 100;
    
    ACPerreurmoyenne(i) = ((ACPnbBarErreur(i) * length(ACPBarTestProj)) + (ACPnbSaumonErreur(i) * length(ACPSaumonTestProj)))./ (length(ACPSaumonTestProj) + length(ACPBarTestProj));
    
    %% ACI + MAP
  myaci = CalculACI(TrainBar, TrainSaumon);
  ACITrainW = transpose(myaci(:,1));
  ACITrainBarProj = transpose(ACITrainW * TrainBar');
  ACITrainSaumonProj = transpose(ACITrainW * TrainSaumon');
  
  ACImuBarTrain = mean(ACITrainBarProj);
  ACIsigmaBarTrain = cov(ACITrainBarProj);
  
  ACImuSaumonTrain = mean(ACITrainSaumonProj);
  ACIsigmaSaumonTrain = cov(ACITrainSaumonProj);
  
  myaci = CalculACI(TestBar, TestSaumon);
  
  ACITestW = transpose(myaci(:,1));
  ACIBarTestProj = transpose(ACITestW * TestBar');
  ACISaumonTestProj = transpose(ACITestW * TestSaumon');
  
  sizeBarProj = length(ACIBarTestProj);
  sizeSaumonProj = length(ACISaumonTestProj);
  
  ACIResBar = MyClassifBayesien(ACIBarTestProj,ACImuBarTrain,ACIsigmaBarTrain,ACImuSaumonTrain,ACIsigmaSaumonTrain,mcost, sizeBarProj, sizeSaumonProj);
  ACIResSaumon = MyClassifBayesien(ACISaumonTestProj,ACImuBarTrain,ACIsigmaBarTrain,ACImuSaumonTrain,ACIsigmaSaumonTrain,mcost,sizeBarProj, sizeSaumonProj);
  ACInbBarErreur(i) = ((size(ACPResBar,1)-sum(ACPResBar)) / sizeBarProj) * 100;
  ACInbSaumonErreur(i) = (sum(ACPResSaumon) / sizeSaumonProj) * 100;
  
  ACIerreurmoyenne(i) = ((ACInbBarErreur(i) * length(ACIBarTestProj)) + (ACInbSaumonErreur(i) * length(ACISaumonTestProj)))./ (length(ACISaumonTestProj) + length(ACIBarTestProj));
  
end;
%% Affichage des'erreurs
figure('Name','Error MAP');
plot(1:1:nbIter,nbBarErreur,'color','g');
hold on;
plot(1:1:nbIter,nbSaumonErreur,'color','b');
plot(1:1:nbIter,erreurmoyenne,'color','r');
hold off;

%%%%ACP
figure('Name','Error ACP + MAP');
hold on
plot(1:1:nbIter,ACPnbBarErreur,'color','g');
hold on;
plot(1:1:nbIter,ACPnbSaumonErreur,'color','b');
plot(1:1:nbIter,ACPerreurmoyenne,'color','r');
hold off;

%%%%ACI
figure('Name','Error ACI + MAP');
hold on 
plot(1:1:nbIter,ACInbBarErreur,'color','g');
hold on;
plot(1:1:nbIter,ACInbSaumonErreur,'color','b');
plot(1:1:nbIter,ACIerreurmoyenne,'color','r');
hold off;
%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% echantillons = [VTBar; VTSaumon];
% figure('Name','ACP');
% hold on
% 
% [myacp, C, moy]= CalculACP(echantillons);
% scatter(C(:,1), C(:,2));
% W = transpose(myacp(:,1));
% 
% CProj = transpose(W * C');
% Cbis = transpose(CProj * W);
% y = droite2DVd(C,W,[0 0]);
% plot(C,y);
% 
% yproj = droite2DVd(Cbis,W,[0 0]);
% scatter(Cbis(:,1),yproj(:,1));
% hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% moy = mean(echantillons);
% v = CalculACI(VTBar, VTSaumon);
% %vcentre = v + moy;
% % VTBarCentre = VTBar - moy;
% % VTSaumonCentre = VTSaumon - moy;
% figure('Name','ACI');
% hold on 
% %plot(v(:,1));
% axis image;
% plot(0:20, droite2DVd(0:20,v,moy), 'b');
% plot(0:20, droite2DVd(0:20,v(:,2),moy), 'k');
% scatter(VTBar(:,1),VTBar(:,2),'g');
% scatter(VTSaumon(:,1),VTSaumon(:,2),'r');
% hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
