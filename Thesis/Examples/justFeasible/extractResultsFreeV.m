function extractResultsFreeV(options)

global fastest_option fastest_time

[~,string] = optionsByCounter(options);
loadfile = strcat('data/',string.method,string.deg,...
    string.solver_method,...
        string.FeasibilityTol,string.objective,'.mat');
load(loadfile);

if feasibility == 1
    location = 'feasible';
    
    if solution.info.runtime < fastest_time
       fastest_time = solution.info.runtime;
       fastest_option = strcat(string.method,...
           string.deg,string.solver_method,...
            string.FeasibilityTol,string.objective);
       fastes_option_File = strcat('data/fastes_option.mat');
       save(fastes_option_File,'fastest_option');
    end
elseif feasibility == -1
    location = 'infeasible';
else 
    location = 'numerical';
end

savefile = strcat('data/',location,'/',string.method,...
    string.deg,string.solver_method,...
    string.FeasibilityTol,string.objective,'.mat');
save(savefile,'solution','feasibility','V');

delete(loadfile);
end