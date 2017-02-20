close all; clear all; clc;

addpath(['C:\Users\fisch\OneDrive\Studies\Master Thesis\Code\'...
    'Thesis\Examples\example1\uncertainLineSearch\util'])

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
evalProblems = [0];

%% option 0 (change line search method againt default problem)
if any(evalProblems == 0)
    options.lineSearchMethod = 'step';
    options.lineSearchMethodOptions = 'determined';
    options.methodOptions.deg = 4; 
    options.objective = '0'; 
    options.feasibilityTest = 'numerical';
    params.FeasibilityTol = 1E-6; options.solverOptions = params;
   
    problem_counter = 0;
    %preloop assignment
    loop_counter = 00001; %read 0 0001
    options.rho = [0 0.001]
    for i=1:1000
        subMain(example1,options,loop_counter)
        options.rho = options.rho+0.001;
        loop_counter = loop_counter+1;
    end
    
    %preloop assignment
    loop_counter = 00001; %read 0 0001
    solutions(1:1000) = cell(1000,1);
    evaluation_total = 0; feasible_total = 0; infeasible_total = 0;
    slack_total = 0; DSOS_total = 0; eig_total = 0; DSOSeig_total = 0;
    times = zeros(1000,1);
    for i=1:1000
        matFile = strcat('option',num2str(loop_counter),'.mat');
        load(matFile);
        
        solutions{i} = solution_table;
        times(i) = time_table;
        evaluation_total = evaluation_total+evaluation;
        feasible_total = feasible_total+feasible;
        infeasible_total = infeasible_total+infeasible;
        slack_total = slack_total+slack;
        DSOS_total = DSOS_total+DSOS;
        eig_total = eig_total+eig;
        DSOSeig_total = DSOSeig_total+DSOSeig;
        loop_counter = loop_counter+1;
        
        delete(matFile);
    end
    
    solution_table = solutions;
    time_table = times;
    evaluation = evaluation_total;
    feasible = feasible_total;
    infeasible = infeasible_total;
    slack = slack_total;
    DSOS = DSOS_total;
    eig = eig_total;
    DSOSeig = DSOSeig_total;
    
    matFile = strcat('option',num2str(problem_counter),'numerical','.mat');
    save(matFile,'time_table','solution_table',...
    'evaluation','feasible','infeasible','slack','DSOS','eig','DSOSeig');
    
    options.lineSearchMethod = 'bisect';
    options.lineSearchMethodOptions = 'bisect';
end

%%
plotLine(problem_counter);















