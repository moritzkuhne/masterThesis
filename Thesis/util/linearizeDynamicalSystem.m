%to do:     multivariable/multidimensional system
%           whats about B C D

function [dx_lin,A] = linearizeDynamicalSystem(system)
%LINEARIZEDYNAMICALSYSTEM This function returns a linearized system to an
%mss-poly system
%   So far, only passive systems are considered, e.g. it is only linearized
%   for A matrix.
%   More explenation here

% x = msspoly('x',2);
% a = msspoly('a',1);
% 
% dx = [x(1)*a + x(2)*x(1); x(2)*a];

[indet,powers,M] = decomp(system.dx);
mtch_states = match(indet,system.states);
if ~isempty(system.parameters)
    mtch_parameters = match(indet,system.parameters);
end
% mtch_states = match(indet,x);
% mtch_parameters = match(indet,a);

for i=1:length(powers)
    
    if sum(powers(i,mtch_states),2) > 1
        M(:,i) = zeros(size(M,1),1);
    end
    
    if ~isempty(system.parameters)
        if sum(powers(i,mtch_parameters),2) > 1
            error('dynamical system needs to be linear in parameters')
        end
    end

end

dx_lin = recomp(indet,powers,M);
[~,~,A] = decomp(dx_lin);

%% so far uncertain systems are not supported!
% [indet,powers,M] = decomp(dx);
% mtch_parameters = match(indet,a);
% 
% if ~isempty(mtch_parameters)
%     for i=1:length(mtch_parameters)
%         for j=1:size(powers,2)
%             if powers(mtch_parameters(i),j) == 1
%                B = indet(mtch_parameters(i))*M(:,i);
%             end
%         end
%     end   
% end

end





