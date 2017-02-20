function rho_try = bisect(solution,rho_failed,options)
%BISECT bisects interval with random point between interval

rho = solution.rho;

switch options
    
    case 'random'
        h = rand;
        
    case 'determined'
        h = 0.5;
        
    otherwise 
        warning(['lineSearchMethodOption is not'...
            'supported. Change to random.']);
        h = rand;
        
end

if rho<0 || rho_failed<0   
    error('Bounds need to be non-negative.');
end
    
if rho < rho_failed
    rho_try = rho + h*(rho_failed-rho);
else
    warning('Rho is larger than Rho_failed. This is not possible.')
end

