close all; clear all; clc;

%% setting up the systems dynamics
disp('Setting up the dynamical system.')
% initiate polynomials
x = msspoly('x',1);     %state variables 
parameters = msspoly.empty;

dx = x^2-x;
inequalities = [];
equalities = [];

system = dynamicalSystem(dx,inequalities,equalities,x,parameters);


%% setting options
disp('Setting up the options for ROAprog.')

options.rho = [0 1.1];
options.lineSearchMethod = 'bisect';
options.lineSearchMethodOptions = 'random'; 
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

options.method = @SprocedureProg; options.methodOptions.deg = 4; 
%options.method = @kSprocedureProg; options.methodOptions.deg = 4; options.methodOptions.k = 2;
%options.method = @PsatzProg; options.methodOptions.deg = 4; 

%% run ROAprog
disp('Running the ROAprog.')
[solution,options] = ROAProg(system,options);
disp('The estimated region of attraction corresponds to rho = '); solution.rho