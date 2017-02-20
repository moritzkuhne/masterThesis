% reporting: the problem is JUST feasible, i.e. objective needs to be 0
%           for the same reason KSprocedure and PSatz strugle!  
%           on the other hand, deg = 0 does an awesome job!
%           Handelman fails, but HandelmanDSOS sucesses (of course it does)

% example 4.1 in Sankaranarayanan2013
close all; clear all; clc;

%%
disp('redo example 4.1 Sankaranarayanan2013 ')
x= msspoly('x',2);

dx = [-x(1)^3+x(2);
     -x(1)-x(2)];
bound_u = 100; bound_l = 100;
inequalities = [bound_u-x(1),x(1)-bound_l,bound_u-x(2),x(2)-bound_l];

V = x(1)^2+x(2)^2;

system = dynamicalSystem(dx,inequalities,[],x,[],V);
     
%% setting options
disp('Setting the options for ROAprog.')

options.rho = [0 sqrt(2)*100];
options.lineSearchMethod = 'bisect';
options.lineSearchMethodOptions = 'random'; %this line does not do anything yet

options.objective = '0'; 
options.feasibilityTest = 'analytical';

%setting solver options
options.solver = @spot_gurobi;
params.method = 0; %default 0 (primal simplex)
params.FeasibilityTol = 1E-2; %default 1E-6
params.outputFlag = 0;
options.solverOptions = params;

options.method = @SprocedureProg; options.methodOptions.deg = 0; 
option.method = @HandelmanAndDSOSProg; options.methodOptions.deg = 0;
% options.method = @HandelmanProg; options.methodOptions.deg = 2;

%% run ROAprog
disp('Running the ROAprog.')
[solution,options] = ROAProg(system,options);
