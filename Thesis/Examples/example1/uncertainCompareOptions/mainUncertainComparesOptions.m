
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

options.method = @SprocedureProg;
options.lineSearchMethod = 'bisect';
options.lineSearchMethodOptions = 'bisect'; %this line does not do anything yet

%setting solver options
options.solver = @spot_gurobi;
params.method = 0; %default 0 (primal simplex)
params.outputFlag = 0;

%% objective Lyap vs. 0

options.methodOptions = struct(); options.methodOptions.deg = 4; 
options.objective = 'Lyap'; 
options.feasibilityTest = 'analytical';
params.FeasibilityTol = 1E-6; %default 1E-6
options.solverOptions = params;

i_end = 2;
rho_table = zeros(i_end,1);
solution_table(1:i_end) = cell(i_end,1);
for i=1:i_end %we expect each run takes log2(1000) ~~ 10 iterations in total we want 100
    i
    [solution_table{i},~] = ROAProg(dV,V,inequalities,options);
end







% I WANT RHO, #EVALUATIONS, #violations(infeasible, objective, DSOS, EIG) #TICTOC



%%





%from here on other obj

deg = 4; 
options.objective = '0'; 
options.feasibilityTest = 'analytical';
params.FeasibilityTol = 1E-6; %default 1E-6
options.solverOptions = params;

THE SAME AS IN THE OTHER OBJECTIVE TEST.

















%% 

% options.objective = '0'; 
% options.feasibilityTest = 'numerical';







%%
% i_upper = 100;
% rho_table = zeros(i_upper,1);
% tic
% for i=1:i_upper
%     [solution,decisionVar] = ROAProg(dV,V,inequalities,method,deg,options);
%     %rho_certified = evalMethod(solution,decisionVar);
%     rho_table(i) = solution.rho;
% end
% time = toc




