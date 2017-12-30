function [ts,ys] = drawTrajectory(eom,x0,tspan)
%time steps are spaced for easier handeling in other programms
[ts,ys] = ode45(eom,[tspan],x0); 
plot(ys(:,1),ys(:,2),'r')
end




