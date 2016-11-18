%% solving PSatz for V = x^2 =< rho and dynamics dx = x^2 - x
clear all; clc;

% initiate polynomials
x = msspoly('x',1);     %creates msspoly object   
V = x^2;
dV = 2*(x^3-x^2);


rho_u = 1; rho_uINF = rho_u; rho_l = 0; i=0;

while (rho_u-rho_l >= 0.01)
        
    rho_u %just used to display the current upper bound rho value
    rho_l %just used to display the current lower bound rho value
    
    % DSOS program
    % Initialize program
    prog = spotsosprog;
    prog = prog.withIndeterminate(x);
    deg = 3;
    z = monomials(x,0:deg);
    
    [prog,Q0] = prog.newDD(deg+1); s0 = z.'*Q0*z;   %constraining the DSOS multipliers
    [prog,Q1] = prog.newDD(deg+1); s1 = z.'*Q1*z;   %constraining the DSOS multipliers
    [prog,Q2] = prog.newDD(deg+1); s2 = z.'*Q2*z;   %constraining the DSOS multipliers
    % DSOS constraint
    prog = prog.withDSOS((-s0*dV-s1*(rho_u-V)-s2*dV*(rho_u-V)-dV^2));
    
    % sedumi options
    options = spot_sdp_default_options();
    % Solve program
    sol = prog.minimize(trace((blkdiag(Q0,Q1,Q2)-eye(3*(deg+1)))), @spot_gurobi, options);
    %sol = prog.minimize((0), @spot_sedumi, options);    
    
    % Optimal value
    opt_dsos0 = double(sol.eval(Q0));
    opt_dsos1 = double(sol.eval(Q1));
    opt_dsos2 = double(sol.eval(Q2));
    
    [feasibility,violation] = isDSOS(blkdiag(opt_dsos0,opt_dsos1,opt_dsos2))
    infeasible = ~feasibility;
    
    % initiate new problem
    if infeasible == 0
        rho_lNEW = rho_u;
        rho_uNEW = 0.5*(rho_uINF-rho_u)+rho_u;
    end
    
    if infeasible == 1
        rho_uNEW = 0.5*(rho_u-rho_l)+rho_l;
        rho_lNEW = rho_l;
        rho_uINF = rho_u;
    end
    
    rho_u = rho_uNEW;
    rho_l = rho_lNEW;
    
    i = i +1;
    
%     % plotting for videos
%     plottingV(rho_l);
%     framesV(i) = getframe(gcf)
%     plottingdV(rho_l);
%     framesdV(i) = getframe(gcf)
%     close all;
    
end

disp(['the estrimated ROA corresponds to rho = ', num2str(rho_u)])
plottingV(rho_l);
plottingdV(rho_l);

% this section plays an animation of the interation steps

% movie(framesV,1,1)
% movie(framesdV,1,1)
