function [prog,V,dV,freeV] = bilinearV(prog,dx,x,inequalities)
%BILINEARV This function produces a new Lyapunov candidate
%   Detailed explanation goes here

z = monomials(x,1:2);
[prog,freeV] = prog.newFree(length(z)); V = freeV.'*z;

indet = prog.indeterminates;
deg = 1; warning('still need to pass the degree for the multipliers in V generation!')
z = monomials(indet,0:deg);
[prog,Qset] = prog.newDDSet(length(z),length(inequalities));

    for i=1:length(inequalities)
        
        if ~exist('S', 'var')
            S = (z.'*Qset{i}*z)*inequalities(i);
        else
            S = S + (z.'*Qset{i}*z)*inequalities(i);
        end
        
    end


prog = prog.withDSOS(V-S);
dV = diff(V,x)*dx;

end

