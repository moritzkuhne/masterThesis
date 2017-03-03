function extractResults(options)

[~,string] = optionsByCounter(options);
loadfile = strcat('data/',string.method,string.deg,string.solver_method,...
        string.FeasibilityTol,string.objective,'.mat');
load(loadfile);

if feasibility == 1
    location = 'feasible';
else
    location = 'infeasible';
end

savefile = strcat('data/',location,'/',string.method,string.deg,string.solver_method,...
    string.FeasibilityTol,string.objective,'.mat');
save(savefile,'solution','feasibility','V');

delete(loadfile);

end