global A B H
A = [0,1;
     0,0];
B = [0;1];
H = eye(2);

rng('shuffle'); %reseed random number generator
run('Hc.init_Hc.m')
run('Ho.init.m')

TSPAN = [0 10];
JSPAN = [0 1000];

rule = 1;
options = odeset('RelTol',1e-6,'MaxStep',.1);

% x0 = rand(2,1)*2-1;
x0 = [-0.5;0.5];
xi0 = [x0;x0;ub_c;x0;zeros(5,1);1];

[t,j,xi] = HyEQsolver(@F,@G,@C,@D,xi0,TSPAN,JSPAN,rule,options);

save data t j xi

function dxi = F(xi)
    x = xi(1:2);
    xc = xi(3:5);
    xs = xi(6:7);
    xo = xi(8:13);
    u = Hc.kappa(xc,h(xs));
    dx = f(x,u);
    dxc = Hc.F(xc,h(xs));
    dxs = f(xs,u);
    dxo = Ho.Fo(xs,xc,xo,h(x),u);
    dxi = [dx;dxc;dxs;dxo];
end

function next_xi = G(xi)
    x = xi(1:2);
    xc = xi(3:5);
    xs = xi(6:7);
    xo = xi(8:13);
    next_x = x;
    next_xc = Hc.G(xc,h(xs));
    [next_xs,next_xo] = Ho.Gs(xs,xc,xo,h(x)); 
    
    G1 = [next_x;next_xc;xs;xo];
    G2 = [next_x;xc;next_xs;next_xo];
    out_c = Hc.D(xc,h(xs));
    out_s = Ho.Ds(xs,xc,xo,h(x));
    if (out_c == 1) && (out_s == 0)
        next_xi = G1;
    elseif (out_c == 0) && (out_s == 1)
        next_xi = G2;
    else
        index = round(rand(1))+1; %generate 1 or 2 randomly
        next = [G1 G2];
        next_xi = next(:,index);
    end
end

function out = D(xi)
    x = xi(1:2);
    xc = xi(3:5);
    xs = xi(6:7);
    xo = xi(8:13);
    out_c = Hc.D(xc,h(xs));
    out_s = Ho.Ds(xs,xc,xo,h(x));
    if out_c || out_s
        out = 1;
    else
        out = 0;
    end
end
   
function out = C(xi)
    x = xi(1:2);
    xc = xi(3:5);
    xs = xi(6:7);
    xo = xi(8:13);
    out_c = Hc.C(xc,h(xs));
    out_s = Ho.Cs(xs,xc,xo,h(x));
    if out_c && out_s
        out = 1;
    else
        out = 0;
    end
end