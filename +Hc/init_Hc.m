global A B aa ee K G L ub_c lb_c
aa = 0.5;
ee = 0.5;
cvx_begin
    variable Y(2,2) symmetric
    variable J(1,2)
    minimize trace_inv(Y)
    subject to
        [eye(2), zeros(2), A*Y-B*J; 
         zeros(2), eye(2)./(aa+ee), Y;
         Y*A'-J'*B', Y, -Y*A'+J'*B'-A*Y+B*J] == semidefinite(6)
cvx_end
P = inv(Y);
K = J*P;
G = aa+max(svd(P*B*K))^2/ee;
L = max(svd(B*K));
ub_c = 1;
lb_c = 0.1;