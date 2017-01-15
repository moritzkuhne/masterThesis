function [rho] = evalROAProgDSOS(solution,decisionVar)
%EVALROAPROG This function evaluates solutions from ROAProg
%   Detailed explanation goes here

% Optimal value
if ~isempty(solution.sol)
    if solution.sol.isPrimalFeasible()
        
        opt_Q0 = double(solution.sol.eval(...
            trace(blkdiag(decisionVar{:})...
            -eye(length(decisionVar)*(length(decisionVar{1}))))));
             %length(decisionVar{1}) all elements in decisionVar are...
             %the same length, so length(decisionVar(1)) is constant
                
        [DSOSfeasibility,~] = isDSOS(opt_Q0);
    end
else
    warning(['Increase degree until origin is certified '...
                                                  'to be stable.'])
    disp(['Non-linear dynamics are not certified '...
                                    'to be stable at the origin!'])
end

disp(['The estrimated ROA corresponds to rho = ',...
                                        num2str(solution.rho),'.'])
                                    
rho = solution.rho;

end

