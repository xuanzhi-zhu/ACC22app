function [next_xs,next_xo] = Gs(xs,xc,xo,y)
    global tau_max delta q_max H1 H2
    hx1 = xo(1:2);
    hx2 = xo(3:4);
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
    
    next_hx1 = H1*hx1+H2*hx2;
    next_hx2 = H1*hx1+H2*hx2;
    next_q = mod(q,q_max)+1;
    
    G1 = [xs;next_hx1;next_hx2;0;next_q];
    G2 = [hx1;hx1;hx2;tau;q];
    G3 = [next_hx1;next_hx1;next_hx2;0;next_q];
    
    if (out1 == 1) && (out2 == 0) && (out3 == 0)
        next = G1;
    elseif (out1 == 0) && (out2 == 1) && (out3 == 0)
        next = G2;
    elseif (out1 == 0) && (out2 == 0) && (out3 == 1)
        next = G3;
    elseif (out1 == 1) && (out2 == 1) && (out3 == 0)
        index = round(rand(1))+1; %generate 1 or 2 randomly
        next = [G1 G2];
        next = next(:,index);
    else
        index = round(rand(1))+1; %generate 1 or 2 randomly
        next = [G2 G3];
        next = next(:,index);
    end
    
    next_xs = next(1:2);
    
    next_xo = next(3:end);
    
%     if norm(xs-hx1)>=delta
%         next_xs = hx1;
%     else
%         next_xs = xs;
%     end
%     if tau >= tau_max
%         next_hx1 = H1*hx1+H2*hx2;
%         next_hx2 = H1*hx1+H2*hx2;
%         next_tau = 0;
%         next_q = mod(q,q_max)+1;
%         if q < q_max
%             next_xs = xs;
%         else
%             next_xs = next_hx1;
%         end
%     else
%         next_hx1 = hx1;
%         next_hx2 = hx2;
%         next_tau = tau;
%         next_q = q;
%     end
%     next_xo = [next_hx1;next_hx2;next_tau;next_q];
    
        
        
        