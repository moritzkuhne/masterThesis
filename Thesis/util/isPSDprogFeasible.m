function [feasibility,violation] = isPSDprogFeasible(sol,decisionVar)
%ISPSDPROGFEASIBLE 
%   Detailed explanation goes here

if sol.isPrimalFeasible()
    
    if ~isempty(sol.gramMatrices) 
        Q = double(sol.eval(sol.gramMatrices{1}));
    else
        Q = [];
    end
    
    if length(decisionVar)>0
        for i=1:length(decisionVar)
            opt_Qset{i} = double(sol.eval(decisionVar{i}));
        end
    end
    
    [feasibility,violation] = isDSOS(blkdiag(Q,opt_Qset{:})); %we...
    % may test Q and decision variables in one step as putting them on the
    % diagonal preserves the structure and does not affact the stability of
    % circle theorem nor eig() in Matlab. Matlab will break it into blocks
    
else
    feasibility = false;
    violation = ('Infeasible Primal Problem');

end

end

