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
                Qset = evalMultipliers(sol);
                [feasibility,violation] = isDSOS(blkdiag(Qset{:}));
           else
               violation = 'none';
           end
    end
    
else
    
    feasibility = false;
    violation = ('Infeasible Primal Problem');

end

end

