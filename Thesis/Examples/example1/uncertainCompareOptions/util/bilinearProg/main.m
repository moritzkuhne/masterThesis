% with bisect/10 I found rho = 0.2528 for multiplier and 0.2545 for rho

%to do: fix warms starts. See example in gurobi p.600

close all; clear all; clc;

% initiate polynomials
x = msspoly('x',1);     %state variables 
a = msspoly('a',1);     %parameters
a_u = 1; a_l = 0.5;     %parameter bounds

% setting up the systems dynamics
dx = x^2-a*x;
inequalities = [a-a_l, a_u-a];

%intial conditions and options
V_initial = x^2;

optimal_rho_table = zeros(50,2);

rho_initial = 0;
rho_extr = 1.1;
rho = [rho_initial, rho_extr];

%setting gurobi options
params.method = 0; %default 0 (primal simplex)
params.FeasibilityTol = 1E-2; %default 1E-6

%setting options
options.solverOptions = params;
method = 'Sprocedure'; deg = 4; options.objective = '0';
    
for i=1:50
    
    [optimal_rho, optimal_V, solution] =...
        bilinearROAProg(V_initial,dx,x,inequalities,rho,method,deg,options)

    optimal_rho_table(i,:) = optimal_rho;
end

max(optimal_rho_table)