function next_xi = G(x_c,y)
    % x_c = (\hat{x},\eta)
    % y = x
    global ub_c
    next_xc = y;
    next_eta = ub_c;
    next_xi = [next_xc;next_eta];