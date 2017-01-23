%to do: fix warms starts. See example in gurobi p.600

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

method = 'Sprocedure'; deg = 3; options.objective = '0';
%%

function [optimal_rho, solution] = bilinearROAProg(dV,V,inequalities,rho,method,deg,options)
%BILINEARROAPROG Its the start for an Bilinear Prog
%   Detailed explanation goes here


while convergence == false

[optimal_multiplier_rho,optimal_multiplier,multipler_solution] = ROAMultiplierProg(dV,V,inequalities,rho,method,deg,options);

if method == 'SProcedure'
    [optimal_rho_rho,rho_solution] = ROARhoProg(-dV,V,inequalities,method,deg,optimal_multiplier,options);
else
    convergens = true;
end

if optimal_rho_rho-optimal_multiplier_rho >= 0.01
    convergence = true;
end

solution = [multipler_solution; rho_solution];

end

