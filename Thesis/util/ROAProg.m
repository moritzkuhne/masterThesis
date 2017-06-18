function [solution,options] = ROAProg(system,options)
%ROAPROG This function sets-up and solves estimatie ROA optimization prob. 
%   Detailed explanation goes here

global counter

%initiate the solution to the ROAprog
solution = solROAprog(system,options);

V = system.V;
dV = diff(system.V,system.states)*system.dx;
inequalities = system.inequCon;
equalities = system.equCon;

%preloop assinments
terminate = false;
rho_failed = solution.rho_extr;
while ~terminate
    counter = counter+1;
    % step 1
    [rho_try,options] = fixRho(solution,rho_failed,options);
    rho_try
    % step 2
    [method,deg,degP,options] = methodOptionsROAProg(options);
    [sol,objective,options] = method(-dV,system,...
        [(rho_try-V),inequalities],equalities,deg,degP,options);
    
    % step 3
    [feasibility,violation,options] = ...
        isPSDprogFeasible(sol,objective,options);
    violation
    [terminate,options] = isTerminate(solution,rho_try,rho_failed,options);
    
    if feasibility
        solution.rho = rho_try;
        solution.sol = sol;
        solution.options = options;
    else
        rho_failed = rho_try;
    end
    
end

end