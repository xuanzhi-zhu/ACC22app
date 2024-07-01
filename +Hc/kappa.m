function u = kappa(x_c,y)
    global K
    hat_x = x_c(1:2);
    u = -K*hat_x;