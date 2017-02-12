function [solver,spotOptions] = solverOptionsPSDProg(options)
%SOLVEROPTIONSPSDPROG The options for solver and solver options arefiltered
%out from the input options

%   Detailed explanation goes here

%set solver
if isfield(options,'solver')
    solver = options.solver;
else
    solver = @spot_gurobi;
end

%set solver options
spotOptions = spot_sdp_default_options();
if isfield(options,'solverOptions')
    spotOptions.solver_options = options.solverOptions;
else
    spotOptions.solver_options = struct();
end

end

