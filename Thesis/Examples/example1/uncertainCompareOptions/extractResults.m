function table = extractResults(optionsCell)

[~,string] = optionsByCounter(optionsCell{1});
matfile = strcat('data/',string.method,string.deg,string.solver_method,...
        string.FeasibilityTol,string.objective,'.mat');
load(matfile);
table.rho_table = zeros(length(solution_table),length(optionsCell));
table.rho_ave = zeros(1,length(optionsCell));
table.rho_max = zeros(1,length(optionsCell));

table.evaluation = zeros(1,length(optionsCell));
table.feasibility_numerical = zeros(1,length(optionsCell));
table.feasibility_analytical = zeros(1,length(optionsCell));

table.time = zeros(1,length(optionsCell));


% table.infeasible = zeros(1,length(optionsCell));
% table.DSOSeig = zeros(1,length(optionsCell));
% table.slack = zeros(1,length(optionsCell));
% table.feasible = zeros(1,length(optionsCell));
% table.DSOS = zeros(1,length(optionsCell));

for i=1:length(optionsCell)
   [~,string] = optionsByCounter(optionsCell{i});
   matfile = strcat('data/',string.method,string.deg,string.solver_method,...
            string.FeasibilityTol,string.objective,'.mat');
   load(matfile);
   
   for j=1:length(solution_table)
       table.rho_table(j,i) = solution_table{j}.rho;
   end 
   
   table.rho_ave(i) = mean(table.rho_table(:,i));
   table.rho_max(i) = max(table.rho_table(:,i));
   
   table.evaluation(i) = evaluation;
   table.feasibility_numerical(i) = 100*(1-(infeasible/evaluation));
   table.feasibility_analytical(i) = ...
       100*(1-(infeasible+DSOSeig+slack)/evaluation);
   
   table.time(i) = sum(time_table);
          
%    table.infeasible(i) = infeasible;
%    table.DSOSeig(i) = DSOSeig;
%    table.slack(i) = slack;
%    table.feasible(i) = feasible;
%    table.DSOS(i) = DSOS;


end

end