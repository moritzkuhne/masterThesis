% This example is on a polynomial 1-DoF Pendulum with parameter 
% uncertainties. The dynamics are given by:
% [dx1 dx2 dx3 dx4]' = [x2 -G*x3-K*x2 x2x4 -x2x3] with G and K constants 
% due to gravity, length, mass and damping 

%first try the certain model with G = K = 1

% initiate polynomials
x = msspoly('x',4);                             %state variables 
G = 1; K = 1;

% setting up the systems dynamics
dx = [x(2) -G*x(3)-K*x(2) x(2)*x(4) -x(2)*x(3)].';

% P_double = [93.7314 27.4336; 27.4336 70.8701]; 
% V = [x(1) x(2)]*P_double*[x(1) x(2)].';

% P =[0.5917    0.2959         0;
%     0.2959    0.1479         0;
%          0         0    7.4192];
% V = [x(2) x(3) x(4)]*P_double*[x(2) x(3) x(4)].';

%V = 0.5*(x(1)^2 + x(2)^2);
%V = G*(1-x(4)) + 0.5*x(2)^2;
dV = diff(V,x)*dx

inequalities = [];
equalities = [x(3)^2+x(4)^2-1];

rho_initial = 0;
rho_extr = 1.1;
rho = [rho_initial, rho_extr];

%%
%setting gurobi options
params.method = 0; %default 0 (primal simplex)
params.FeasibilityTol = 1E-2; %default 1E-6

%setting options
options.solverOptions = params;

method = 'Sprocedure'; deg = 3; options.objective = '0';

%%
[optimal_multiplier_rho,optimal_multiplier,multipler_solution] = ROAMultiplierProg(dV,V,inequalities,equalities,rho,method,deg,options);





