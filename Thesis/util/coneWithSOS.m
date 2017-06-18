function [combinatorials] = coneWithSOS(inequalities,deg)
%coneWithSOS creates cone with DSOS i.e. with finite length of polynomials
%   this function does not use multiplicativeMonoid since it can operate
%   faster due to its finite length
%
%   furthermore it does not return a '1' at its first entry
%   itt does NOT generate a cone with
%   DSOS finite expression but only the LHS of the Positivstellensatz
%   polynomials which are preceeded with SOS multipliers


if nargin < 2
    deg = length(inequalities);
end

if deg > length(inequalities)
   warning(['Degree of coupling in cone with SOS multipliers can''','t'...
            'be higher than number of inequalities. ', 'Degree is set to'...
            ' number of inequalities.'])
        
   deg = length(inequalities);
end

% preloop assignments 
pos = [1:length(inequalities)]; %1 accords to first elem of polynomials 
comb = []; % creating all combinatorials, encoded in position

for i=1:deg
    
    c = combnk(pos,i); %creates all combinations to degree i
    %c = sort(c,2);  %sorts along second direction, e.g. 1 2 1 -> 1 1 2
    
    comb(:,end+1) = zeros(length(comb),1);%keeps dim of comb vector consice
    comb = [comb;c];  %removes multiples and adds to comb
    
end

%preloop assignments
t = msspoly('t',1); %creates temp. mss poly to set type for array
combinatorials = ones(length(comb),1)*monomials(t,0); %creates a mss multiplicative identity element

for i=1:length(comb)    %for each row in comb, one combinatorial of fi
    for j=1:size(comb,2)%multiplies elements along a row of comb
        if ~comb(i,j)==0 %zeros are skipped as they do not accord to fi
            combinatorials(i) = combinatorials(i)*inequalities(comb(i,j));
        end
    end
end

end

