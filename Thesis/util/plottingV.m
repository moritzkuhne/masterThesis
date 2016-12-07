function plottingV(rho)

X=-1.2:0.01:1.2;
V=X.^2;

figure
hold on
plot(X,V,'k','LineWidth',1.5)
plot([-sqrt(rho) sqrt(rho)],[rho rho],'k--')
plot([-sqrt(rho) -sqrt(rho)],[0 rho],'k--')
plot([sqrt(rho) sqrt(rho)],[0 rho],'k--')

%axis([-1.5 1.5 0 3])
axis([-1.2 1.2 -0.2 2.2])
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
if sqrt(rho) == -sqrt(rho)
    set(gca,'xtick',sqrt(rho))
else
    set(gca,'xtick',[-sqrt(rho), sqrt(rho)])
end
set(gca,'ytick',[rho])
ax.XTickLabel= {'$\rho = V(x)$'};
%ax.YTickLabel= {'$\rho$ ='};
ax.YTickLabel= {['$\rho = ' num2str(rho)]};
xlabel('x')
ylabel('V(x)')

% the arrows
xO = 0.025;  
yO = 0.025;
patch(...
    [1.2-xO -yO; 1.2-xO yO; 1.2 0], ...
    [0+yO 2.2-xO; -0-yO 2.2-xO; 0 2.2], 'k', 'clipping', 'off')
