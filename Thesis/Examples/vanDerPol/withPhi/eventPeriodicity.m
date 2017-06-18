function [value,isterminal,direction] = eventPeriodicity(T,Y,Y0)
%timeOfPeriod this event function to investigate periodicity
%   calculates the period for one cycle

value = Y-Y0;
isterminal = zeros(length(Y),1);
direction = ones(length(Y),1);
end

