function [feasibility,violation] = isDSOS(Q)
%ISDSOS this function checks for DSOS feasibility
%   PSDness, symmetry and DSOS constraint are tested in 
%   if PSDness or symmetry are violated, than Q is infeasible
%   violation of DSOS is marked but not treated as infeasible

feasibility = true;
violation = [];

%test eigenvalues
if ~all(eig(Q)>=0) == 1
    feasibility = false;
    violation = strcat(violation,'eigenvalues');
end

%test symmetry
if ~issymmetric(Q) == 1
    feasibility = false;
    if size(violation) == 0
        violation = strcat(violation,'symmetry');
    else 
        violation = strcat(violation,', symmetry');
    end
end

%test DSOS constraint
for i=1:size(Q,1)
    if 2*abs(Q(i,i))<sum(abs(Q(i,:))) %reformulation of DSOS constraint
        %feasibility = false;   
        if size(violation) == 0
            violation = strcat(violation,'DSOS');
        else
            violation = strcat(violation,', DSOS');
        end
        
        break
    end
end
