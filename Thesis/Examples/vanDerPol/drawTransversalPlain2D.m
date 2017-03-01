function drawTransversalPlain2D(system,tau,x,lengthOfPlain,color)
%DRAWTRANSVERSELPLAIN draws a transversal plain to the point x,tau

if nargin < 5
    color = 'k';
end

[~,PI] = transversalPlains2D(system,tau,x);
plain = PI.';

%creating two points of transversal plain and draw line between them
drawP1 = x.'-lengthOfPlain*plain;
drawP2 = x.'+lengthOfPlain*plain;
hold on
plot([drawP1(1) drawP2(1)],[drawP1(2) drawP2(2)],...
    color,'linewidth',1.5,'MarkerSize',10);

end