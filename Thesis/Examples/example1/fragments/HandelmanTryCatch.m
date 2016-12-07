%% solving Handelman Rep. for V = x over x>=0
clear all; clc;

% initiate polynomials
x = msspoly('x',1);     %creates msspoly object   
V = x;
poly = [x];
deg = 0;



while deg<2
    
    try 
        
        deg %just used to display the current degree
        
        % Initialize spotsosprog program
        prog = spotsosprog;
        prog = prog.withIndeterminate(x);
        lambda = [];

        mMonoid = multiplicativeMonoid(poly, deg)

        % add non-negative multipliers
        [prog,newlambda]...
            = prog.newPos(length(mMonoid)-length(prog.coneVar));
        lambda = [lambda; newlambda];
        %full(prog.A)        %just for DEBUGGING

        % constrain to HR
        prog = prog.withPolyEqs(V-lambda.'*mMonoid)
        %V-lambda.'*mMonoid  %just for DEBUGGING
        %full(prog.A)        %just for DEBUGGING
        
        % options
        options = spot_sdp_default_options();
        % Solve program
        sol = prog.minimize(sum(lambda), @spot_gurobi, options)
        
        if ~sol.isPrimalFeasible()
            deg = deg+1;
            error('Cannot evaluate: primal infeasible.'); 
        else
            break
        end
        
    catch ERROR
        clear prog sol lambda
    end
    
end
  
% Optimal value
opt_lambda = double(sol.eval(lambda))
[feasibility,~] = isDSOS(diag(opt_lambda));


