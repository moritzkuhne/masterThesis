%% solving Handelman Rep. for V = x^2 =< rho and dynamics dx = x^2 - x
clear all; clc;

% initiate polynomials
x = msspoly('x',1);     %creates msspoly object   

% setting up the systems dynamics
dx = x^2-x;
V = x^2; 
dV = diff(V,x)*dx;

%setting up the initial and extreme rho values
rho_try = 0;            %current rho value up for optimization 
rho_extr = 1.1;         %maximum rho value of interesst  
rho_failed = rho_extr;  %lowest rho value for which prog. failed

%initiate the solution to the ROAprog
solution = solROAprog(-dV,rho_extr,'symm');

%set the degree of the multiplicative monoid
deg = 2;

while ~(rho_try-solution.rho <= 0.01 && rho_try ~= 0) && ...
        ~(solution.rho_extr-solution.rho <= 0.01) && ... 
        ~(rho_failed-solution.rho <= 0.01)
    
    inequalities = [rho_try-V;];
    %inequalities = [rho_try-V;rho_try-x;x+rho_try];

    [sol,lambda] = HandelmanProg(-dV,inequalities,deg);
    feasibility = sol.isPrimalFeasible();
    
    if feasibility
        solution.sol = sol;
    end
    
    % determine new rho_try (aka expand domain)
    [rho_try,rho_failed] = bisectInterval(solution,...
        feasibility,rho_try,rho_failed)
    
end

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
%plottingV(solution.rho);
%plottingdV(solution.rho);

%% comments
% This method will always fail, since deg(V_dot) = 3 and deg(V)=2,
% hence all powers of (rho-V)^k with k \in N^+ produces even deg poly
% Therefore it is not possible to equate V_dot