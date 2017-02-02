% This example is on a linearized 1-DoF Pendulum with parameter 
% uncertainties. The dynamics are given by:
% [dx1 dx2]' = [0 1; -G -D][x1 x2]' with G and K constants due to 
% gravity, length, mass and damping

% initiate polynomials
x = msspoly('x',2);                             %state variables 
g = msspoly('g',1); d = msspoly('d',1);         %parameters

% setting up the systems dynamics
dx = [0 1; -g -d]*x;
V = 0.5*(g*x(1)^2 + x(2)^2);
dV = diff(V,x)*dx;

g_l = 0.01; d_l = 0.01;                         %parameter bounds
inequalities = [g-g_l, d-d_l];

rho_initial = 0;
rho_extr = 1.1;
rho = [rho_initial, rho_extr];

%%
%setting gurobi options
params.method = 0; %default 0 (primal simplex)
params.FeasibilityTol = 1E-2; %default 1E-6

%setting options
options.solverOptions = params;

method = 'Sprocedure'; deg = 3; options.objective = '0';

%%

[optimal_multiplier_rho,optimal_multiplier,multipler_solution] = ROAMultiplierProg(dV,V,inequalities,rho,method,deg,options);





