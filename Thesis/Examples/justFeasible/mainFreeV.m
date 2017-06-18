% reporting: the problem is JUST feasible, i.e. objective needs to be 0
%           for the same reason KSprocedure and PSatz strugle!  
%           on the other hand, deg = 0 does an awesome job!
%           Handelman fails, but HandelmanDSOS sucesses (of course it does)

% example 4.1 in Sankaranarayanan2013
close all; clear all; clc;
     
%% iterate through options
disp('Iterate over options')

global fastest_option fastest_time

fastest_option = '';
fastest_time = 100000000;

%%

for method_counter = 5:7 %up to 7
    for method_options_counter = 0:6  %8 does not work any more
       for solver_method_counter = 1:2
           for FeasibilityTol_counter =1:3 %1:3
               for objective_counter = 1:2 %1:3
               
                    counter.method = method_counter;
                    counter.method_options = method_options_counter;
                    counter.solver_method = solver_method_counter;
                    counter.FeasibilityTol = FeasibilityTol_counter;
                    counter.objective = objective_counter;
                    counter
                    
                    [options,~] = optionsByCounter(counter);
                    subMainFreeV(options,counter) 

                    extractResultsFreeV(counter);

               end
           end
       end     
    end
end
% %% iterate through HandelmanDSOS and Handelman
% 
% for method_counter = 6:7
%     for method_options_counter = 0:6  %7 does not work any more
%        for solver_method_counter = 1:2
%            for FeasibilityTol_counter =1:3 %1:3
%                for objective_counter = 1:2 %1:3
%                
%                     counter.method = method_counter;
%                     counter.method_options = method_options_counter;
%                     counter.solver_method = solver_method_counter;
%                     counter.FeasibilityTol = FeasibilityTol_counter;
%                     counter.objective = objective_counter;
%                     counter
% %                     
% %                     [options,~] = optionsByCounter(counter);
% %                     subMainFreeV(options,counter) 
% 
%                     extractResultsFreeV(counter);
% 
%                end
%            end
%        end     
%     end
% end
    
    