function [prog,objective,slack,options] = objectiveROAProgDSOS(prog,V,options)
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
        slack = slackVar*V;
        objective = -slackVar;
        
%     case 'states'
%         [prog,slack] = prog.newPos(1);
%         slack = slackVar*states.'*states;
%         objective = -slackVar;
%         
%     case 'indets'
%         [prog,slack] = prog.newPos(1);
%         slack = slackVar*indets.'*indets;
%         objective = -slackVar;
%         
%     case 'trace'
%         slack = 0;
%         objective = trace(blkdiag(Qset{:})...
%             -eye(length(Qset)*length(Qset{1}))); 
%             %all Qset{:} all the same size, therefore length(Qset{1});
            
    otherwise
        warning('Method is unknown, objecive is set to default (0)')
        objective = 0;
        
end


end

