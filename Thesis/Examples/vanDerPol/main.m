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

options.feasibilityTest = 'analytical';
% options.feasibilityTest = 'numerical';

%setting solver options
options.solver = @spot_gurobi;
params.FeasibilityTol = 1E-6; %default 1E-6
params.outputFlag = 0;
options.solverOptions = params;

options.method = @SprocedureProg; options.methodOptions.deg = 4; %works fine
params.method = 0; %default 0 (primal simplex)
options.objective = 'Lyap'; 

% options.method = @PsatzProg; options.methodOptions.deg = 4; 
% params.method = 1;
% options.objective = '0'; 

%% calculate transverse dynamics
disp('calculate transverse dynamics')

tau = [0:0.1:tspan(end)];
%tau = [0:0.07:tspan(end)]; %this one was good!
x_interp = interp1(t,y,tau);
rho_table_bisect = zeros(length(tau),1);
rho_table_step = zeros(length(tau),1);

for i=1:length(tau)
%i=1; %LOOP FOR TAU 

x_transverse = msspoly('x_t',1);
parameters = [];

[dx_transverse] = transverseDynamics(EOM,x_interp(i,:),...
    tau(i),x_transverse);

dx_transverse = removeConstant(dx_transverse);

inequalties = [];
equalities = [];

system = dynamicalSystem(dx_transverse,inequalties,equalities,...
    x_transverse,parameters,x_transverse.'*x_transverse);

%% create initial Lyapunov function for (linearized) system
% disp('crate initial Lyapunov function')
% 
% V = 0.5*(x_transverse.'*x_transverse);
%% find maximum level set of V for which system is stable
disp('find maximum level set of V for which system is stable')

%% run ROAprog 

%bisction search
options.rho = [0 5];
options.lineSearchMethod = 'bisect';
options.lineSearchMethodOptions = 'random'; 

disp('Running the ROAprog.')
[solution,options] = ROAProg(system,options);
rho_table_bisect(i) = solution.rho;

% %line search
% options.rho = [rho_table_bisect(i) (norm(x_interp(i,:)))^2+0.1];
% options.lineSearchMethod = 'step';
% options.lineSearchMethodOptions = 'determined'; 
% 
% [solution,options] = ROAProg(system,options);
% rho_table_step(i) = solution.rho;

%% draw transversal plains 
disp('draw transversal plains')

length = sqrt(rho_table_bisect(i));
drawTransversalPlain2D(EOM,tau(i),x_interp(i,:),length,'kx');

% length = sqrt(rho_table_step(i));
% drawTransversalPlain2D(EOM,tau(i),x_interp(i,:),length,'k');

end



