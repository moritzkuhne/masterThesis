function [objective] = objectiveROAProgDSOS(option,Qset)
%OBJECTIVEROAPROGDSOS Summary of this function goes here
%   Detailed explanation goes here

switch option
    
    case '0'
        objective = 0;
        
    case 'trace'
        objective = trace(blkdiag(Qset{:})...
            -eye(length(Qset)*length(Qset{1}))); 
            %all Qset{:} all the same size, therefore length(Qset{1});
            
    case 'DD'    
        warning('DD is YET not supported')
        
    otherwise
        warning('Method is unknown, objecive is set to default (0)')
        objective = 0;
        
end


end

