function plottingdV(rho)

X=-1.2:0.01:1.2;
dV=2*X.^2 - 2*X.^3;

figure
hold on
plot(X,dV,'k','LineWidth',1.5)
plot([-sqrt(rho) -sqrt(rho)],[0 1],'k--')
plot([sqrt(rho) sqrt(rho)],[0 1],'k--')



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
set(gca,'ytick',[])
ax.XTickLabel= {'$\rho = V(x)$'};
%ax.YTickLabel= {''};

xlabel('x')
ylabel('-\dot{V}(x)')

% the arrows
xO = 0.025;  
yO = 0.025;
patch(...
    [1.2-xO -yO; 1.2-xO yO; 1.2 0], ...
    [0+yO 2.2-xO; -0-yO 2.2-xO; 0 2.2], 'k', 'clipping', 'off')

