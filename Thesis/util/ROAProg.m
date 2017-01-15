% to do:    add k parameter for kSProcedure
%           post processing: check if all multipliers are DSOS and ...
%                            check solution/ accuracy of solver somehow


function [solution,decisionVar] = ROAProg(dV,V,inequalities,...
    method,deg,options)
%ROAPROG This function sets-up and solves estimatie ROA optimization prob. 
%   Detailed explanation goes here

%setting up the initial and extreme rho values
rho_try = 0;            %current rho value up for optimization 
rho_extr = 1.1;         %maximum rho value of interesst  
rho_failed = rho_extr;  %lowest rho value for which prog. failed

%initiate the solution to the ROAprog
solution = solROAprog(-dV,rho_extr,'pos');

while ~(rho_try-solution.rho <= 0.01 && rho_try ~= 0) && ...
        ~(solution.rho_extr-solution.rho <= 0.01) && ... 
        ~(rho_failed-solution.rho <= 0.01)

    [sol,decisionVar] = method(-dV,[(rho_try-V),inequalities],deg,options);
    feasibility = sol.isPrimalFeasible()
    
    if feasibility
        solution.sol = sol;
    end
    
    % determine new rho_try (aka expand domain)
    [rho_try,rho_failed] = bisectInterval(solution,...
        feasibility,rho_try,rho_failed)
    
end

end

