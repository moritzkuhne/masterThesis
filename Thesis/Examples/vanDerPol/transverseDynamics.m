function [output] = transverseDynamics(system,t,y,tau)
%drawTransverseDynamics for a transversal pertubation the dynamics are
%calculated and drawn into the state space
%   Detailed explanation goes here
%   the notation is the same as in the literature study:
%   z is a vector orthogonal to the transverse surface
%   eta_n are vectors of the global coordinate system, eta_1 = [1 0 .. 0].' 
%   zeta_n are the vectors of the transverse system, whereas zeta_1 is
%   parallel to z and the other zetas span the transverse plane
%   R is the roation matrix from global to transverse incl. normal vector z
%   PI is the projection matrix from global into transverse

tau = 0;
load('trajectory.mat');
system = @eom;

y_interp = interp1(t,y,tau);

z = system(tau,y_interp)/norm(system(tau,y_interp)); %the surface is orthogonal to the trajectory
eta_vectors = eye(length(z)); %vectors of global coordinate system, eta_i = eta_vectors(:,i) 

%setting up the rotation matrix PI
eta_1 = eta_vectors(:,1);
R = zeros(length(eta_1));

for i=1:length(eta_1)
    for j=1:length(eta_1)
        R(i,j) = eta_1(j)*z(i);
    end
end

% constructing projection matrix
zeta_vectors = zeros(length(z)); %vectors of the transv. coord. system zeta_i = zeta_vectors(:,i)
for i=1:length(eta_vectors)
    zeta_vectors(:,i) = R*eta_vectors(:,i);
end

PI = zeta_vectors(:,2:end).'

output = PI*z;

end

