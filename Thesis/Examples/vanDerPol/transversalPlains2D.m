function [z,PI] = transversalPlains2D(system,tau,x)
%TRANSVERSE constructs a plain transversal to the dynamics of system at 
% the point x,tau
%   the notation is the same as in the literature study:
%   z is a vector orthogonal to the transverse surface
%   eta_n are vectors of the global coordinate system, eta_1 = [1 0 .. 0].' 
%   zeta_n are the vectors of the transverse system, whereas zeta_1 is
%   parallel to z and the other zetas span the transverse plane
%   R is the roation matrix from global to transverse incl. normal vector z
%   PI is the projection matrix from global into transverse

z_vectors = zeros(2); %warning('works only for planar dynamics')
%z = system(tau,x)/norm(system(tau,x)); %the surface is orthogonal to the trajectory
z = (1/norm(x))*[-x(2);x(1)]; %the surface is radial to the center
z_vectors(:,1) = [z(1); z(2)];  %transverse dynamics
z_vectors(:,2) = [-z(2); z(1)]; 

eta_vectors = eye(length(z)); %vectors of global coordinate system, eta_i = eta_vectors(:,i) 

%setting up the rotation matrix PI

% phi = -acos( (z_vectors(:,1).'*eta_vectors(:,1))/...
%     (norm(z_vectors(:,1))*norm(eta_vectors(:,1))));
% R = [cos(phi) -sin(phi);
%      sin(phi) cos(phi)]

R = zeros(length(z));
for i=1:length(z)
    for j=1:length(z)
        R(i,j) = z_vectors(:,j).'*eta_vectors(:,i);
    end
end

% constructing projection matrix
%vectors of the transv. coord. system zeta_i = zeta_vectors(:,i)
zeta_vectors = zeros(length(z)); 
for i=1:length(eta_vectors)
    zeta_vectors(:,i) = R*eta_vectors(:,i);
end

PI = zeta_vectors(:,2:end).';
end

