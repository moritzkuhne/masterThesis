function [optimal_rho, optimal_V, solution] =...
    bilinearROAProg(V_initial,dx,x,inequalities,rho,method,deg,options)
%BILINEARROAPROG Its the start for an Bilinear Prog
%   Detailed explanation goes here

V = V_initial;
dV = diff(V,x)*dx;

convergence = false;
optimal_rho_rho=0;

while convergence == false

    [optimal_multiplier_rho,optimal_multiplier,multipler_solution] =...
        ROAMultiplierProg(dV,V,inequalities,rho,method,deg,options);
    optimal_multiplier_V = V;
    
    if multipler_solution.sol.isPrimalFeasible()
        multipler_solution.sol.isPrimalFeasible()
        if method == 'Sprocedure'
            [optimal_rho_rho,optimal_rho_V,rho_solution] = ...
                ROARhoProg(dx,x,inequalities,method,deg,optimal_multiplier,options);
                V = optimal_rho_V;
        else
            convergence = true;
        end

        if optimal_rho_rho-optimal_multiplier_rho <= 0.01
            convergence = true;
        end
    else
        convergence = true;
        optimal_multiplier_rho = 0; optimal_rho_rho;
        optimal_rho_V = optimal_multiplier_V;
        rho_solution = solROARhoprog.empty();
    end
        
end

solution.multiplier = multipler_solution;solution.rho = rho_solution;
optimal_rho = [optimal_multiplier_rho; optimal_rho_rho];
optimal_V = [optimal_multiplier_V; optimal_rho_V];

end

