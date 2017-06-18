function subMain(system,options,counter)
%SUBMAIN Summary of this function goes here
%   Detailed explanation goes here

%preloop assignments and allocation
i_end = 100;
solution_table(1:i_end) = cell(i_end,1);

global evaluation feasible infeasible slack DSOS eig DSOSeig
evaluation = 0; feasible = 0; infeasible = 0; slack = 0; 
DSOS = 0; eig = 0; DSOSeig = 0;
time_table = zeros(i_end,1);

for i=1:i_end %we expect each run takes 1+log2(1000) ~~ 11 iterations in total we want 100
    counter
    i
    t_start = clock;
    [solution_table{i},~] = ROAFAILUREProg(system,options);
    time_table(i) = etime(clock,t_start);
end

[~,string] = optionsByCounter(counter);
matFile = strcat('data/',string.method,string.deg,string.solver_method,...
            string.FeasibilityTol,string.objective,'.mat');
save(matFile,'time_table','solution_table',...
    'evaluation','feasible','infeasible','slack','DSOS','eig','DSOSeig');

end

