% to do:    PASS rho vecotrs to program
%           this function works so far only for psatz and k-s-procedure!
%           we need to handle vector of decsion variable instead of set for
%           handelman representation!

function [solution,options] = ROAFAILUREProg(system,options)
%ROAPROG This function sets-up and solves estimatie ROA optimization prob. 
%   Detailed explanation goes here
global evaluation feasible infeasible slack DSOS eig DSOSeig

%initiate the solution to the ROAprog
solution = solROAprog(system,options);

V = system.V;
dV = diff(system.V,system.states)*system.dx;
inequalities = system.inequCon;


%preloop assinments
terminate = false;
rho_failed = solution.rho_extr;
while ~terminate

    % step 1
    [rho_try,options] = fixRho(solution,rho_failed,options);
    
    % step 2
    [method,deg,options] = methodOptionsROAProg(options);
    [sol,objective,options] = method(-dV,system,[(rho_try-V),inequalities],deg,options);
    
    % step 3
    [feasibility,violation,options] = ...
        isPSDprogFeasible(sol,objective,options);

    switch violation
        case 'Infeasible Primal Problem'
            infeasible = infeasible+1;
        case 'objective'
            slack = slack+1;
        case 'DSOS'
            DSOS = DSOS+1;
            feasible = feasible+1; 
            save('SOS.mat','sol');
        case 'eigenvalues' %this should never happen! keep it for debugging
            eig = eig+1;
        case 'DSOS, eigenvalues'
            DSOSeig = DSOSeig+1;
        case 'none'
            feasible = feasible+1;     
    end
    
    [terminate,options] = isTerminate(solution,rho_try,rho_failed,options);
    
    if feasibility
        solution.rho = rho_try;
        solution.sol = sol;
        solution.options = options;
    else
        rho_failed = rho_try;
    end
    evaluation = evaluation+1;
end

end