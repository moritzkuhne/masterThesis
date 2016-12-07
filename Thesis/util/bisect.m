function [newFirstBound] = bisect(firstBound,secondBound)
%BISECT bisects interval 
%   only accepts non-negative values for bounds
%   in case of negative bisection, transform coordinates i.e. xnew = -xold 
%   gives middle between firstBound into direction of secondBound

if firstBound<0 || secondBound<0   
    error('Bounds need to be non-negative.');
end
    
if firstBound > secondBound
    newFirstBound = 0.5*(firstBound-secondBound)+secondBound;
elseif firstBound < secondBound
    newFirstBound = 0.5*(secondBound-firstBound)+firstBound;
else
    warning('Both bounds are equal, no bisection possible!')
    newFirstBound = firstBound;

end

