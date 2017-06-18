function [solution,objective,options] = HandelmanAndDSOSProg(poly,...
    system,inequalities,equalities,deg,~,options)
%HandelmanAndDSOS Sets up Handelman programm constrained to DSOS 
% in order to proof 
% positive semi-definiteness of poly on the domain constrainned by
% the set of inequalities. SOS/SDSOS/DSOS are raised to degree deg
%
%   returns solution and returns a cell with entries the DD matrixes
%   Detailed explanation goes here

    if nargin < 5
        options = [];
    end

    [indet,~,~] = decomp([poly; inequalities.'; equalities]);
    mMonoid = multiplicativeMonoid(inequalities,deg);
    
    %initiate program
    prog = spotsosprog;
    prog = prog.withIndeterminate(indet);
    
    %Add slack to optimization problem to increase numerical robustness
    [prog,objective,slack,options] = objectiveROAProgScalar(prog,system,options);
    
    % add nonlinear multipliers
    [prog,lambda] = prog.newPos(length(mMonoid));
    
    % add multipliers for equalities
    if ~length(equalities) == 0
        [prog,p] = prog.newFree(length(equalities));
        P = p*equalities;
    else
        P = 0;
    end
        
    prog = prog.withDSOS(poly-lambda.'*mMonoid-P-slack);
        
    %set solver and its options
    [solver,spotOptions,options] = solverOptionsPSDProg(options);
    
    % Solve program
    solution = prog.minimize(objective, solver, spotOptions); 
    
end

