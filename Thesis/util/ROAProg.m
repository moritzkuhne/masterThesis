% to do:    post processing: check if all multipliers are DSOS and ...
%                            check solution/ accuracy of solver somehow
%           this function works so far only for psatz and k-s-procedure!
%           we need to handle vector of decsion variable instead of set for
%           handelman representation!

function [solution,decisionVar] = ROAProg(dV,V,inequalities,...
    method,deg,options)
%ROAPROG This function sets-up and solves estimatie ROA optimization prob. 
%   Detailed explanation goes here

%setting up the initial and extreme rho values 
rho_extr = 5;         %maximum rho value of interesst  
rho_failed = rho_extr;  %lowest rho value for which prog. failed

%initiate the solution to the ROAprog
solution = solROAprog(-dV,rho_extr,options,'pos');

terminate = false;
while ~terminate

    % step 1
    [rho_try,options] = fixRho(solution,rho_failed,options);
    
    % step 2
    [sol,decisionVar] = method(-dV,[(rho_try-V),inequalities],deg,options);
    
    % step 3
    [feasibility,violation] = isPSDprogFeasible(sol,decisionVar)
    
    [terminate,options] = isBreak(solution,rho_try,rho_failed,options);
    
    if feasibility
        solution.rho = rho_try;
        solution.sol = sol;
        solution.options = options;
    else
        rho_failed = rho_try;
    end
    
end

end