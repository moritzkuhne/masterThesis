
clear all;
close all;

%integrationsdauer t für die numerische integration (je länger desto mehr
%rechenzeit und desto länger die Trajektorien)
t=10;
hold on;

%festlegen des interesierenden Gebietes ( am Besten symmetrisch zu (0,0)
%waehlen)

%Positive x achse
a=3;

%positive y achse
b=3;

xlim([ -a a]);
ylim([ -b b]);
%auflösung des Intervalls
n=0.4;



[x,y]=meshgrid(-a:n:a,-b:n:b,2);

%!!!!!
% hier die DGl eingeben mit x,y % Dgl muss nochmal in rigid.m eingegeben
% werden. Dort aber als Gleichungssystem/Vektoren. Hier sind xp,yp,x,y
% Matrizen, was für den Befehl "quiver" notwendig ist
xp=x-y-x^3;
yp=y+x-y^3;
%!!!!!

%Vektorfeld erstellen
quiver(x,y,xp,yp,2);

d=length(y(1,:))

% hier findet die Integration mit den Anfangswerten statt, die äquidistant
% über das ganze Gitter verteilt sind. Kann sein, dass man dabei halt keine
% Polstelle trifft - bei Sinusfunktionsdgls z.b.
for ll=1:length(y(1,:))
for kk=1:length(x(1,:))
[T,Y] = ode45(@rigid,[0 t],[x(1,kk) y(ll,1)]);
for rr=1:length(Y(:,1))-1

%Hier wird der am Anfang interessierende Bereich geplottet. Falls die
%Integrationszeit t hochgeschraubt wird kanns sein dass die DGL mit einer
%Anfangsbedingung schon exlodiert ist, manche Linien im interessierenden Bereich aber noch länger werden.
% auf jeden Fall t nich zu hoch schrauben. Dauert einfach nur lange 
    if abs(Y(rr,1))<max(x(1,:)) && abs(Y(rr,2))<max(y(:,1))
plot(Y(rr:rr+1,1),Y(rr:rr+1,2));
    end

    %Falls man auf dem Raster eine Polstelle trifft wird die hier geplottet
if Y(1,1)==Y(end,1)
plot(Y(1,1),Y(1,2),'bo','color','red') % starting point
plot(Y(end,1),Y(end,2),'ks') % ending point
end
end
end
%Damit man weiß wie lange der PC mit den gemachten EInstellungen noch
%rechnet:
%Prozentuale Fertigstellung, falls man in der Konsole mit Strg+c abbrechen möchte
ll/d
end
