% TO DO:    add possibility to pass solver options
%           add possibility to change degree of g, or make it auto dectect!
%           add detection to which power of g is used
%           add possibility to chose obj. function
%           add possibility to switch between multipliers



function [solution,Qset] = PsatzProg(poly,inequalities,...
    deg,options)
%PsatzProg Sets up Positivstllensatz programm in order to proof 
% positive semi-definiteness of poly on the domain constrainned by
% the set of inequalities. SOS/SDSOS/DSOS are raised to degree deg
%
%   returns solution and returns a cell with entries the DD matrixes
%   Detailed explanation goes here
    
    if nargin < 4
        options = [];
    end
    
    [indet,~,~] = decomp([poly; inequalities.']);
    coneOfPolynomials = coneWithSOS([-poly,inequalities]);
    z = monomials(indet,0:deg);
    
    %initiate program
    prog = spotsosprog;
    prog = prog.withIndeterminate(indet);
    
    % setting up DSOS polynomial multipliers
    [prog,Qset] = prog.newDDSet(length(z),length(coneOfPolynomials));
    
    for i=1:length(coneOfPolynomials)
        
        if ~exist('S', 'var')
            S = (z.'*Qset{i}*z)*coneOfPolynomials(i);
        else
            S = S + (z.'*Qset{i}*z)*coneOfPolynomials(i);
        end
        
    end
    
    % adding even powers of g aka poly^2, poly^4....
    %[prog,lambda] = prog.newPos(1);
    
    % DSOS constraint
    %prog = prog.withDSOS((-S-lambda*poly^2));
    prog = prog.withDSOS((-S-poly^2));
    
    %set solver options
    spotOptions = spot_sdp_default_options();
    if isfield(options,'solverOptions')
        spotOptions.solver_options = options.solverOptions;
    else
        spotOptions.solver_options = struct();
    end
    
    %define objective function
    if isfield(options,'objective')
        objective = objectiveROAProgDSOS(options.objective,Qset);
    else
        objective = 0;
    end
    
    % Solve program
    solution = prog.minimize(objective, @spot_gurobi, spotOptions);
    
end

