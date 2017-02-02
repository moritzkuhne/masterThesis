% TO DO:    add wiggle at V

function [solution,rho,freeV] = SprocedureRhoProg(dx,x,inequalities,deg,opt_Qset,options)
%SPROCEDURERHOPROG Sets up S-procedure programm in rho and maximize rho
%
%   returns solution is a single scalar rho

    if nargin < 6
        options = [];
    end

    [indet,~,~] = decomp([x; inequalities.']);
    
    %initiate program
    prog = spotsosprog;
    prog = prog.withIndeterminate(indet);
    
    % setting decision variable rho
    [prog,rho] = prog.newPos(1);
    
    %setting new V
    [prog,V,dV,freeV] = bilinearV(prog,dx,x,inequalities);
        
    z = monomials(indet,0:deg);
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
    prog = prog.withDSOS((-dV-S));
    
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

