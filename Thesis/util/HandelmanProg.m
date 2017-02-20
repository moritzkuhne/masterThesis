% TO DO:   

function [solution,objective,options] = HandelmanProg(poly,system,inequalities,deg,options)
%HANDELMANPROG Sets up S-procedure programm in order to proof 
% positive semi-definiteness of poly on the domain constrainned by
% the set of inequalities. SOS/SDSOS/DSOS are raised to degree deg
%
%   returns solution and returns a cell with entries the DD matrixes
%   Detailed explanation goes here

    if nargin < 5
        options = [];
    end

    [indet,~,~] = decomp([poly; inequalities.']);
    mMonoid = multiplicativeMonoid(inequalities, deg);
    
    %initiate program
    prog = spotsosprog;
    prog = prog.withIndeterminate(indet);
    
    %Add slack to optimization problem to increase numerical robustness
    [prog,objective,slack,options] = objectiveROAProgScalar(prog,system,options);
    
    % add nonlinear multipliers
    [prog,lambda] = prog.newPos(length(mMonoid));
    prog = prog.withPolyEqs(poly-lambda.'*mMonoid-slack);
    prog = prog.withDSOS(poly-lambda.'*mMonoid);
        
    %set solver and its options
    [solver,spotOptions,options] = solverOptionsPSDProg(options);
    
    % Solve program
    solution = prog.minimize(objective, solver, spotOptions); 
    
end

