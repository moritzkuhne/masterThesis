function plotLine(plot_problem)

plot_problem = 0;

matFile = strcat('option',num2str(plot_problem),'.mat');
load(matFile);

feasibility = false(length(solution_table),1);
for i=1:length(solution_table)
    solution = solution_table{i}{1};
    if solution.rho == solution.rho_extr
        feasibility(i) = true;
    end
end

feasibility_short = false(floor(length(feasibility)/10),1);
for i=1:floor(length(feasibility)/10)
    feasibility_short(i) = feasibility(i*10);
end
%% Plotting

%plotting rho distribution
figure()
x0=100;
y0=100;
width=550;
height=125;
set(gcf,'units','points','position',[x0,y0,width,height])

hold on
h = plot([0 length(feasibility_short)],[0 0],...
    'k','linewidth',1);
set(get(get(h,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
plot(find(feasibility_short),zeros(length(find(feasibility_short)),1),'gx','markersize',10,'linewidth',1.5)
plot(find(~feasibility_short),zeros(length(find(~feasibility_short))),'rx','markersize',10,'linewidth',1.5)
axis([0 length(feasibility_short)/4 -0.05 0.1])
ylabel('')
yticks(0);
xticks('');
xlabel('$x$')
xticks([0,length(feasibility_short)/6.26,length(feasibility_short)]);
xticklabels({'0','0.16','1'});
legend({'feasible','infeasible'});


%%
stringname = num2str(plot_problem);
stringname(ismember(stringname,' ,.:;!')) = [];
name = strcat('Line',stringname);
filename = strcat(pwd,'/plots/',name,'.tex');
%saveas(gcf,filename);
matlab2tikz('filename',filename);
