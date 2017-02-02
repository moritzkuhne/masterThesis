clear all; clc; 

% initiate polynomials
x = msspoly('x',2);         %state variables 
z = monomials(x,0:2);   
V = x(1)^2 + x(2)^2;

%initiate program
prog = spotsosprog;
prog = prog.withIndeterminate(x);

%setting up polynomial in monomials
%[prog,poly,coeff] = prog.newFreePoly(z,1);
[prog,poly,coeff] = prog.newDSOSPoly(z,2)
%setting up equality constraint
prog = prog.withPolyEqs(V-poly(2)-poly(1));

% Solve program
solution = prog.minimize(sum(coeff), @spot_gurobi,spotprog.defaultOptions); 
subs(poly,coeff,double(solution.eval(coeff)))