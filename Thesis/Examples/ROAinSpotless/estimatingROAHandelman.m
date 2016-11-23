%% solving S-Procedure for V = x^2 =< rho and dynamics dx = x^2 - x
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
    deg = 2;
    z = monomials(x,0:deg);
    
    [prog,Q0] = prog.newDD(deg+1); s0 = z.'*Q0*z;   %constraining the DSOS multiplier
    % DSOS constraint
    prog = prog.withDSOS((-dV-s0*(rho_u-V)));
    
    % sedumi options
    options = spot_sdp_default_options();
    % Solve program
    sol = prog.minimize(trace((blkdiag(Q0)-eye(deg+1))), @spot_gurobi, options);
    %sol = prog.minimize((0), @spot_sedumi, options);    
    
    % Optimal value
    opt_dsos0 = double(sol.eval(Q0));
    
    [feasibility,violation] = isDSOS(blkdiag(opt_dsos0))
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

opt_dsos0
-dV-(z.'*opt_dsos0*z)*(rho_u-V)

disp(['the estrimated ROA corresponds to rho = ', num2str(rho_u)])
plottingV(rho_l);
plottingdV(rho_l);

% this section plays an animation of the iteration steps

% movie(framesV,1,1)
% movie(framesdV,1,1)

