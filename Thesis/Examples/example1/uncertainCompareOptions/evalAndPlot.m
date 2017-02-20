function evalAndPlot(plot_problem)

matFile = strcat('option',num2str(plot_problem(1)),'.mat');
load(matFile);
rho_tables = zeros(length(solution_table),length(plot_problem));
rho_averages = zeros(1,length(plot_problem));

for i=1:length(plot_problem)
    matFile = strcat('option',num2str(plot_problem(i)),'.mat');
    load(matFile);
    for j=1:length(solution_table)
       rho_tables(j,i) = solution_table{j}.rho;
    end 
    rho_tables(:,i) = sort(rho_tables(:,i));
    rho_averages(i) = mean(rho_tables(:,i));
end

%% Plotting
colors = {'k','b','r'};

%plotting rho distribution
figure()
hold on;
for i=1:length(plot_problem)
    stairs([1:length(rho_tables(:,i))],rho_tables(:,i),...
        colors{i},'linewidth',1.5);
    h = plot([0 length(rho_tables(:,i))],[rho_averages(i) rho_averages(i)],...
        colors{i},'linewidth',1.5);
    set(get(get(h,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
    ylabel('\rho')
    xlabel('% of achieved \rho')
    xticks([0,length(rho_tables(:,i))]);
    xticklabels({'100','0'});
    legendInfo{i} = ['option' num2str(i)];
end
legend(legendInfo);

stringname = num2str(plot_problem);
stringname(ismember(stringname,' ,.:;!')) = [];
name = strcat('compare_rho',stringname);
filename = strcat(pwd,'/plots/',name,'.tex');
%saveas(gcf,filename);
matlab2tikz('filename',filename);

