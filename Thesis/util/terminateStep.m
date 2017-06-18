function terminate = terminateStep(solution,rho_try,~,~)
%TERMINATEBISECT Terminates step search. 

terminate = ~(rho_try < solution.rho_extr);

end

