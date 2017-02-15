% to do:    PASS rho vecotrs to program
%           this function works so far only for psatz and k-s-procedure!
%           we need to handle vector of decsion variable instead of set for
%           handelman representation!

function [solution,options] = ROAProg(dV,V,inequalities,options)
%ROAPROG This function sets-up and solves estimatie ROA optimization prob. 
%   Detailed explanation goes here

%setting up the initial and extreme rho values 
rho_extr = 1.1;         %maximum rho value of interesst  
rho_failed = rho_extr;  %lowest rho value for which prog. failed

%initiate the solution to the ROAprog
solution = solROAprog(-dV,rho_extr,options,'pos');
terminate = false;

while ~terminate

    % step 1
    [rho_try,options] = fixRho(solution,rho_failed,options);
    
    % step 2
    [method,deg,options] = methodOptionsROAProg(options);
    [sol,objective,options] = method(-dV,V,[(rho_try-V),inequalities],deg,options);
    
    % step 3
    [feasibility,violation,options] = ...
        isPSDprogFeasible(sol,objective,options);
%     if strcmp(violation,'DSOS, eigenvalues')
%         save('INFEASIBLESOLUTION.mat','sol','decisionVar','rho_try')
%     end
%     pause
    
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