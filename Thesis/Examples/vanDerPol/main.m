%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% main file for computing and drawing transverse dynamics                %
%                                                                        %
% by M. Fischer-Gundlach, Delft 2016                                     %
%                                                                        %
% the equations of motion are implemented in the file eom.m              %
%                                                                        %       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

%% draw transversal plains 
disp('draw transversal plains')

tau = [0:0.1:tspan(end)];
x_interp = interp1(t,y,tau);

for i=1:length(tau)
   drawTransversalPlain2D(system,tau(i),x_interp(i,:));
end

%% calculate transverse dynamics
disp('calculate transverse dynamics')

disp('under construction')
%LOOP FOR SPECIFIC TAU
%i=1;
%[dx_transverse] = transverseDynamics(system,x_interp(i,:),tau(i),x_transverse);
%double(subs(dx_transverse,x_transverse,0.1))
