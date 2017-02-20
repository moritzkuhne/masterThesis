function [rho,opt_Qset] = evalROAProgDSOS(solution,decisionVar)
%EVALROAPROG This function evaluates solutions from ROAProg
%   Detailed explanation goes here

% Optimal value
if ~isempty(solution.sol)
    if solution.sol.isPrimalFeasible()
        
        for i=1:length(decisionVar)
            opt_Qset{i} = double(solution.sol.eval(decisionVar{i}));
             %length(decisionVar{1}) all elements in decisionVar are...
             %the same length, so length(decisionVar(1)) is constant
        end
                
        [DSOSfeasibility,violation] = isDSOS(blkdiag(opt_Qset{:}));
        
        if ~DSOSfeasibility
            warning('The solution is not a DSOS, see violations: ')
            violation
        end
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

