% TO DO:    add possibility to switch between multipliers
%           add possibility to chose obj. function
%           add possibility to pass solver options
%           test what happens if indet are called z (like monomials)

function [solution,Qset] = SprocedureProg(poly,inequalities,deg,options)
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
    z = monomials(indet,0:deg);

    %initiate program
    prog = spotsosprog;
    prog = prog.withIndeterminate(indet);

    % setting up DSOS polynomial multipliers
    [prog,Qset] = prog.newDDSet(length(z),length(inequalities));

    for i=1:length(inequalities)

        if ~exist('S', 'var')
            S = (z.'*Qset{i}*z)*inequalities(i);
        else
            S = S + (z.'*Qset{i}*z)*inequalities(i);
        end

    end

    % DSOS constraint
    prog = prog.withDSOS((poly-S));

    %set solver and its options
    [solver,spotOptions] = solverOptionsPSDProg(options);

    %define objective function
    if isfield(options,'objective')
        objective = objectiveROAProgDSOS(options.objective,Qset);
    else
        objective = 0;
    end

    % Solve program
    solution = prog.minimize(objective, solver, spotOptions);
    
end

