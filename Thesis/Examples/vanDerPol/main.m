%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% main file for computing and drawing transverse dynamics                %
%                                                                        %
% by M. Fischer-Gundlach, Delft 2016                                     %
%                                                                        %
% the equations of motion are implemented in the file eom.m              %
%                                                                        %       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%draw phase portrai
fig = phasePortrai2D(@eom);

%this block was used once to determine an initial condition on the limit
%cycle and the time of period
Y0 = [2; 0.2036];
tspan = [0 40];
[T, Y, TE, YE, IE] = periodicity(Y0,tspan);

%%
tspan = [0, 13.326573700340958/2];
%draw a trajectorie for the given initial value
Y0 = [2.003602513881589; 0.152170514312629];
%tspan = [0, 20];
hold on
[t,y] = drawTrajectory(@eom,Y0,tspan);


%%
%draw transversal plains 
tau = [0:0.1:13.326573700340958/2];
result = ones(length(tau),1);
for i=1:length(tau)
    result(i) = transverseDynamics(@eom,t,y,tau(i));
end
%%
%draw transverse dynamics
%[ttrans,ytrans] = drawTransverseDynamics(Y0,tspan);