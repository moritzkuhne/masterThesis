%% solving Handelman Rep. for V = x^2 =< rho and dynamics dx = x^2 - x
clear all; clc;

% initiate polynomials
x = msspoly('x',1);     %creates msspoly object   
V = x^2;
dV = 2*(x^3-x^2);
deg = 5;

rho_u = 1; rho_uINF = rho_u; rho_l = 0; i=0;

while (rho_u-rho_l >= 0.01)
        
    rho_u %just used to display the current upper bound rho value
    rho_l %just used to display the current lower bound rho value
    
    polynomials = [rho_u-V;rho_u-x;x+rho_u];
    mMonoid = multiplicativeMonoid(polynomials, deg);
        
    % Initialize spotsosprog program
    prog = spotsosprog;
    prog = prog.withIndeterminate(x);
        
    % add nonlinear multipliers
    [prog,lambda] = prog.newPos(length(mMonoid));
    prog = prog.withPolyEqs(-dV-lambda.'*mMonoid);
    
    % options
    options = spot_sdp_default_options();
    % Solve program
    sol = prog.minimize(sum(lambda), @spot_gurobi, options);    
    
    feasibility = sol.isPrimalFeasible();
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

% Optimal value
opt_lambda = double(sol.eval(lambda));
[feasibility,~] = isDSOS(diag(opt_lambda));

disp(['the estrimated ROA corresponds to rho = ', num2str(rho_u)])
plottingV(rho_l);
plottingdV(rho_l);

% this section plays an animation of the iteration steps

% movie(framesV,1,1)
% movie(framesdV,1,1)

