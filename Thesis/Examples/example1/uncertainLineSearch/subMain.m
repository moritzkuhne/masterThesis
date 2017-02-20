function subMain(example,options,problem_counter)
%SUBMAIN Summary of this function goes here
%   Detailed explanation goes here

V = example.V; dV = example.dV; inequalities = example.inequalities;

%preloop assignments and allocation
i_end = 1;
solution_table(1:i_end) = cell(i_end,1);

global evaluation feasible infeasible slack DSOS eig DSOSeig
evaluation = 0; feasible = 0; infeasible = 0; slack = 0; 
DSOS = 0; eig = 0; DSOSeig = 0;
time_table = zeros(i_end,1);

for i=1:i_end %we expect each run takes 1+log2(1000) ~~ 11 iterations in total we want 100
    problem_counter
    i
    t_start = clock;
    [solution_table{i},~] = ROAProg(dV,V,inequalities,options);
    time_table(i) = etime(clock,t_start);
end


matFile = strcat('option',num2str(problem_counter),'.mat');
save(matFile,'time_table','solution_table',...
    'evaluation','feasible','infeasible','slack','DSOS','eig','DSOSeig');

end

