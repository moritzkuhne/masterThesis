function plot1(optionsCell,table)
%% Plotting methodVar_objectiveFix_solverFix_FeasibilityTolFix

colors_solid = {'k','b','r'};
colors_dotted = {'k-','b-','r-'};

%plotting rho distribution
figure()
hold on;

for i=1:3   
    
plot([1 2 3],[table.rho_max(3*(i-1)+1)...
    table.rho_max(3*(i-1)+2) table.rho_max(3*(i-1)+3)]...
    ,colors_solid{i},'linewidth',1.5);
h = plot([1 2 3],[table.rho_ave(3*(i-1)+1)...
    table.rho_ave(3*(i-1)+2) table.rho_ave(3*(i-1)+3)]...
    ,colors_dotted{i},'linewidth',1.5);     
set(get(get(h,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');

ylabel('\rho_{\mathrm{opt}}')
xlabel('% of achieved \rho')
xticks([0,1,2,3,4]);
xticklabels({'','4','5','6',''});
legendInfo{i} = ['option' num2str(i)];

end

legend(legendInfo);

[~,string] = optionsByCounter(optionsCell{1});
name = strcat('method',string.solver_method,...
        string.FeasibilityTol,string.objective);
filename = strcat(pwd,'/plots/',name,'.tex');
matlab2tikz('filename',filename);

end

