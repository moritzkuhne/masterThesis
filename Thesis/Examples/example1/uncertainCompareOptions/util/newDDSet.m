function [prog,Qset] = newDDSet(prog,deg,n)
%NEWDDSET Returns a deg-by-deg-by-n msspoly array 
%   Along the dimensions n are DD matrixes e.g.:
%   newDDSet(2,2,2) returns an array Q where
%   Q(:,:,1) and Q(:,:,2) are 2-by-2 DD matrixes

Qset = cell(n,1);

for i=1:n
    [prog,Qset{i}] = prog.newDD(deg); 
end

end

