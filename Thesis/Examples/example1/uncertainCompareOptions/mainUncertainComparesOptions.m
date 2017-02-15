close all; clear all; clc;

addpath(['C:\Users\fisch\OneDrive\Studies\Master Thesis\Code\'...
    'Thesis\Examples\example1\uncertainCompareOptions\util'])

% initiate polynomials
x = msspoly('x',1);     %state variables 
a = msspoly('a',1);     %parameters
a_u = 1; a_l = 0.5;     %parameter bounds

% setting up the systems dynamics
dx = x^2-a*x;
V = x^2;
dV = diff(V,x)*dx;
inequalities = [a-a_l, a_u-a];

example1.V = V; example1.dV = dV; example1.inequalities = inequalities;

options.method = @SprocedureProg;
options.lineSearchMethod = 'bisect';
options.lineSearchMethodOptions = 'bisect'; %this line does not do anything yet

%setting solver options
options.solver = @spot_gurobi;
params.method = 0; %default 0 (primal simplex)
params.outputFlag = 0;

problem_counter = 0;

%% option 1 (default problem)
options.methodOptions.deg = 4; 
options.objective = 'Lyap'; 
options.feasibilityTest = 'analytical';
params.FeasibilityTol = 1E-6; options.solverOptions = params;

problem_counter = problem_counter+1;
subMain(example1,options,problem_counter)

%% option 2 (change of feasibilityTest against default problem)
options.methodOptions.deg = 4; 
options.objective = 'Lyap'; 
options.feasibilityTest = 'numerical';
params.FeasibilityTol = 1E-6; options.solverOptions = params;

problem_counter = problem_counter+1;
subMain(example1,options,problem_counter)

%% option 3 (change of objective against default problem)
options.methodOptions.deg = 4; 
options.objective = '0'; 
options.feasibilityTest = 'analytical';
params.FeasibilityTol = 1E-6; options.solverOptions = params;

problem_counter = problem_counter+1;
subMain(example1,options,problem_counter)

%% option 4 (change of feasibilityTol against default problem)
options.methodOptions.deg = 4; 
options.objective = 'Lyap'; 
options.feasibilityTest = 'analytical';
params.FeasibilityTol = 1E-2; options.solverOptions = params;

problem_counter = problem_counter+1;
subMain(example1,options,problem_counter)

%% option 5 (change of feasibilityTol against default problem)
options.methodOptions.deg = 4; 
options.objective = 'Lyap'; 
options.feasibilityTest = 'analytical';
params.FeasibilityTol = 1E-9; options.solverOptions = params;

problem_counter = problem_counter+1;
subMain(example1,options,problem_counter)

%% option 6 (change of degree against default problem)
options.methodOptions.deg = 3; 
options.objective = 'Lyap'; 
options.feasibilityTest = 'analytical';
params.FeasibilityTol = 1E-6; options.solverOptions = params;

problem_counter = problem_counter+1;
subMain(example1,options,problem_counter)

%% option 7 (change of degree against default problem)
options.methodOptions.deg = 5; 
options.objective = 'Lyap'; 
options.feasibilityTest = 'analytical';
params.FeasibilityTol = 1E-6; options.solverOptions = params;

problem_counter = problem_counter+1;
subMain(example1,options,problem_counter)



















