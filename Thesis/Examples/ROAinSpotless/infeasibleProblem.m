%% the problem reads as:
%                   
%   min tr(I-Q0)    (=1-v1+1-v2+....1-vn)
%   s.t. Q0 \in DD 
%
%  the solution is expected to look like: diagonal elements are inf
%  but the solution are finite and scale reciprocal with dim(Q0)
%  same happens when obj = tr(-Q0), it should be unbounded/dual infeasible
%

clear all; clc;

% initiate polynomials
x = msspoly('x',1);     %creates msspoly object   

    % DSOS program
    % Initialize program
    prog = spotsosprog;
    prog = prog.withIndeterminate(x);
    deg = 3;
    z = monomials(x,0:deg);
    
    [prog,Q0] = prog.newDD(deg+1); %constraining the DSOS multipliers
    
    % sedumi options
    options = spot_sdp_default_options();
    % Solve program
    %sol = prog.minimizeDSOS(trace(eye(deg+1)-Q0), @spot_sedumi, options);
    % Optimal value
    opt_dsos0 = double(sol.eval(Q0))
    trace(eye(deg+1)-opt_dsos0)
    [feasibility,violation] = isDSOS(opt_dsos0)

%% the problem reads as: V = diagonal Sum-of-Squares polynomial
%   min tr(Q0)
%   s.t. V-s0 \in DSOS
%       Q0 \in DD (s0 = z'Q0z)
%  
%   the expected solution is all elemets of Q0 are zero CHECK
%
%   alternative:
%   min tr(-Q0)
%   s.t. V-s0 \in DSOS
%       Q0 \in DD (s0 = z'Q0z)
%  
%   the expected solution is that s0 = V CHECK
%

clear all; clc;

% initiate polynomials
x = msspoly('x',1);     %creates msspoly object   
V = x^2;

    % DSOS program
    % Initialize program
    prog = spotsosprog;
    prog = prog.withIndeterminate(x);
    deg = 1;
    z = monomials(x,0:deg);
    
    [prog,Q0] = prog.newDD(deg+1); s0 = z.'*Q0*z;   %constraining the DSOS multipliers
    
    % DSOS constraint
    prog = prog.withDSOS((V-s0));

    % sedumi options
    options = spot_sdp_default_options();
    % Solve program
    sol = prog.minimize(trace(-Q0), @spot_sedumi, options);  
  
    % Optimal value
    opt_dsos0 = double(sol.eval(Q0))
    trace(opt_dsos0)
    [feasibility,violation] = isDSOS(opt_dsos0)
