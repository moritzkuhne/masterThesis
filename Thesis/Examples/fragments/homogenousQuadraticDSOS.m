clear all; clc; 

% initiate polynomials
x = msspoly('x',2);         %state variables 
z = monomials(x,1:1);   

%initiate program
prog = spotsosprog;
prog = prog.withIndeterminate(x);

%setting up polynomial in monomials
%[prog,poly,coeff] = prog.newFreePoly(z,1);
%[prog,poly,coeff] = prog.newDSOSPoly(z,2);
[prog,DD] = prog.newDD(length(z)); V = z.'*DD*z
