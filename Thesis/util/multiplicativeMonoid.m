%to do: should pass back the comb vector, such that I do no need 
%       recalculateevery time

function [combinatorials] = multiplicativeMonoid(polynomials,deg)
%MULTIPLICATIVEMONOID creates multiplicative monoid of mss polynomials
%   combines input arguments up to degree(of combination) deg
%   e.g. f1 = x^2, deg=2 returns f1^2 
%   consider degree of the polynomials
%


% preloop assignments 
pos = []; %1 accords to first elem of polynomials 
comb = []; % creating all combinatorials, encoded in position

for i=1:deg
    
    pos = [pos 1:length(polynomials)]; %enables combinations like f1^2
    
    c = combnk(pos,i); %creates all combinations to degree i
    c = sort(c,2);  %sorts along second direction, e.g. 1 2 1 -> 1 1 2
    
    comb(:,end+1) = zeros(length(comb),1);%keeps dim of comb vector consice
    comb = [comb;unique(c,'rows')];  %removes multiples and adds to comb
    
end

%preloop assignments
t = msspoly('t',1); %creates temp. mss poly to set type for array
combinatorials = ones(length(comb),1)*monomials(t,0); 

for i=1:length(comb)    %for each row in comb, one combinatorial of fi
    for j=1:size(comb,2)%multiplies elements along a row of comb
        if ~comb(i,j)==0 %zeros are skipped as they do not accord to fi
            combinatorials(i) = combinatorials(i)*polynomials(comb(i,j));
        end
    end
end

combinatorials = [monomials(t,0); combinatorials]; %adds fi^0 = 1 to the combinatorials

end

