function [dx_transverse] = transverseDynamics(system,x,tau,x_transverse)
%transversalDynamics for a transversal pertubation the dynamics are
%calculated
%   the notation is the same as in the literature study:
%   z is a vector orthogonal to the transverse surface
%   PI is the projection matrix from global into transverse

[z,PI] = transversalPlains2D(system,tau,x);

x = x.'; %in the following functions x is a column vector
% we fixed z=f(x), therefore PI is independet of tau. 
dtau_nom = z.'*system(tau,(x+transp(PI)*x_transverse));
dtau_den = z.'*system(tau,x);
dtau = dtau_nom/dtau_den;

dx_transverse_sum1 = PI*system(tau,(x+transp(PI)*x_transverse));
dx_transverse_sum2 = -PI*system(tau,x)*dtau;
dx_transverse = dx_transverse_sum1 + dx_transverse_sum2;


























end

