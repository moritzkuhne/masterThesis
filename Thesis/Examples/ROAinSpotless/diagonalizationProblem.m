% enhancing stability of solutions by using the objective to push the
% solutions to the center of DSOS

clear all; clc;

% initiate polynomials
x = msspoly('x',1);     %creates msspoly object   
f = x^4 + x^2;

%intiate optimization program
    prog = spotsosprog;
    prog = prog.withIndeterminate(x);
    deg = 2;
    z = monomials(x,0:deg);
    
   [prog,Q0] = prog.newDD(deg+1); s0 = z.'*Q0*z;   %constraining the DSOS multipliers
    
    % DSOS constraint
    prog = prog.withDSOS((f - s0));
    
    % sedumi options
    options = spot_sdp_default_options();
    % Solve program
%    sol = prog.minimize(trace(blkdiag(Q0)), @spot_sedumi, options);
    sol = prog.minimizeDSOS((trace(eye(deg+1)-Q0)), @spot_sedumi, options);     %this method needs some scaling for I
%    sol = prog.minimize((trace(eye(deg+1)-Q0)+offDiag(Q0)), @spot_sedumi, options);
    % Optimal value
    opt_dsos0 = double(sol.eval(Q0));
   
    % from here some post processing, i.e. checking PSDness of the DD
    % matrices
    [feasibility,violation] = isDSOS(opt_dsos0)

%     indices = find(abs(opt_dsos0)<1E-15);
%     opt_dsos0(indices) = 0; 
%     [feasibility,violation] = isDSOS(opt_dsos0)