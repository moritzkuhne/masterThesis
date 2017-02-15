close all; clear all; clc;

%% setting up the systems dynamics
disp('Setting up the dynamical system.')
% initiate polynomials
x = msspoly('x',1);     %state variables 
a = msspoly('a',1);     %parameters

dx = x^2-a*x;
V = x^2;
dV = diff(V,x)*dx;

a_u = 1; a_l = 0.5;     %parameter bounds
inequalities = [a-a_l, a_u-a];

%% setting options
disp('Setting up the options for ROAprog.')

options.lineSearchMethod = 'bisect';
options.lineSearchMethodOptions = 'bisect'; %this line does not do anything yet
options.objective = 'Lyap'; 
options.feasibilityTest = 'analytical';

%options.objective = '0'; 
%options.feasibilityTest = 'numerical';

%setting solver options
options.solver = @spot_gurobi;
params.method = 0; %default 0 (primal simplex)
params.FeasibilityTol = 1E-2; %default 1E-6
params.outputFlag = 0;
options.solverOptions = params;

method = @SprocedureProg; deg = 4; 
%method = @kSprocedureProg; deg = 4; options.methodOptions.k = 2;
%method = @PsatzProg; deg = 4; 

%% run ROAprog
disp('Running the ROAprog.')
[solution,options] = ROAProg(dV,V,inequalities,method,deg,options);
disp('The estimated region of attraction corresponds to rho = '); solution.rho