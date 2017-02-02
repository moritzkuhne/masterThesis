function [ts,ys] = drawTrajectory(eom,x0,tspan)
[ts,ys] = ode45(eom,[tspan],x0); %time steps are spaced for easier handeling in other programms
plot(ys(:,1),ys(:,2),'r')
end




