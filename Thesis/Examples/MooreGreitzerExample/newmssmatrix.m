function [prog, H] = newmssmatrix(prog, n, monomials)

d = length(monomials);

v = n*(n+1)/2;

for k = 1:v
    [prog, z] = new(prog,d,'free');
    h(k) = z'*monomials;
end
H = mss_v2s(h);