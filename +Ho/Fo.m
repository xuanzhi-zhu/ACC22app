function dxo = Fo(xs,xc,xo,y,u)
    global A B H L1 L2
    hx1 = xo(1:2);
    hx2 = xo(3:4);
    %u = Hc.kappa(xc,h(xs));
    dhx1 = A*hx1+B*u+L1*(y-H*hx1);
    dhx2 = A*hx2+B*u+L2*(y-H*hx2);
    dtau = 1;
    dq   = 0;
    dxo = [dhx1;dhx2;dtau;dq];