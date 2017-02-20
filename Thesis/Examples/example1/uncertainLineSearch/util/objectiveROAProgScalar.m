function [objective] = objectiveROAProgScalar(option, lambda)
%OBJECTIVEROAPROGDSOS Summary of this function goes here
%   Detailed explanation goes here

switch option
    
    case '0'
        objective = 0;
        
    case 'sum'
        objective = sum(lambda);
        
    otherwise
        warning('Method is unknown, objecive is set to default (0)')
        objective = 0;
end


end

