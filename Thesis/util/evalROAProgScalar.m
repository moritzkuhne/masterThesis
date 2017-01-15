function [rho] = evalROAProgScalar(solution,lambda)
%EVALROAPROG This function evaluates solutions from ROAProg
%   Detailed explanation goes here

% Optimal value
if ~isempty(solution.sol)
    if solution.sol.isPrimalFeasible()
        opt_lambda = double(solution.sol.eval(lambda));
        [DSOSfeasibility,~] = isDSOS(diag(opt_lambda));
    end
else
    warning(['Increase degree or relaxation until origin is certified'...
                                                  'to be stable.'])
    disp(['Non-linear dynamics are not certified'...
                                    'to be stable at the origin!'])
end

disp(['the estrimated ROA corresponds to rho = ',...
    num2str(solution.rho),'.'])
                                    
rho = solution.rho;

end

