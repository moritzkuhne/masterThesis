% TO DO:   
%           test what happens if indet are called z (like monomials)

function [solution,objective,options] = kSprocedureProgX(poly,V,...
    inequalities,deg,options)
%SPROCEDUREPROG Sets up S-procedure programm in order to proof 
% positive semi-definiteness of poly on the domain constrainned by
% the set of inequalities. SOS/SDSOS/DSOS are raised to degree deg
%
%   returns solution and returns a cell with entries the DD matrixes
%   Detailed explanation goes here

    if nargin < 5
        options = [];
    end
    
    [indet,~,~] = decomp([poly; inequalities.']);

    %initiate program
    prog = spotsosprog;
    prog = prog.withIndeterminate(indet);
    
    % setting up DSOS polynomial multipliers
    coneOfPolynomials = coneWithSOS(inequalities,options.methodOptions.k);
    z = monomials(indet,0:deg);
    [prog,DSOSPoly,~] = newDSOSPoly(prog,z,...
        length(coneOfPolynomials));
    
    for i=1:length(coneOfPolynomials)
        
        if ~exist('S', 'var')
            S = DSOSPoly(i)*coneOfPolynomials(i);
        else
            S = S + DSOSPoly(i)*coneOfPolynomials(i);
        end
        
    end
    
    %Add slack to optimization problem to increase numerical robustness
    [prog,objective,slack,options] = objectiveROAProgDSOS(prog,V,options);
    
    % DSOS constraint
    prog = prog.withDSOS((poly-S-slack));
    
    %set solver and its options
    [solver,spotOptions,options] = solverOptionsPSDProg(options);

    % Solve program
    solution = prog.minimize(objective, solver, spotOptions);
    
end

