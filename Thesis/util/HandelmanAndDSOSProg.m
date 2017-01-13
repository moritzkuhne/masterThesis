% TO DO:    add possibility to switch between multipliers
%           add possibility to chose obj. function
%           add possibility to pass solver options
%           add additional argout which specifies the decision var.
%           test what happens if indet are called z (like monomials)
%           test weather inequalities indet. match poly indet. 

function [solution,DD] = HandelmanAndDSOSProg(poly,inequalities,deg)
%HandelmanAndDSOS Sets up Handelman programm constrained to DSOS 
% in order to proof 
% positive semi-definiteness of poly on the domain constrainned by
% the set of inequalities. SOS/SDSOS/DSOS are raised to degree deg
%
%   returns solution and returns a cell with entries the DD matrixes
%   Detailed explanation goes here

    [indet,~,~] = decomp(poly);
    
    %initiate program
    prog = spotsosprog;
    prog = prog.withIndeterminate(indet);
    z = monomials(indet,0:deg);
    
    % add nonlinear multipliers
    [prog,DD] = prog.newDD(length(z));
    s_rho = z.'*DD*z;
    prog = prog.withDSOS(poly-s_rho*inequalities);
    
    % options
    options = spot_sdp_default_options();
    % Solve program
    solution = prog.minimize(0,@spot_gurobi, options); 
    
end

