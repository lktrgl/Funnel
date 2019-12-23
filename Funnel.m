
G = 1000000;
M = 1000000;
global K = -G*M;
global Eps=0.00001;

function y1=Fx(x,y)
  global K
  global Eps
  y1=0;##K*y./(x.^2+y.^2+Eps);
endfunction
function y1=Fy(x,y)
  global K
  global Eps
  y1=0;##K*x./(x.^2+y.^2+Eps);
endfunction


##ty=tx=linspace(-5,5,50)';
##[xx, yy] = meshgrid (tx, ty);
##
##tz = sqrt (Fx (K,xx,yy).^2+Fy (K,xx,yy).^2);
##mesh (tx, ty, tz);


function xdot = pend(x,t)
  xdot(1) = x(2); 
  xdot(2) = Fx(x(1),x(3));
  xdot(3) = x(4); 
  xdot(4) = Fy(x(1),x(3));
end
  sol=lsode( "pend",[10, -0.1,-10,-0.1], t = linspace(0,10, 10000));
  plot( t, sol,"-@")
##plot( t,[sol(:,1)';sol(:,3)'],"-@")
##  plot( sol(:,1)',sol(:,2)',"-@")

