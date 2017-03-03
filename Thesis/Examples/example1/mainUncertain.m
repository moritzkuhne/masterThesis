close all; clear all; clc;

%% setting up the systems dynamics
disp('Setting up the dynamical system.')
% initiate polynomials
x = msspoly('x',1);     %state variables 
a = msspoly('a',1);     %parameters

dx = x^2-a*x;
a_u = 1; a_l = 0.5;     %parameter bounds
inequalities = [a-a_l, a_u-a];
equalities = [];

V = x^2;

system = dynamicalSystem(dx,inequalities,equalities,x,a,V);

%% setting options
disp('Setting the options for ROAprog.')

options.rho = [0 1];
options.lineSearchMethod = 'bisect';
options.lineSearchMethodOptions = 'random'; %this line does not do anything yet
options.objective = 'Lyap'; 
options.feasibilityTest = 'analytical';

%options.objective = '0'; 
%options.feasibilityTest = 'numerical';

%setting solver options
options.solver = @spot_gurobi;
params.method = 0; %default 0 (primal simplex)
params.FeasibilityTol = 1E-6; %default 1E-6
params.outputFlag = 0;
options.solverOptions = params;

options.methodOptions.deg = 4;
options.methodOptions.degP = 4;
options.methodOptions.k = 2;

options.method = @SprocedureProg; 
% options.method = @kSprocedureProg; 
% options.method = @PsatzProg; 

%% run ROAprog
disp('Running the ROAprog.')
[solution,options] = ROAProg(system,options);
disp('The estimated region of attraction corresponds to rho = '); solution.rho