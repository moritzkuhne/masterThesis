% to do:    post processing: check if all multipliers are DSOS and ...

function [optimal_rho,solution] = ROARhoProg(dV_negated,V,inequalities,...
    method,deg,optimal_multipliers,options)
%ROARhoPROG This function sets-up and solves estimatie ROA optimization
% problem in rho 
%   Detailed explanation goes here

solution = solROARhoprog();

[progMethod,~] = switchMethod(method,'rho');

[sol,decision_rho] = progMethod(dV_negated,V,inequalities,deg,optimal_multipliers,options);
feasibility = sol.isPrimalFeasible();

if feasibility
    solution.sol = sol;
    optimal_rho = double(solution.sol.eval(decision_rho));
    
else
    optimal_rho = 0;
    warning(['The RhoPro is not feasible.'])
    disp(['Non-linear dynamics are not certified'...
                                    'to be stable at the origin!'])
end
    solution.rho = optimal_rho;

end

