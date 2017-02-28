function plottingdV(rho_K)

rho_S = 0.1424;
rho_K = 0.2324; 


X=-1.2:0.001:1.2;
dV=X.^2 - 2*X.^3;

figure
hold on
h0 = plot(X,dV,'k','LineWidth',1.5);
set(get(get(h0,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
h1 = plot([-sqrt(rho_K) -sqrt(rho_K)],[0 1],'r--','LineWidth',1.5);
set(get(get(h1,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
plot([sqrt(rho_K) sqrt(rho_K)],[0 1],'r--','LineWidth',1.5);
h1 = plot([-sqrt(rho_S) -sqrt(rho_S)],[0 1],'b--','LineWidth',1.5);
set(get(get(h1,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
plot([sqrt(rho_S) sqrt(rho_S)],[0 1],'b--','LineWidth',1.5);

legend({'k-S-Procedure','S-Procedure'})


%axis([-1.5 1.5 0 3])
axis([-1.2 1.2 -0.2 2.2])
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
if sqrt(rho_K) == -sqrt(rho_K)
    set(gca,'xtick',sqrt(rho_K))
else
    set(gca,'xtick',[-sqrt(rho_K), sqrt(rho_K)])
end
set(gca,'ytick',[])

ax.XTickLabel= {''};
ax.YTickLabel= {''};

xlabel('x')
ylabel('-\dot{V}(x)')

% the arrows
% xO = 0.025;  
% yO = 0.025;
% h3 = patch(...
%     [1.2-xO -yO; 1.2-xO yO; 1.2 0], ...
%     [0+yO 2.2-xO; -0-yO 2.2-xO; 0 2.2], 'k', 'clipping', 'off')
% set(get(get(h3,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
% 
