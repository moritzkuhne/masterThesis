% Example script for the paper "Transverse Contraction Criteria for the
% Existence, Stability, and Robustness of a Limit Cycle"
% Bug reports: ian.manchester@sydney.edu.au

ep = 1e-5;

prog = mssprog;
x = msspoly('x',2);


z = msspoly('z',1);
r = msspoly('r',1);
prog.free =r; %dummy vairables to get feasibility problem
prog.pos = z;
prog.eq = r-z;

g = monomials(x,0:4); %metric monomials
g2 = monomials(x,0:2); %matrix multiplier monomials
g3 = monomials(x,0:2); %S-procedure monomials

phi = x(1);
psi = x(2);
delta = -3;


f = [-psi-3/2*phi^2-1/2*phi^3
    3*phi-psi];
F = diff(f,x);

%Create metric inverse matrix, W, and its derivative
[prog, W] = newmssmatrix(prog, 2, g);
w = mss_s2v(W);
wdot = diff(w,x)*f;
Wdot = mss_v2s(wdot);

% Contraction Matrix
H=(F*W+W*F'-Wdot);

% Set up Lagrange multipliers
[prog, L1] = newmssmatrix(prog, 2, g2);
prog.sss = L1 - ep*eye(2);

[prog, L2] = newmssmatrix(prog, 2, g2);
prog.sss = L2- ep*eye(2);

[prog, L3] = newmssmatrix(prog, 2, g2);
prog.sss = L3- ep*eye(2);

[prog, L4] = newmssmatrix(prog, 2, g2);
prog.sss = L4- ep*eye(2);

[prog, alpha] = newmssmatrix(prog, 1, g3);
prog.sos = alpha - ep;

% Set up positivity conditions
radius = 10;
prog.sss = W-ep*eye(2)-L1*(radius^2-x'*x) - L2*(f'*f-0.1);
prog.sss = -H-L3*(radius^2-x'*x)- L4*(f'*f-0.1) - ep*eye(2) + alpha*(f*f');


% Set some parameters and solve with Sedumi
clear pars
pars.fid = 1;
pars.cg.maxiter = 200;
pars.cg.refine = 4;

[prog, info] = sedumi(prog,r,1,pars);
info
