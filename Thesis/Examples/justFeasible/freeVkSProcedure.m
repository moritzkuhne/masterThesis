%% example 4.1 in Sankaranarayanan2013
function [solution,feasibility,V] = freeVkSProcedure(options)
disp('redo example 4.1 Sankaranarayanan2013 ')

%% setting up the system
disp('Setting up the system.')

x= msspoly('x',2);

dx = [-x(1)^3+x(2);
     -x(1)-x(2)];
bound_u = 100; bound_l = 100;
inequalities = [bound_u-x(1),x(1)-bound_l,bound_u-x(2),x(2)-bound_l];

system = dynamicalSystem(dx,inequalities,[],x,[],[]);

deg_dV_multipliers = options.methodOptions.deg;

%% setting options for BoxProg
disp('Setting options for BoxProg')
%setting options for both of them, than individuals

options.lineSearchMethod = 'bisect';
options.lineSearchMethodOptions = 'random'; %this line does not do anything yet
options.objective = '0'; 
options.feasibilityTest = 'analytical';

%setting solver options
options.solver = @spot_gurobi;
params.method = 2; %default 0 (primal simplex)
params.FeasibilityTol = 1E-6; %default 1E-6
% params.outputFlag = 0;
options.solverOptions = params;

%% initiate program
disp('Initiate Program')
prog = spotsosprog;
indet = x; prog = prog.withIndeterminate(indet);

%% DSOS problem for V
% initialize V as freePoly

% deg_V_multipliers = 1;
% 
% % setting up DSOS polynomial multipliers for V
% coneOfPolynomials = coneWithSOS(inequalities,options.methodOptions.k);
% z = monomials(indet,0:deg_V_multipliers);
% [prog,DSOSPoly_V,~] = newDSOSPoly(prog,z,...
%     length(coneOfPolynomials));
% 
% for i=1:length(coneOfPolynomials)
% 
%     if ~exist('S_V', 'var')
%         S_V = DSOSPoly_V(i)*coneOfPolynomials(i);
%     else
%         S_V = S_V + DSOSPoly_V(i)*coneOfPolynomials(i);
%     end
% 
% end

deg_V = 2;
z_V = monomials(indet,1:deg_V);
[prog,V] = newFreePoly(prog,z_V,1);
% DSOS constraint
prog = prog.withDSOS((V-indet.'*indet));


%% DSOS problem for dV
% calculating dV
dV = diff(V,x)*dx;
% setting up DSOS polynomial multipliers for dV
coneOfPolynomials = coneWithSOS(inequalities,options.methodOptions.k);
z = monomials(indet,0:options.methodOptions.deg);
[prog,DSOSPoly_dV,~] = newDSOSPoly(prog,z,...
    length(coneOfPolynomials));

for i=1:length(coneOfPolynomials)

    if ~exist('S_dV', 'var')
        S_dV = DSOSPoly_dV(i)*coneOfPolynomials(i);
    else
        S_dV = S_dV + DSOSPoly_dV(i)*coneOfPolynomials(i);
    end

end

%Add slack to optimization problem to increase numerical robustness
[prog,objective,slack,options] = objectiveROAProgDSOS(prog,system,options);

% DSOS constraint
prog = prog.withDSOS((-dV-S_dV-slack));

%% solving Program
disp('Solving Program.')

%set solver and its options
[solver,spotOptions,options] = solverOptionsPSDProg(options);

% Solve program
solution = prog.minimize(objective, solver, spotOptions);

%% eval Solutions

if solution.isPrimalFeasible()
    if double(solution.eval(objective)) >= 0
        Qset = evalMultipliers(solution);
        [feasibility,~] = isDSOS(blkdiag(Qset{:}));
        V = solution.eval(V);
    else
        feasibility = false;
        V = [];
    end
else
    feasibility = false;
    V = [];
end


end