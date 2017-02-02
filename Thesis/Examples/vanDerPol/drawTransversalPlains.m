function pplains = drawTransversalPlains(t,y)

%transversal planes for the time instance tplains
tplains = [0:0.1:t(end)]; %consider changing this one later to more abstract version
%preallocating space for direction of transversal plane
pplains = zeros(size(y));

yinterp1 = interp1(t,y,tplains);

%calculating the directions of transversal plaines for time instances
for i=1:length(tplains)
    ydot = eom(tplains(i),yinterp1(i,:));
    
    p1 = 1;
    p2 = -ydot(1)/ydot(2);
    
    pplains(i,1) = p1/norm([p1; p2]);
    pplains(i,2) = p2/norm([p1; p2]);
end

%draw the transverse plane into state space
for i=1:length(tplains)
   %creating two points of transversal plain and draw line between them
   drawP1 = yinterp1(i,:)-0.5*pplains(i,:);
   drawP2 = yinterp1(i,:)+0.5*pplains(i,:);
   hold on
   plot([drawP1(1) drawP2(1)],[drawP1(2) drawP2(2)],'k')
end

end