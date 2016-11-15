%% solving PSatz for V = x^2 =< rho and dynamics dx = x^2 - x
clear all; clc;

% initiate polynomials
x = msspoly('x',1);     %creates msspoly object   
V = x;

    % DSOS program
    % Initialize program
    prog = spotsosprog;
    prog = prog.withIndeterminate(x);
    deg = 1;
    z = monomials(x,0:deg);
    
    [prog,Q0] = prog.newDD(deg+1); s0 = z.'*Q0*z;   %constraining the DSOS multipliers
    
    % DSOS constraint
    prog = prog.withDSOS((s0));

    % sedumi options
    options = spot_sdp_default_options();
    % Solve program
    sol = prog.minimizeDSOS(trace(-Q0), @spot_sedumi, options);  
    %sol = prog.minimizeDSOS(trace(eye(deg+1)-Q0), @spot_sedumi, options);
  
    % Optimal value
    opt_dsos0 = double(sol.eval(Q0))
    
    [feasibility,violation] = isDSOS(opt_dsos0)

    



