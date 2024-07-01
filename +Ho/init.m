global A H L1 L2 tau_max H1 H2 delta q_max
L1 = transpose(lqr(A',H',eye(2),eye(2))); 
L2 = transpose(lqr(A',H',2*eye(2),eye(2)));
tau_max = 3; 
delta = 0.1; %SOD of ETM on sensor-controller channel
q_max = 30; %counter upper limit
F1 = A-L1*H;
F2 = A-L2*H;
H2 = (eye(2)-expm(F2*tau_max)*expm(-F1*tau_max))^(-1);
H1 = eye(2)-H2;