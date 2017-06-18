% TO DO:   
%           test what happens if indet are called z (like monomials)

function [prog,options] = kSprocedureConstraint(prog,...
    poly,inequalities,equalities,PD,slack,options)
%SPROCEDUREPROG Sets up S-procedure programm in order to proof 
% positive semi-definiteness of poly on the domain constrainned by
% the set of inequalities. SOS/SDSOS/DSOS are raised to degree deg
%
%   returns solution and returns a cell with entries the DD matrixes
%   Detailed explanation goes here
    
    indet = prog.indeterminates;
    
    % setting up DSOS polynomial multiplierr for inequalities
    if ~length(inequalities) == 0
        coneOfPolynomials = coneWithSOS(inequalities,options.k);
        zS = monomials(indet,0:options.degS);
        [prog,DSOSPoly,~] = newDSOSPoly(prog,zS,...
            length(coneOfPolynomials));    
        S = DSOSPoly.'*coneOfPolynomials;
    else 
        S = 0;
    end
    
    %set up free multipliers for equalities
    if ~length(equalities) == 0
        zP = monomials(indet,0:options.degP);
        [prog,FreePoly,~] = newFreePoly(prog,zP,length(equalities));
        P = FreePoly.'*equalities;
    else
        P = 0;
    end
        
    %DSOS constraint
    prog = prog.withDSOS((poly-S-P-PD-slack));
    
end

