function [] = animationDescenteSurface(pdep)

x = -8:0.1:8;
y = -8:0.1:8;

[X,Y] = meshgrid(-8:0.5:8,-8:0.5:8);


figure;
hold on;

Z = surfaceTest(X,Y);

axis([-8 8 -8 8 -10 300]);

contour(X,Y,Z);
%surf(X, Y, Z); 
scatter3(pdep(1),pdep(2), surfaceTest(pdep(1), pdep(2)));

xprec = pdep(1);
yprec = pdep(2);

epsilon = 0.1;

nu = 0.05;

[dx,dy] = gradientSurfaceTest(xprec,yprec)

dist = norm([dx,dy]); 
xcurrent = xprec-nu*dx;
ycurrent = yprec-nu*dy;

while(dist > epsilon)
    
    scatter3(xcurrent, ycurrent, surfaceTest(xcurrent, ycurrent));
    
    xprec = xcurrent;
    yprec = ycurrent;
    
    [dx,dy] = gradientSurfaceTest(xprec,yprec);
    
    dist = norm([dx,dy]) 
    
    xcurrent = xprec-nu*dx;
    ycurrent = yprec-nu*dy;
    
    pause(1);
end
scatter3(xcurrent, ycurrent, surfaceTest(xcurrent, ycurrent));
xcurrent
ycurrent

end
