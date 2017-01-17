

% initiate polynomials
x = msspoly('x',1);     %state variables 
t = msspoly('t',1);     %parameters
t_u = 0.5; t_l = 0;     %parameter bounds

% setting up the systems dynamics
dx = x^2-x+t;
V = x^2;
dV = diff(V,x)*dx;


disp('the system has a moving equilibrium point, WTF WHY DOES PSATZ EVEN WORK?????')

%inequalities = [];
inequalities = [t-t_l, t_u-t];
options = [];

%method = @PsatzProg;   evalMethod = @evalROAProgDSOS; deg = 3;
%method = @kSprocedureProg; evalMethod = @evalROAProgDSOS; deg = 5; options.k = 2;
%method = @SprocedureProg;  evalMethod = @evalROAProgDSOS; deg = 3; 
%method = @HandelmanAndDSOSProg; evalMethod = @evalROAProgScalar; deg = 10;
%method = @HandelmanProg; evalMethod = @evalROAProgScalar; deg = 10;

[solution,decisionVar] = ROAProg(dV,V,inequalities,method,deg,options);
rho = evalMethod(solution,decisionVar);