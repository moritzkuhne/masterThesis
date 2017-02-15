function [rho_try,rho_failed] = bisectInterval(solution,feasibility,rho_try,rho_failed)
%BISECTINTERVAL Bisects interval for ROA estimation 
%   This function translate the intersection problem for ROA estimation
%   into a bisect problem, i.e. takes care of the correct interpretation
%   of sign in combination with the orthant. 
% rho_try = 0;            %current rho value up for optimization 
% rho_failed = rho_extr;  %smallest rho value for which prog. failed


if nargin < 4
    rho_failed = solution.rho_extr;
    warning('Include forth argument to increace bisection performance');
end

if ~(isa(solution,'solROAprog'))
    error('first argument needs to be an solROA object')
end

if ~islogical(feasibility)
    error('second input argument needs to be an logical')
end

switch solution.orthant

    case {'pos','symm'}
          if feasibility == 1
              solution.rho = rho_try;
%               rho_try = bisect(rho_try,rho_failed);
              rho_try = bisect(rho_try,rho_failed)+(0.5-rand)*(rho_try/100);
          else
              rho_failed = rho_try;
              rho_try = bisect(rho_try,solution.rho);
          end       
          
    case 'neg'
          if feasibility == 1
              solution.rho = rho_try; 
              rho_try = -bisect(-rho_try,-rho_failed); 
          else
              rho_failed = rho_try;
              rho_try = -bisect(-rho_try,-solution.rho);
          end
          
end

end

