function table = extractResults(optionsCell)

[~,string] = optionsByCounter(optionsCell{1});
matfile = strcat('data/',string.method,string.deg,string.solver_method,...
        string.FeasibilityTol,string.objective,'.mat');
load(matfile);
table.rho_table = zeros(length(solution_table),length(optionsCell));
table.rho_ave(i) = zeros(1,length(plot_problem));
table.rho_max(i) = zeros(1,length(plot_problem));

table.infeasible = zeros(1,length(optionsCell));
table.DSOSeig = zeros(1,length(optionsCell));
table.slack = zeros(1,length(optionsCell));
table.feasible = zeros(1,length(optionsCell));
table.DSOS = zeros(1,length(optionsCell));


for i=1:length(optionsCell)
   [~,string] = optionsByCounter(optionsCell{i});
   matfile = strcat('data/',string.method,string.deg,string.solver_method,...
            string.FeasibilityTol,string.objective,'.mat');
   load(matfile);
   
   for j=1:length(solution_table)
       table.rho_table(j,i) = solution_table{j}.rho;
   end 
   
   table.rho_ave(i) = mean(table.rho_table,i);
   table.rho_max(i) = max(table.rho_table,[],i);
   
   table.infeasible(i) = infeasible;
   table.DSOSeig(i) = DSOSeig;
   table.slack(i) = slack;
   table.feasible(i) = feasible;
   table.DSOS(i) = feasible;
end

end