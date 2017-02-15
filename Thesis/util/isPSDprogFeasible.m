function [feasibility,violation,options] =...
    isPSDprogFeasible(sol,objective,options)
%ISPSDPROGFEASIBLE 
%   Detailed explanation goes here

if isfield(options,'feasibilityTest')
    if ~(strcmp(options.feasibilityTest,'numerical') ||...
            strcmp(options.feasibilityTest,'analytical'))
        error('Feasibility test is not supported.')
    else
        feasibilityTest = options.feasibilityTest;
    end
else
    feasibilityTest = 'numerical';
    options.feasibilityTest = feasibilityTest;
end

if sol.isPrimalFeasible()
    
    objective_opt = double(sol.eval(objective));
    if ~(objective_opt<=0)
        
        feasibility = false;
        violation = 'objective';
        
    else
        feasibility = true;
        
           if strcmp(feasibilityTest,'analytical')
            
                if ~isempty(sol.gramMatrices) 
                    for i=1:length(sol.gramMatrices)
                        Qset{i} = double(sol.eval(sol.gramMatrices{i}));
                    end
                else
                    Qset = [];
                end

                [feasibility,violation] = isDSOS(blkdiag(Qset{:}));
           else
               violation = [];
           end
    end
    
else
    
    feasibility = false;
    violation = ('Infeasible Primal Problem');

end

end

