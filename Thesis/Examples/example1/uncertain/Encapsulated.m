close all; clear all; clc;

% initiate polynomials
x = msspoly('x',1);     %state variables 
a = msspoly('a',1);     %parameters
a_u = 1; a_l = 0.5;     %parameter bounds

% setting up the systems dynamics
dx = x^2-a*x;
V = x^2;
dV = diff(V,x)*dx;

inequalities = [a-a_l, a_u-a];

rho_initial = 0;
rho_extr = 1.1;
rho = [rho_initial, rho_extr];

%setting gurobi options
params.method = 0; %default 0 (primal simplex)
params.FeasibilityTol = 1E-2; %default 1E-6

%setting options
options.solverOptions = params;
options.solver = @spot_gurobi;

% method = @PsatzProg;evalMethod = @evalROAProgDSOS; deg = 2; options.objective = '0';
% method = @kSprocedureProg;evalMethod = @evalROAProgDSOS; deg = 2; options.k = 2; options.objective = '0';
 method = @SprocedureProg;evalMethod = @evalROAProgDSOS; deg = 2; options.objective = '0';
% method = @HandelmanAndDSOSProg; evalMethod = @evalROAProgScalar; deg = 5; options.objective = '0';
% method = @HandelmanProg; evalMethod = @evalROAProgScalar; deg = 5; options.objective = '0';

[solution,decisionVar] = ROAProg(dV,V,inequalities,method,deg,options);
rho_certified = evalMethod(solution,decisionVar);

%%
% i_upper = 100;
% rho_table = zeros(i_upper,1);
% tic
% for i=1:i_upper
%     [solution,decisionVar] = ROAProgV2(dV,V,inequalities,method,deg,options);
%     %rho_certified = evalMethod(solution,decisionVar);
%     rho_table(i) = solution.rho;
% end
% time = toc




