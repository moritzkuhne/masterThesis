%% solving S-Procedure for V = x^2 =< rho and dynamics dx = x^2 - x
clear all; clc;

% initiate polynomials
x = msspoly('x',1);     %state variables 
a = msspoly('a',1);     %parameter 
a_u = 1; a_l = 0.5;     %parameter bounds

% setting up the systems dynamics
dx = x^2-a*x;
V = x^2; 
dV = diff(V,x)*dx;

%setting up the initial and extreme rho values
rho_try = 0;            %current rho value up for optimization 
rho_extr = 1.1;         %maximum rho value of interesst  
rho_failed = rho_extr;  %smallest rho value for which prog. failed

%initiate the solution to the ROAprog
solution = solROAprog(-dV,rho_extr,'pos');

while ~(rho_try-solution.rho <= 0.01 && rho_try ~= 0) && ...
        ~(solution.rho_extr-solution.rho <= 0.01) && ... 
        ~(rho_failed-solution.rho <= 0.01)
    
    inequalities = [rho_try-V; a-a_l; a_u-a];
    deg = 2;
    k = 2;
    
    [sol,decisionDD] = kSprocedureProg(-dV,inequalities,k,deg);
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
        
        opt_Q0 = double(solution.sol.eval(blkdiag(decisionDD{:})));
                
        [DSOSfeasibility,~] = isDSOS(opt_Q0);
    end
else
    warning(['Increase degree or relaxation until origin is certified'...
                                                  ' to be stable.'])
    disp(['Non-linear dynamics are not certified'...
                                    ' to be stable at the origin!'])
end

disp(['the estrimated ROA corresponds to rho = ',...
    num2str(solution.rho),'.'])
%plottingV(solution.rho);
%plottingdV(solution.rho);
