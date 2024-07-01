function dx_c = F(x_c,y)
    % x_c = (\hat{x},\eta)
    global L G
    eta = x_c(3);
    dhat_x = zeros(2,1);
    deta = -2*eta*L-eta^2-G;
    dx_c = [dhat_x;deta];
end