%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% main file for computing and drawing transverse dynamics of             %
% van-der-Pol ossicaltor                                                 %
%                                                                        %
% by M. Fischer-Gundlach, Delft 2017                                     %
%                                                                        %
% the equations of motion are implemented in the file eom.m              %
%                                                                        %       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%close all; 
close all; clear all; clc;
disp('intialization');

addpath(pwd)

EOM = @eom;

%% draw phase portrai 
disp('draw phase portrai')

fig = phasePortrai2D(EOM);
%% this block was used once to determine an initial condition on the limit
%  cycle and the time of period
% disp('determine periodicity and solution')
% Y0 = [2; 0.2036];
% tspan = [0 40];
% [T, Y, TE, YE, IE] = periodicity(Y0,tspan);

%% draw a trajectorie for the given initial values and timespan
disp('calculate and draw periodic solution')

%these were obtained by the periodicity function above
Y0 = [2.003602513881589; 0.152170514312629]; 
tspan = [0, 13.326573700340958/2];

hold on
[t,y] = drawTrajectory(EOM,Y0,tspan);
save('trajectory','t','y');

%% setting options
disp('Setting the options for ROAprog.')

options.objective = '0'; 
options.feasibilityTest = 'analytical';
% options.feasibilityTest = 'numerical';

%bisction search
options.rho = [0 5];
options.lineSearchMethod = 'bisect';
options.lineSearchMethodOptions = 'random';

%setting solver options
options.solver = @spot_gurobi;
params.FeasibilityTol = 1E-6; %default 1E-6
params.outputFlag = 0;
options.solverOptions = params;

%% calculate transverse dynamics
close all;
disp('calculate transverse dynamics')

tau = [0:0.1:tspan(end)];
x_interp = interp1(t,y,tau);
rho_table_bisect = zeros(length(tau),1);
rho_table_step = zeros(length(tau),1);

for i=1:length(tau)
%i=1; %LOOP FOR TAU 

x_transverse = msspoly('x_t',1);
c = msspoly('c',1);
s = msspoly('s',1);
indet = [x_transverse;c;s];

parameters = [];

[dx_transverse_nom,dx_transverse_den] = transverseDynamics(EOM,x_interp(i,:),...
    tau(i),x_transverse);

inequalities = [];
rho = -0.001; terminate = false;
%equalities = [c^2+s^2-1];

%% create initial Lyapunov function 
% disp('crate initial Lyapunov function')

%% find maximum level set of V for which system is stable
disp('find maximum level set of V for which system is stable')

%% run ROAprog 
disp('Running the ROA estimation.')

while ~terminate

rho = rho + 0.001;
inequalities = [rho-x_transverse; x_transverse-rho];

prog = spotsosprog;
prog = prog.withIndeterminate(indet);

%setting up the PD constraint on V
% z = monomials(x_transverse,2:4);
% [prog,V,~] = newFreePoly(prog,z,1);
% PD = x_transverse^2;
% 
% optionsV = options;
% optionsV.objective = '0'; 
% optionsV.k = 2;
% optionsV.degS = 2;
% optionsV.degP = 2;
% 
% [prog,~] = kSprocedureConstraint(prog,...
%     V,inequalities,[],PD,0,optionsV)

V = x_transverse^2;

% setting up the PSD constraint on dV
%removing constant terms and calculate dV, split nom and den 
dx_transverse_nom = removeConstant(dx_transverse_nom);
dV_nom = diff(V,x_transverse)*dx_transverse_nom;
PD = dx_transverse_den.'*dx_transverse_den;
equalities = [c^2+s^2-1; c-1; s];
%inequalities = [inequalities; dx_transverse_den];
% [prog,objective] = newPos(prog,1);
objective = 0;
slack = objective*indet.'*indet;


optionsdV = options;
optionsdV.k = 2;
optionsdV.degS = 8;
optionsdV.degP = 8;

[prog,~] = kSprocedureConstraint(prog,...
    dV_nom,inequalities,equalities,PD,slack,optionsdV)

%set solver and its options
[solver,spotOptions,options] = solverOptionsPSDProg(options);

% Solve program
solution = prog.minimize(-objective, solver, spotOptions)

end

%% draw transversal plains 
disp('draw transversal plains')


% rho_table_bisect(i) = solution.rho;
% length = sqrt(rho_table_bisect(i));
% drawTransversalPlain2D(EOM,tau(i),x_interp(i,:),length,'kx');

end





