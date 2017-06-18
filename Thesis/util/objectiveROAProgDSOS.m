function [prog,objective,slack,options] = objectiveROAProgDSOS(prog,system,options)
%OBJECTIVEROAPROGDSOS Returns objective in order to stabilize the
%feasibility problem

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
        
%     case 'trace'
%         slack = 0;
%         objective = trace(blkdiag(Qset{:})...
%             -eye(length(Qset)*length(Qset{1}))); 
%             %all Qset{:} all the same size, therefore length(Qset{1});
            
    otherwise
        warning('Method is unknown, objecive is set to default Lyap')
        [prog,objective,slack,options] = objectiveROAProgDSOS(prog,system,[]);
        
end


end

