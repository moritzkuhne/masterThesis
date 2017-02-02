%A = [0 1; -1 -1];

A = [-1 -1 0; 0 1 0; 0 0 0];

% A = sparse(4,4);
% A(1,2) = 1;
% A(2,2) = -1;
% A(2,3) = -1;

setlmis([])
P = lmivar(1,[3 1]);

lmiterm([-1 1 1 P],1,1); %P>0
lmiterm([2 1 1 P],A',1) % A'P <0
lmiterm([2 1 1 P],1,A) % PA <0

lmis = getlmis;

[tmin,xfeas] = feasp(lmis);
P_double = dec2mat(lmis,xfeas,P)