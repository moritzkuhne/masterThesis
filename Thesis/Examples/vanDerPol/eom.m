function dY = eom(T,Y,Y0)
Y1 = Y(1);
Y2 = Y(2);

%% van der pol osscillator
mu = 1;

Y1dot = Y2;
Y2dot = -Y1+mu*(1-Y1^2)*Y2;

dY = [Y1dot; Y2dot];