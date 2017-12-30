clear all;
close all;

%%
figure
hold on

f = @(t,Y) [-Y(1)^3+Y(2); -Y(1)-Y(2)];
y1 = linspace(-5,5,25); %nice plots
y2 = linspace(-5,5,25);
% y1 = linspace(-100,100,25); %actually plots
% y2 = linspace(-100,100,25);


% [x,y] = meshgrid(y1,y2);
% 
% u = zeros(size(x));
% v = zeros(size(x));
% 
% t=0;
% for i = 1:numel(x)
%     Yprime = f(t,[x(i); y(i)]);
%     u(i) = Yprime(1);
%     v(i) = Yprime(2);
% end
% 
% for i = 1:numel(x)
% Vmod = sqrt(u(i)^2 + v(i)^2);
% u(i) = u(i)/Vmod;
% v(i) = v(i)/Vmod;
% end
% 
% quiver(x,y,u,v,'r'); %figure(gcf)

xlabel('y_1')
ylabel('y_2')
axis tight equal;


hold on
for y20 = [5]
    [ts,ys] = ode45(f,[0,50],[0;y20]);
    plot(ys(:,1),ys(:,2),'k')
    plot(ys(1,1),ys(1,2),'k') % starting point
    plot(ys(end,1),ys(end,2),'k') % ending point
end
hold off

hold on
th = 0:pi/50:2*pi;
xunit = 5 * cos(th);
yunit = 5 * sin(th);
plot(xunit, yunit,'k');
hold off



