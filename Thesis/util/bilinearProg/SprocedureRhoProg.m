% TO DO:    add wiggle at V

function [solution,rho] = SprocedureRhoProg(dV_negated,V,inequalities,deg,opt_Qset,options)
%SPROCEDURERHOPROG Sets up S-procedure programm in rho and maximize rho
%
%   returns solution is a single scalar rho

    if nargin < 5
        options = [];
    end

    [indet,~,~] = decomp(dV_negated);
    z = monomials(indet,0:deg);
    
    %initiate program
    prog = spotsosprog;
    prog = prog.withIndeterminate(indet);
    
    % setting decision variable rho
    [prog,rho] = prog.newPos(1);
    
    inequalities = [(rho-V), inequalities];
    % setting up DSOS polynomial multipliers  
    for i=1:length(inequalities)
        
        if ~exist('S', 'var')
            S = (z.'*opt_Qset{i}*z)*inequalities(i);
        else
            S = S + (z.'*opt_Qset{i}*z)*inequalities(i);
        end
        
    end
    
    % DSOS constraint
    prog = prog.withDSOS((dV_negated-S));
    
    %set solver options
    spotOptions = spot_sdp_default_options();
    if isfield(options,'solverOptions')
        spotOptions.solver_options = options.solverOptions;
    else
        spotOptions.solver_options = struct();
    end
    
    %setting objective
    objective = -rho;
    
    % Solve program
    solution = prog.minimize(objective, @spot_gurobi, spotOptions); 
    
end

