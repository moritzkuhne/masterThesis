%% solving Handelman Rep. for V = x^2 =< rho and dynamics dx = x^2 - x
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
        lambda = [lambda; newlambda]
        full(prog.A)

        % constrain to HR
        prog = prog.withPolyEqs(V-lambda.'*mMonoid)
        V-lambda.'*mMonoid
        full(prog.A)
        prog = prog.withPolyEqs(V-lambda.'*mMonoid)
        full(prog.A)
        
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

%sol = prog.minimize((0), @spot_sedumi, options);    

% Optimal value
opt_lambda = double(sol.eval(lambda))

[feasibility,~] = isDSOS(diag(opt_lambda));


% %% solving Handelman Rep. for V = x^2 =< rho and dynamics dx = x^2 - x
% clear all; clc;
% 
% % initiate polynomials
% x = msspoly('x',1);     %creates msspoly object   
% V = x;
% poly = [x];
% deg = 0;
% 
% % Initialize spotsosprog program
% prog = spotsosprog;
% prog = prog.withIndeterminate(x);
% lambda = [];
% 
% while deg<2
%     
%     try 
% 
%         mMonoid = multiplicativeMonoid(poly, deg)
% 
%         % add non-negative multipliers
%         [prog,newlambda]...
%             = prog.newPos(length(mMonoid)-length(prog.coneVar));
%         lambda = [lambda; newlambda]
%         full(prog.A)
% 
%         % constrain to HR
%         prog = prog.withPolyEqs(V-lambda.'*mMonoid)
%         V-lambda.'*mMonoid
%         full(prog.A)
%         prog = prog.withPolyEqs(V-lambda.'*mMonoid)
%         full(prog.A)
%         
%         % options
%         options = spot_sdp_default_options();
%         % Solve program
%         sol = prog.minimize(sum(lambda), @spot_gurobi, options)
%         
%         if ~sol.isPrimalFeasible()
%             error('Cannot evaluate: primal infeasible.'); 
%         end
%         
%     catch ERROR
%         deg = deg+1
%         %prog.A = [];
%         %prog.b = [];
%     end
%     
% end
% 
% %sol = prog.minimize((0), @spot_sedumi, options);    
% 
% % Optimal value
% opt_lambda = double(sol.eval(lambda))
% 
% [feasibility,~] = isDSOS(diag(opt_lambda));
