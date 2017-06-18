close all; clear all; clc;

addpath(['C:\Users\fisch\OneDrive\Studies\Master Thesis\Code\'...
     'Thesis\Examples\example1\uncertainCompareOptions\util'])

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

%%iterate through options
disp('Iterate over options')

for method_counter = 1:1
    for method_options_counter = 4:8
       for solver_method_counter = 1:2
           for FeasibilityTol_counter =2:2 %1:3
               for objective_counter = 2:2 %1:3
               
                    counter.method = method_counter;
                    counter.method_options = method_options_counter;
                    counter.solver_method = solver_method_counter;
                    counter.FeasibilityTol = FeasibilityTol_counter;
                    counter.objective = objective_counter;
                    
                    [options,~] = optionsByCounter(counter);

                    subMain(system,options,counter)          
               end
           end
       end     
    end
end
