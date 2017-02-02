function [T, Y, TE, YE, IE] = periodicity(Y0,tspan)
%periodicity is used to finde points on periodic solution and period
%duration

OPTIONS = odeset('Events',@eventPeriodicity,'AbsTol',10^-8,'RelTol',10^-8);
[T, Y, TE, YE, IE] = ode45(@eom,tspan,Y0,OPTIONS,Y0); %time steps are spaced for easier handeling in other programms





end


