function [Lyapunov_Candidate] = lyapunovCandidate(dynamicalSystem)
%LYAPUNOVCANDIDATE This function returns a lyapunov candidate for
%dynamicalSystem
%   The function returned is a quadratic form

[indet,~,~] = decomp(dynamicalSystem);

[~,A] = linearizeDynamicalSystem(dynamicalSystem);

P = lyap(A,eye(size(A)));

Lyapunov_Candidate = indet.'*P*indet;

end

