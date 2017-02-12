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
clear all; clc;
disp('intialization');

system = @eom;

%% draw phase portrai 
disp('draw phase portrai')

fig = phasePortrai2D(system);
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
[t,y] = drawTrajectory(system,Y0,tspan);
save('trajectory','t','y');

%% calculate transverse dynamics
disp('calculate transverse dynamics')

tau = [0:0.1:tspan(end)];
%tau = [0:0.07:tspan(end)]; %this one was good!
x_interp = interp1(t,y,tau);
rho_table = zeros(length(tau),1);

for i=1:length(tau)
%i=1; %LOOP FOR TAU 

x_transverse = msspoly('x_t',1);
[dx_transverse] = transverseDynamics(system,x_interp(i,:),tau(i),x_transverse);

%% create initial Lyapunov function for (linearized) system
disp('crate initial Lyapunov function')

V = 0.5*(x_transverse.'*x_transverse);

%% find maximum level set of V for which system is stable
disp('find maximum level set of V for which system is stable')

dV = diff(V,x_transverse)*dx_transverse;

inequalities = [];
%setting gurobi options
params.method = 0; %default 0 (primal simplex)
params.FeasibilityTol = 1E-9; %default 1E-6

%setting options
options.solverOptions = params;

%method = @PsatzProg;evalMethod = @evalROAProgDSOS; deg = 2; options.objective = '0';
%method = @kSprocedureProg;evalMethod = @evalROAProgDSOS; deg = 2; options.k = 2; options.objective = '0';
method = @SprocedureProg;evalMethod = @evalROAProgDSOS; deg = 3; options.objective = '0';
%method = @HandelmanAndDSOSProg; evalMethod = @evalROAProgScalar; deg = 5; options.objective = '0';
%method = @HandelmanProg; evalMethod = @evalROAProgScalar; deg = 5; options.objective = '0';

[solution,decisionVar] = ROAProg(dV,V,inequalities,method,deg,options);
rho_table(i) = evalMethod(solution,decisionVar);

%% draw transversal plains 
disp('draw transversal plains')

length = sqrt(2*rho_table(i));
drawTransversalPlain2D(system,tau(i),x_interp(i,:),length);

end



