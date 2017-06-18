function [fig] = phasePortai2D(eom,options) 

if nargin < 2 
    options = [];
end

%f = @(t,X) [X(2); -X(1)];

%creates two meshes with spacing of the given linespace
statespacing = linspace(-3,3,20);
[x1,x2] = meshgrid(statespacing,statespacing);

%in these variables the derivatives at the meshgrid points are stored 
x1dot = zeros(size(x1));
x2dot = zeros(size(x2));


t=0;    %this line is needed for time invariant systems
for i = 1:numel(x1)
    xdot= eom(t,[x1(i); x2(i)]);
    x1dot(i) = xdot(1);
    x2dot(i) = xdot(2);
end

% %this block scales the derivatives to unitsize -OPTIONAL!
% for i = 1:numel(x1)
% Vmod = sqrt(x1dot(i)^2 + x2dot(i)^2);
% x1dot(i) = x1dot(i)/Vmod;
% x2dot(i) = x2dot(i)/Vmod;
% end

quiver(x1,x2,x1dot,x2dot,'r'); figure(gcf)
xlabel('x_1')
ylabel('x_2')
axis tight equal;

fig = gcf;

