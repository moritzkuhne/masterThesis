function subMainFreeV(options,counter)
%SUBMAIN Summary of this function goes here
%   Detailed explanation goes here

[~,string] = optionsByCounter(counter);

switch string.method
    case 'HandelmanAndDSOS'
        [solution,feasibility,V] = freeVHandelmanDSOS(options);
    case 'Handelman'
        [solution,feasibility,V] = freeVHandelman(options);
    otherwise
        [solution,feasibility,V] = freeVkSProcedure(options);
end

matFile = strcat('data/',string.method,string.deg,string.solver_method,...
            string.FeasibilityTol,string.objective,'.mat');
save(matFile,'solution','feasibility','V');

end

