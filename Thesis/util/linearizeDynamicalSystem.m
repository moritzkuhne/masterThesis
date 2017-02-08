%to do:     multivariable/multidimensional system
%           whats about B C D

function [dynamicalSystem_lin,A] = linearizeDynamicalSystem(system,states)
%LINEARIZEDYNAMICALSYSTEM This function returns a linearized system to an
%mss-poly system
%   So far, only passive systems are considered, e.g. it is only linearized
%   for A matrix.
%   More explenation here

error('under construction')

system = @eom;
states = msspoly('x',2);

dynamics = eom([],states)
%%
[indet,powers,M] = decomp(dynamicalSystem);

for i=1:length(powers)
    
    if sum(powers(i,:),2)~=1
       %powers(i,:) = zeros(1,length(indet));
       M(1,i) = 0; %does the same but maybe prob. for multidim cases
    end
    
end

dynamicalSystem_lin = recomp(indet,powers,M);
[~,~,A] = decomp(dynamicalSystem_lin);

end
% 
% function dY = eom(T,Y,Y0)
% Y1 = Y(1);
% Y2 = Y(2);
% 
% %% van der pol osscillator
% mu = 1;
% 
% Y1dot = Y2;
% Y2dot = -Y1+mu*(1-Y1^2)*Y2;
% 
% dY = [Y1dot; Y2dot];
% end