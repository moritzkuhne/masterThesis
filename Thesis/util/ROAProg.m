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
rho_try = 0;            %current rho value up for optimization 
rho_extr = 5;         %maximum rho value of interesst  
rho_failed = rho_extr;  %lowest rho value for which prog. failed

%initiate the solution to the ROAprog
solution = solROAprog(-dV,rho_extr,'pos');

a = 0.001;
while ~(rho_try-solution.rho <= a && rho_try ~= 0) && ...
        ~(solution.rho_extr-solution.rho <= a) && ... 
        ~(rho_failed-solution.rho <= a)

    [sol,decisionVar] = method(-dV,[(rho_try-V),inequalities],deg,options);
    
    if sol.isPrimalFeasible()
        for i=1:length(decisionVar)
            opt_Qset{i} = double(sol.eval(decisionVar{i}));
             %length(decisionVar{1}) all elements in decisionVar are...
             %the same length, so length(decisionVar(1)) is constant
        end
        
        if ~isempty(sol.gramMatrices)
            Q = double(sol.eval(sol.gramMatrices{1}));
            isDSOS(Q)
        else
            Q = [];
        end

        [DSOSfeasibility,violation] = isDSOS(blkdiag(Q,opt_Qset{:}));

        if DSOSfeasibility
            feasibility = true;
            solution.sol = sol;

            if rho_try > 0.5
                save('INFEASIBLESOLUTION.mat','solution')
            end
            
        else
            feasibility = false; violation
        end
        
    else
        feasibility = false;
        
    end
    solution.rho
    % determine new rho_try (aka expand domain)
    [rho_try,rho_failed] = bisectInterval(solution,...
        feasibility,rho_try,rho_failed)
    solution.rho
end

end

