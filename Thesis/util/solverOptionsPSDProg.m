function [solver,spotOptions,options] = solverOptionsPSDProg(options)
%SOLVEROPTIONSPSDPROG The options for solver and solver options are 
%filtered out from the input options

%set solver
if isfield(options,'solver')
    solver = options.solver;
else
    solver = @spot_gurobi;
    options.solver = solver;
end

%set solver options
spotOptions = spot_sdp_default_options();
if isfield(options,'solverOptions')
    spotOptions.solver_options = options.solverOptions;
else
    spotOptions.solver_options = struct();
    options.solverOptions = spotOptions.solver_options;
end

end

