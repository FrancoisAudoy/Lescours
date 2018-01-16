
close all;

figure('Name', 'parabole et sa derivee') 
hold on;

axis auto;
X = -100: 100;
Y = parabole(X);
plot(X, Y)


dY = diff(Y)./diff(X);
length(X)
length(dY)

% Comparer la courbe suivante :
plot(X(:, 1:length(X)-1),dY,'r')

% Avec celle-ci
Yd = 2*X;
plot(X, Yd, 'g')



figure('Name', 'animation parabole')
hold off
% en un point de la parabole, on affiche la tangente (le coefficient directeur est la derivee)

hold on;

plot(X,Y)

for i=-80:20:80
    
    plot(i,parabole(i),'or');
    
    tg =2*i*10+parabole(i);
    
    plot([i;i+10],[parabole(i);tg],'r')
    
    %pause(1);
end

hold off

c = [2 3 5 10 2 9]
x = [2 2]
a = valeurPolynome(c,x)

absice = 0:1:100;

figure('Name','Polynome et derive');
hold on
plot(absice, valeurPolynome(c,absice));

derive = valeurPolynome(derivPolynome(c),absice);
plot(absice, derive);
hold off


