% to do:    post processing: check if all multipliers are DSOS and ...

function [optimal_rho,optimal_V,solution] = ROARhoProg(dx,x,inequalities,...
    method,deg,optimal_multipliers,options)
%ROARhoPROG This function sets-up and solves estimatie ROA optimization
% problem in rho 
%   Detailed explanation goes here

solution = solROARhoprog();

[progMethod,~] = switchMethod(method,'rho');

[sol,decision_rho,freeV] = progMethod(dx,x,inequalities,deg,optimal_multipliers,options);
feasibility = sol.isPrimalFeasible();

if feasibility
    solution.sol = sol;
    optimal_rho = double(solution.sol.eval(decision_rho));
    optimal_freeV = double(solution.sol.eval(freeV));
    optimal_V = optimal_freeV.'*monomials(x,1:2);
    
else
    optimal_rho = 0;
    optimal_V = 0;
    warning(['The RhoProg is not feasible.'])
    disp(['Non-linear dynamics are not certified'...
                                    'to be stable at the origin!'])
end
    solution.rho = optimal_rho;

end

