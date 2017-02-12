% TO DO:    add possibility to switch between multipliers
%           add possibility to chose obj. function
%           add possibility to pass solver options
%           add additional argout which specifies the decision var.
%           test what happens if indet are called z (like monomials)
%           test weather inequalities indet. match poly indet. 

function [solution,lambda] = HandelmanProg(poly,inequalities,...
    deg,options)
%SPROCEDUREPROG Sets up S-procedure programm in order to proof 
% positive semi-definiteness of poly on the domain constrainned by
% the set of inequalities. SOS/SDSOS/DSOS are raised to degree deg
%
%   returns solution and returns a cell with entries the DD matrixes
%   Detailed explanation goes here

    if nargin < 4
        options = [];
    end

    [indet,~,~] = decomp([poly; inequalities.']);
    mMonoid = multiplicativeMonoid(inequalities, deg);
    
    %initiate program
    prog = spotsosprog;
    prog = prog.withIndeterminate(indet);
    
    % add nonlinear multipliers
    [prog,lambda] = prog.newPos(length(mMonoid));
    prog = prog.withPolyEqs(poly-lambda.'*mMonoid);
    
    %set solver and its options
    [solver,spotOptions] = solverOptionsPSDProg(options);
    
    %define objective function
    if isfield(options,'objective')
        objective = objectiveROAProgScalar(options.objective,lambda);
    else
        objective = 0;
    end
    
    % Solve program
    solution = prog.minimize(objective, solver, spotOptions); 
    
end

