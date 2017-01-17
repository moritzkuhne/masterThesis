

% initiate polynomials
x = msspoly('x',1);     %state variables 
t = msspoly('t',1);     %parameters
%a_u = 1; a_l = 0.5;     %parameter bounds

% setting up the systems dynamics
dx = x^2-(1+t^2)*x;
V = x^2;
dV = diff(V,x)*dx;

inequalities = [];
%inequalities = [a-a_l, a_u-a];
options = [];

%method = @PsatzProg;   evalMethod = @evalROAProgDSOS; deg = 2;
%method = @kSprocedureProg; evalMethod = @evalROAProgDSOS; deg = 2; options.k = 2;
%method = @SprocedureProg;  evalMethod = @evalROAProgDSOS; deg = 3; 
%method = @HandelmanAndDSOSProg; evalMethod = @evalROAProgScalar; deg = 10;
%method = @HandelmanProg; evalMethod = @evalROAProgScalar; deg = 10;

[solution,decisionVar] = ROAProg(dV,V,inequalities,method,deg,options);
rho = evalMethod(solution,decisionVar);