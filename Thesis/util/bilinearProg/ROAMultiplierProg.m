% to do:    post processing: check if all multipliers are DSOS and ...

function [optimal_rho,optimal_multiplier,solution] = ROAMultiplierProg(dV,V,inequalities,...
    rho_bounds,method,deg,options)
%ROAPROG This function sets-up and solves estimatie ROA optimization prob. 
%   Detailed explanation goes here

%[progMethod,evalMethod] = switchMethod(method,'multiplier');
progMethod = @SprocedureProg; evalMethod = @evalROAProgDSOS;

%setting up the initial and extreme rho values
if ((length(rho_bounds) == 2) && (rho_bounds(1) < rho_bounds(2)))
    rho_try = rho_bounds(1);   %current rho value up for optimization
    rho_extr = rho_bounds(2);      %maximum rho value of interesst 
else
    warning(['The specified Rho values are not ameanable. Rho(1) must '...
        'be smaller than Rho(2). And both need to be specified. '...
        'Continuing the program with Rho(1) = 0 and Rho(2) = 1.'])
    rho_try = 0;        %current rho value up for optimization 
    rho_extr = 1.1;         %maximum rho value of interesst  
end
    rho_initial = rho_try;
    rho_failed = rho_extr;  %lowest rho value for which prog. failed

%initiate the solution to the ROAprog
solution = solROAprog(-dV,rho_extr,'pos');

while ~(rho_try-solution.rho <= 0.01 && rho_try ~= rho_initial) && ...
        ~(solution.rho_extr-solution.rho <= 0.01) && ... 
        ~(rho_failed-solution.rho <= 0.01)

    [sol,decision_multiplier] = progMethod(-dV,[(rho_try-V),inequalities],deg,options);
    feasibility = sol.isPrimalFeasible()
    
    if feasibility
        solution.sol = sol;
    end
    
    % determine new rho_try (aka expand domain)
    [rho_try,rho_failed] = bisectInterval(solution,...
        feasibility,rho_try,rho_failed);
    
end

[optimal_rho,optimal_multiplier] = evalMethod(solution,decision_multiplier);

end

