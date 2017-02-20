a = 1.2;
x = -a:0.1:a;
dx = x.^2-x;

quiver(dx,zeros(length(dx),1).',x,zeros(length(dx),1).')

figure()
plot(x,dx,'k','LineWidth',1.5)
hold on
plot([-a a],[0 0],'k');
plot([0 0],[-0.2 2.2],'k');
axis([-1.2 1.2 -0.2 2.2])
ax = gca;
%ax.XAxisLocation = 'origin';
%ax.YAxisLocation = 'origin';
yticks(0);
yticklabels({0});
xticks([0,1]);
xticklabels({'0','a'});
xlabel('x')
ylabel('\dot{V}(x)')

% the arrows
xO = 0.025;  
yO = 0.025;
patch(...
    [1.2-xO -yO; 1.2-xO yO; 1.2 0], ...
    [0+yO 2.2-xO; -0-yO 2.2-xO; 0 2.2], 'k', 'clipping', 'off')



filename = strcat(pwd,'/dxUncertainDynamics.tex');
%saveas(gcf,filename);
matlab2tikz('filename',filename);