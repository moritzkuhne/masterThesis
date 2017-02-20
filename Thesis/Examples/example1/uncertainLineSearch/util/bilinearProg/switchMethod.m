function [progMethod,evalMethod] = switchMethod(method,step)
%SWITCHMETHOD used to assign function handles
%   Detailed explanation goes here

switch step
    
    case 'multiplier'
    
    switch method

        case 'Psatz'
             progMethod = @PsatzProg;
             evalMethod = @evalROAProgDSOS;

        case 'kSprocedure'
             progMethod = @kSprocedureProg;
             evalMethod = @evalROAProgDSOS;

        case 'Sprocedure'
             progMethod = @SprocedureProg;
             evalMethod = @evalROAProgDSOS;

        case 'HandelmanAndDSOS'
             progMethod = @HandelmanAndDSOSProg;
             evalMethod = @evalROAProgDSOS;

        case 'Handelman'
             progMethod = @HandelmanProg;
             evalMethod = @evalROAProgDSOS;

    end
    
    case 'rho'
        
    switch method

        case 'kSprocedure'
             progMethod = @kSprocedureRhoProg;
             evalMethod = [];

        case 'Sprocedure'
             progMethod = @SprocedureRhoProg;
             evalMethod = [];

        otherwise
            warning('Method or RhoProg for method not supported!')
    end
        

end

end

