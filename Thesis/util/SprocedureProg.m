% TO DO:    add possibility to switch between multipliers
%           add possibility to chose obj. function
%           add possibility to pass solver options
%           test what happens if indet are called z (like monomials)

function [solution,Qset] = SprocedureProg(poly,inequalities,deg)
%SPROCEDUREPROG Sets up S-procedure programm in order to proof 
% positive semi-definiteness of poly on the domain constrainned by
% the set of inequalities. SOS/SDSOS/DSOS are raised to degree deg
%
%   returns solution and returns a cell with entries the DD matrixes
%   Detailed explanation goes here

    [indet,~,~] = decomp(poly);
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
    
    % options
    options = spot_sdp_default_options();
    % Solve program
    solution = prog.minimize(...
        trace(blkdiag(Qset{:})-eye(length(Qset)*length(z))),...
        @spot_gurobi, options); 
    
end

