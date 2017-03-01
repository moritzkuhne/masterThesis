function extractResults(options)

[~,string] = optionsByCounter(options);
loadfile = strcat('data/',string.method,string.deg,string.solver_method,...
        string.FeasibilityTol,string.objective,'.mat');
load(loadfile);

if feasible == 1
    location = 'feasible';
elseif infeasible == 1
    location = 'infeasible';
else
    location = 'numerical';
end

savefile = strcat('data/',location,'/',string.method,string.deg,string.solver_method,...
    string.FeasibilityTol,string.objective,'.mat');
save(savefile,'time_table','solution_table',...
'evaluation','feasible','infeasible','slack','DSOS','eig','DSOSeig');

delete(loadfile);

end