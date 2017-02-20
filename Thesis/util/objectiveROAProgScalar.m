function [prog,objective,slack,options] = objectiveROAProgScalar(prog,system,options)
%OBJECTIVEROAPROGDSOS Summary of this function goes here
%   Detailed explanation goes here

    if isfield(options,'objective')
        objetiveOption = options.objective ;
    else
        objetiveOption = 'Lyap';
        options.objective = objetiveOption;
    end


switch objetiveOption
    
    case '0'
        slack = 0;
        objective = 0;

    case 'Lyap'
        [prog,slackVar] = prog.newPos(1);
        slack = slackVar*system.V;
        objective = -slackVar;
        
    case 'states'
        [prog,slackVar] = prog.newPos(1);
        slack = slackVar*system.states.'*system.states;
        objective = -slackVar;
        
    case 'indets'
        [prog,slackVar] = prog.newPos(1);
        indets = [system.states; system.parameters];
        slack = slackVar*indets.'*indets;
        objective = -slackVar;

%     case 'sum'
%         slack = 0;
%         objective = sum(lambda);
        
    otherwise
        warning('Method is unknown, objecive is set to default Lyap')
        [prog,objective,slack,options] = objectiveROAProgDSOS(prog,system,[]);
end










end

