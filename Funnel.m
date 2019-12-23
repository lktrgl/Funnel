
G = 1;
M = 1;
global K = -G*M;
global Eps=0.00001;

function fx=Fx(x,y)
  global K
  global Eps
  tmp=x.^2+y.^2+Eps;
  fx=K*y./(sqrt(tmp).*tmp);
endfunction

function fy=Fy(x,y)
  global K
  global Eps
  tmp=x.^2+y.^2+Eps;
  fy=K*x./(sqrt(tmp).*tmp);
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

t = linspace(0,7, 1000);
sol=lsode( "pend",[10, -1, 10, -1], t);
##plot( t, sol,"-@")
##plot( t,[sol(:,1)';sol(:,3)'],"-@")
plot( sol(:,1)',sol(:,3)',"-@")

