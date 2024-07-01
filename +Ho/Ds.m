function out = Ds(xs,xc,xo,y)
global tau_max delta q_max
    hx1 = xo(1:2);
    tau = xo(5);
    q = xo(6);
    
    if (tau >= tau_max) && (q < q_max)
        out1 = 1;
    else
        out1 = 0;
    end
    
    if norm(xs-hx1) >= delta
        out2 = 1;
    else
        out2 = 0;
    end
    
    if (tau >= tau_max) && (q == q_max)
        out3 = 1;
    else
        out3 = 0;
    end
    
    out = out1 | out2 | out3;




%     global tau_max delta
%     hx1 = xo(1:2);
%     tau = xo(5);
%     if (tau >= tau_max) || norm(xs-hx1)>=delta
%         out = 1;
%     else
%         out = 0;
%     end
    