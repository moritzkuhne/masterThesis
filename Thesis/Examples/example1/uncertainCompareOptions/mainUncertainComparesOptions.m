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
options.rho = [0 1];
options.lineSearchMethod = 'bisect';
options.lineSearchMethodOptions = 'bisect'; %this line does not do anything yet

%setting solver options
options.solver = @spot_gurobi;
params.method = 0; %default 0 (primal simplex)
params.outputFlag = 0;

problem_counter = [];
evalProblems = [10];


%% option 0 (Using SeDuMi with settings from option 1)
if any(evalProblems == 0)
    options.solver = @spot_sedumi;
    options.methodOptions.deg = 4; 
    options.objective = '0'; 
    options.feasibilityTest = 'analytical';
    params.FeasibilityTol = 1E-6; options.solverOptions = params;

    problem_counter = 0;
    subMain(example1,options,problem_counter)

    options.solver = @spot_gurobi;
end

%% option 1 (default problem)
if any(evalProblems == 1)
    options.methodOptions.deg = 4; 
    options.objective = 'Lyap'; 
    options.feasibilityTest = 'analytical';
    params.FeasibilityTol = 1E-6; options.solverOptions = params;

    problem_counter = 1;
    subMain(example1,options,problem_counter)
end

%% option 2 (change of feasibilityTest against default problem)
if any(evalProblems == 2)
    options.methodOptions.deg = 4; 
    options.objective = 'Lyap'; 
    options.feasibilityTest = 'numerical';
    params.FeasibilityTol = 1E-6; options.solverOptions = params;

    problem_counter = 2;
    subMain(example1,options,problem_counter)
end

%% option 3 (change of objective against default problem)
if any(evalProblems == 3)
    options.methodOptions.deg = 4; 
    options.objective = '0'; 
    options.feasibilityTest = 'analytical';
    params.FeasibilityTol = 1E-6; options.solverOptions = params;

    problem_counter = 3;
    subMain(example1,options,problem_counter)
end

%% option 4 (change of feasibilityTol against default problem)
if any(evalProblems == 4)
    options.methodOptions.deg = 4; 
    options.objective = 'Lyap'; 
    options.feasibilityTest = 'analytical';
    params.FeasibilityTol = 1E-2; options.solverOptions = params;

    problem_counter = 4;
    subMain(example1,options,problem_counter)
end

%% option 5 (change of feasibilityTol against default problem)
if any(evalProblems == 5)
    options.methodOptions.deg = 4; 
    options.objective = 'Lyap'; 
    options.feasibilityTest = 'analytical';
    params.FeasibilityTol = 1E-9; options.solverOptions = params;

    problem_counter = 5;
    subMain(example1,options,problem_counter)
end

%% option 6 (change of degree against default problem)
if any(evalProblems == 6)
    options.methodOptions.deg = 3; 
    options.objective = 'Lyap'; 
    options.feasibilityTest = 'analytical';
    params.FeasibilityTol = 1E-6; options.solverOptions = params;

    problem_counter = 6;
    subMain(example1,options,problem_counter)
end

%% option 7 (change of degree against default problem)
if any(evalProblems == 7)
    options.methodOptions.deg = 5; 
    options.objective = 'Lyap'; 
    options.feasibilityTest = 'analytical';
    params.FeasibilityTol = 1E-6; options.solverOptions = params;

    problem_counter = 7;
    subMain(example1,options,problem_counter)
end

%% option 8 (change of solver method againt default problem)
if any(evalProblems == 8)
    params.method = 2; %barrier (aka interior point)
    options.methodOptions.deg = 4; 
    options.objective = 'Lyap'; 
    options.feasibilityTest = 'analytical';
    params.FeasibilityTol = 1E-6; options.solverOptions = params;

    problem_counter = 8;
    subMain(example1,options,problem_counter)
    
    params.method = 0; %default 0 (primal simplex)
end

%% option 9 (change of solver method and objective againt default problem)
if any(evalProblems == 9)
    params.method = 2; %barrier (aka interior point)
    options.methodOptions.deg = 4; 
    options.objective = '0'; 
    options.feasibilityTest = 'analytical';
    params.FeasibilityTol = 1E-6; options.solverOptions = params;

    problem_counter = 9;
    subMain(example1,options,problem_counter)
    
    params.method = 0; %default 0 (primal simplex)
end

















