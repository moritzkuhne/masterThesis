function drawTransversalPlain2D(system,tau,x)
%DRAWTRANSVERSELPLAIN draws a transversal plain to the point x,tau

[~,PI] = transversalPlains2D(system,tau,x);
plain = PI.';

%creating two points of transversal plain and draw line between them
drawP1 = x.'-0.5*plain;
drawP2 = x.'+0.5*plain;
hold on
plot([drawP1(1) drawP2(1)],[drawP1(2) drawP2(2)],'k');

end