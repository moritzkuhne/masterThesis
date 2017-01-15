% TO DO:    add possibility to switch between multipliers
%           add possibility to chose obj. function
%           add possibility to pass solver options
%           test what happens if indet are called z (like monomials)

function [solution,Qset] = kSprocedureProg(poly,inequalities,...
    deg,options)
%SPROCEDUREPROG Sets up S-procedure programm in order to proof 
% positive semi-definiteness of poly on the domain constrainned by
% the set of inequalities. SOS/SDSOS/DSOS are raised to degree deg
%
%   returns solution and returns a cell with entries the DD matrixes
%   Detailed explanation goes here
    
    [indet,~,~] = decomp(poly);
    coneOfPolynomials = coneWithSOS(inequalities,options.k);
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
    
    % DSOS constraint
    prog = prog.withDSOS((poly-S));
    
    % options
    spotOptions = spot_sdp_default_options();
    % Solve program
    solution = prog.minimize(...
        trace(blkdiag(Qset{:})-eye(length(Qset)*length(z))),...
        @spot_gurobi, spotOptions); 
    
end

