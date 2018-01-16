close all
epsilon = 0.01; % critere d'arret
attenuation = 10^10; % pas du gradient 1/log(attenuation)
coefs = [30 -61 41 -11 1];
pas = 0.001;

x = -8:1:8;
y = -8:1:8;

figure('Name', 'recherche du minimum sur une surface')
hold on

[X,Y] = meshgrid(x,y);

Z = f_surface(X,Y);

contour(X,Y,Z);

x0 = 5;
y0 = 2;
xcurrent = x0;
ycurrent = y0;
xprec = xcurrent;
yprec = ycurrent;
zcurrent = f_surface(x0,y0) - pas*f_surface(x0,y0);
zprec = f_surface(x0,y0);

attenuation = attenuation +1 ;

contour(x0,y0,zprec,'ok','MarkerSize',20); marche pas


while(abs(zprec - zcurrent) > epsilon)
    
    %contour(zcurrent,'ob');
   
    %zprec  = zcurrent;
    nu = 0.01;
    attenuation = attenuation+1;
    xcurrent = xprec - nu*xprec;
    ycurrent = yprec - nu*yprec;
    zcurrent = f_surface(xcurrent,ycurrent) - nu*f_surface(xcurrent,ycurrent);
    pause(1);
end

%plot(xcurrent,valeurPolynome(coefs,xcurrent),'xr', 'MarkerSize',20);

hold off

function r = f_surface(x,y)
    r = ((x - 1).*(x - 2)) + ((y + 3).*(y + 4));
end
