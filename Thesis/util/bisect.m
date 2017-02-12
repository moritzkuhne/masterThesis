function rho_try = bisect(solution,rho_failed,~)
%BISECT bisects interval with random point between interval

rho = solution.rho;

if rho<0 || rho_failed<0   
    error('Bounds need to be non-negative.');
end
    
if rho < rho_failed
    rho_try = rho + rand*(rho_failed-rho);
else
    warning('Rho is larger than Rho_failed. This is not possible.')
end

