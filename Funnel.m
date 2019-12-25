clear all

#-------------------------------------

T0 = 0;
Tmax = 30;

X0 = 1;
Vx0 = 0;
Y0 = 0;
Vy0 = 1;

#-------------------------------------

Npoints = (round(Tmax-T0) + 1) * 20;

#-------------------------------------

global G = 1;
global M = 1;
global Eps = 0.01;
global Mju = 0.7;
global K = G * M;
global Kz = G * M;

global X_ID = 1;
global dX_ID = 2;
global Y_ID = 3;
global dY_ID = 4;

#-------------------------------------

function fr=getR(x,y)
  global Eps;
  fr = sqrt(x.^2 + y.^2 + Eps);
endfunction

#-------------------------------------

function fx=Fx(x,y)
  global K;
  fx = -K * x ./ (getR(x,y).^2);
endfunction

#-------------------------------------

function fy=Fy(x,y)
  global K;
  fy = -K * y ./ (getR(x,y).^2);
endfunction

#-------------------------------------

function fz=Fz(x,y)
  global Kz;
  fz = Kz * getR(x,y).^2;
endfunction

#-------------------------------------

function xdot = insideTheFunelMovement(x,t)
  global X_ID;
  global dX_ID;
  global Y_ID;
  global dY_ID;
  global Mju;

  xdot( X_ID) =  x(dX_ID);
  xdot(dX_ID) = -x( X_ID) -Mju * x(dX_ID) + Fx(x(X_ID),x(Y_ID));
  xdot( Y_ID) =  x(dY_ID);
  xdot(dY_ID) = -x( Y_ID) -Mju * x(dY_ID) + Fy(x(X_ID),x(Y_ID));
end

#-------------------------------------

#
#  Main
#

#-------------------------------------

t = linspace(T0,Tmax, Npoints);
sol=lsode( "insideTheFunelMovement",[X0, Vx0, Y0, Vy0], t);

solZ=Fz(sol(:,1),sol(:,3));
Z0 = Fz(X0,Y0);

hold off
plot3( sol(:,1)',sol(:,3)',solZ',"-@")
hold on
plot3( X0,Y0,Z0,"-@")
hold off

grid on
xlabel ("ось X");
ylabel ("ось Y");
zlabel ("ось Z");
title ("3-D график движения в воронке");

