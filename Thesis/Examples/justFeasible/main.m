%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% main file for example 4.1 in Sankaranarayanan2013                      %
%                                                                        %
% by M. Fischer-Gundlach, Delft 2017                                     %
%                                                                        %
%                                                                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all; clear all; clc;

%%
disp('redo example 4.1 Sankaranarayanan2013 ')
x= msspoly('x',2);

dx = [-x(1)^3+x(2);
     -x(1)-x(2)];
bound_u = 100; bound_l = 100;
inequalities = [bound_u-x(1),x(1)-bound_l,bound_u-x(2),x(2)-bound_l];

V = x(1)^2+x(2)^2;

system = dynamicalSystem(dx,inequalities,[],x,[],V);
     
%% iterate through options
disp('Iterate over options')

for method_counter = 3:4 %up to 7
    for method_options_counter = 0:7  %8 does not work any more
       for solver_method_counter = 1:2
           for FeasibilityTol_counter =1:3 %1:3
               for objective_counter = 1:3 %1:3
               
                    counter.method = method_counter;
                    counter.method_options = method_options_counter;
                    counter.solver_method = solver_method_counter;
                    counter.FeasibilityTol = FeasibilityTol_counter;
                    counter.objective = objective_counter;
                    counter
                    
                    [options,~] = optionsByCounter(counter);
                    options.rho = [100*sqrt(2)-0.01 100*sqrt(2)];
                    options.lineSearchMethod = 'step';
                    options.lineSearchMethodOptions = 'determined'; 
                    subMain(system,options,counter) 

%                     extractResults(counter);

               end
           end
       end     
    end
end