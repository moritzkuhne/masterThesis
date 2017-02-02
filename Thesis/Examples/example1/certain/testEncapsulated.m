

% initiate polynomials
x = msspoly('x',1);     %state variables 

% setting up the systems dynamics
dx = x^2-x;
V = x^2;
dV = diff(V,x)*dx;

inequalities = [];

%method = @PsatzProg;evalMethod = @evalROAProgDSOS; deg = 2; options.objective = '0';
%method = @kSprocedureProg;evalMethod = @evalROAProgDSOS; deg = 2; options.k = 2; options.objective = '0';
%method = @SprocedureProg;evalMethod = @evalROAProgDSOS; deg = 3; options.objective = '0';
%method = @HandelmanAndDSOSProg; evalMethod = @evalROAProgScalar; deg = 5; options.objective = '0';
%method = @HandelmanProg; evalMethod = @evalROAProgScalar; deg = 5; options.objective = '0';

[solution,decisionVar] = ROAProg(dV,V,inequalities,method,deg,options);
rho = evalMethod(solution,decisionVar);