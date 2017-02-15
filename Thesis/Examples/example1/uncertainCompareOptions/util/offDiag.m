% to do: fix this whole file

function [offDiagSum] = offDiag(Q)
%OFFDIAG sums the off diagonal terms
%   Detailed explanation goes here
    offDiagSum = 0.5*(sum(sum(Q,1))-sum(diag(Q)));
end

