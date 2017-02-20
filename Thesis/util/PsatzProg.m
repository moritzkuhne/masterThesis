% TO DO:  
%           add possibility to change degree of g, or make it auto dectect!
%           add detection to which power of g is used

function [solution,objective,options] = PsatzProg(poly,system,inequalities,...
    deg,options)
%PsatzProg Sets up Positivstllensatz programm in order to proof 
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
    coneOfPolynomials = coneWithSOS([-poly,inequalities]);
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
    [prog,objective,slack,options] = objectiveROAProgDSOS(prog,system,options);
    
    prog = prog.withDSOS((-S-poly^2-slack));
    %prog = prog.withDSOS((-S-1-slack));
    
    %set solver and its options
    [solver,spotOptions,options] = solverOptionsPSDProg(options);

    % Solve program
    solution = prog.minimize(objective, solver, spotOptions);
    
end

