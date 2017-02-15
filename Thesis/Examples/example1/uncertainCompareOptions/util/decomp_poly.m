%to do: poly is considered to be linear, what happens when poly is affine!
%       it should work by now

function [A,b] = spot_decomp_poly(poly,vdecision)
%decompose polynomials linear in decision variables into set of linear
%constraints on the decision variable
%
%   arguments in:
%
%   poly -- a polynomial in msspolys and linear in vall
%   vall -- list of all decision variables
%
%   output argubemts
%   
%   A -- an n-by-length(vall) matrix
%   b -- an n-by-1 vector
%   satisfying: A*vall = b
%
%   Constraints fulfill A*vall
%
%   This function does preprocessing before calling spot_decomp_linear


    %decomp poly, satisfying:
    %poly = sum_k Ceq(k) prod_j veq(j)^peq(k,j)
    %with k=1..number of terms in poly, and j=1..number of msspoly in poly
    %Ceq gives factor, veq are all msspoly in poly
    %and rows of pow are powers of polys per term appearing in poly
    [v,pow,Ceq] = decomp(poly);   
    
    vIndices = match(vdecision,v);   
    %gives positions of decision variable
    vdecisionIndices = find(vIndices~=0);
    %gives positions of indeterminates
    indetIndices = find(vIndices==0);
    
    %checking of poly is linear in vall
    %poly is linear in vall iff the powers of vall needs to sum up to 1 per
    %term
    if ~all(sum(pow(:,vdecisionIndices),2)<=1)
        error('polynomial is not affine in decision variables!')
    
    %if poly is linear in vall, then continue
    else
        %determining unique combinations of indeterminates
        powUnique = unique(pow(:,indetIndices),'rows');
        
        A = sparse(length(powUnique),length(vdecision));
        b = sparse(length(powUnique),1);
        %recomp linear terms of same indeterminate combination
        for i=1:size(powUnique,1)
            
            %searching the rows for same occurence of indet combination
            powMultiple = find(pow(:,indetIndices)==powUnique(i));
            
            %selecting rows of peq and colomns of Ceq according to peqMult.
            lin = recomp(v(vdecisionIndices)...
                ,pow(powMultiple,vdecisionIndices),Ceq(powMultiple));
            
            [A(i,:),b(i)] = spot_decomp_linear(lin,vdecision);
                
        end
        
    end
end    


