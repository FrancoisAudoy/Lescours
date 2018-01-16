load('donnees.mat')

close all

figure('Name','Data')
hold on
%scatter(testC1(:,1), testC1(:,2), 'o', 'b')
%scatter(testC2(:,1), testC2(:,2), 'o', 'r')
scatter(trainC1(:,1), trainC1(:,2), 'x', 'b')
scatter(trainC2(:,1), trainC2(:,2), 'x', 'r')
hold off

MTrain = [trainC1 ; trainC2];

kdts = KDTreeSearcher(MTrain);
k = 4;
newPoint = [1,0.283]
[AddC1]= knnsearch(kdts,testC1,'K',k)

%%Check a qui appartienne ces indices Train(AddC1) == trainC1(AddC1) ?
%[AddC2 dC2] = knnsearch(kdts,testC1,'K',k)
sz = 100;
hold on
scatter(MTrain(AddC1,1),MTrain(AddC1,2), sz ,'d','g');
scatter(testC1(:,1), testC1(:,2), sz, '*', 'k');
legend('TrainC1','TrainC2','Choix du Knn','enchantillons ajoutés');
hold off
% hold on
% if sum(dC2)/k > sum(dC1)/k
%     scatter(testC1(AddC1,1), testC1(AddC1,2), sz,'d','g');
%     scatter(testC2(AddC2,1), testC2(AddC2,2),150,'^','k');
%     color = 'b';
% else
%     scatter(testC2(AddC2,1), testC2(AddC2,2),sz,'d','g');
%         scatter(testC1(AddC1,1), testC1(AddC1,2), 150,'^','k');
% 
%     color = 'r';
% end
% scatter(newPoint(1,1), newPoint(1,2),sz, 'd',color,'filled');
% hold off