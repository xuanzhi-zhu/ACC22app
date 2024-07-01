function out = D(x_c,y)
    global lb_c
    eta = x_c(3);
    if eta <= lb_c
        out = 1;
    else
        out = 0;
    end