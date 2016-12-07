% TO DO:    add possibility to pass solver options
%           add possibility to change degree of g, or make it auto dectect!
%           add detection to which power of g is used
%           add possibility to chose obj. function
%           add possibility to switch between multipliers



function [solution,decisionVar] = PsatzProg(poly,inequalities,deg)
%PsatzProg Sets up Positivstllensatz programm in order to proof 
% positive semi-definiteness of poly on the domain constrainned by
% the set of inequalities. SOS/SDSOS/DSOS are raised to degree deg
%
%   returns solution and returns a cell with entries the DD matrixes
%   Detailed explanation goes here

    [indet,~,~] = decomp(poly);
    coneOfPolynomials = coneWithSOS([-poly;inequalities]);
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
    
    % options
    options = spot_sdp_default_options();
    % Solve program
    solution = prog.minimize(...
        trace(blkdiag(Qset{:})-eye(length(Qset)*length(z))),...
        @spot_gurobi, options); 
    
%     decisionVar = cell(2,1);
%     decisionVar{1} = Qset;
%     decisionVar{2} = lambda;

      decisionVar = Qset;  

end

