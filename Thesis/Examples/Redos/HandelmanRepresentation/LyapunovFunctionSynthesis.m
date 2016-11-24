%% solving Handelman rep. of exampl. 1 from Lyapunov function synthesis using Handleman representation
clear all; clc;

% initiate polynomials
x = msspoly('x',2);     %creates msspoly object   

dx = [-x(1)^3 + x(2);-x(1)-x(2)];
V= x(1)^2 + x(2)^2;
dV = diff(V,x)*dx;

x1_l = -100; x1_u = 100; x2_l = -100; x2_u = 100; %box boundaries 

% comupitiung inverval monomials and mMonoid of intervals
intvlMonomials = [x1_u^4-x(1)^4; x(1)^4-x1_l^4;...
    x2_u^2-x(2)^2; x(2)^2-x2_l^2];

HR = [x1_u-x(1); x(1)-x1_l; x2_u-x(2); x(2)-x2_l];
deg = 1;
mMonoid = multiplicativeMonoid(HR, deg);

% Initialize spotsosprog program
prog = spotsosprog;
prog = prog.withIndeterminate(x);

% add nonlinear multipliers
[prog,lambda] = prog.newPos(length(intvlMonomials)+length(mMonoid));
prog = prog.withPolyEqs(-dV-lambda.'*[intvlMonomials; mMonoid]);

% options
options = spot_sdp_default_options();
% Solve program
sol = prog.minimize(sum(lambda), @spot_gurobi, options);    

% Optimal value
opt_lambda = double(sol.eval(lambda));

-dV-opt_lambda.'*[intvlMonomials; mMonoid]
