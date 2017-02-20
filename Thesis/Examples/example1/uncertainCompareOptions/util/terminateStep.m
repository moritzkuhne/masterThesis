function terminate = terminateStep(solution,rho_try,~,~)
%TERMINATEBISECT Summary of this function goes here
%   Detailed explanation goes here

terminate = ~(rho_try < solution.rho_extr);

end

