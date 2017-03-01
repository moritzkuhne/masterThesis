function [phi,dphi,ddphi] = motion(t)
%MOTION Summary of this function goes here
%   Detailed explanation goes here

T = 1;
k = 99;

phi = (cos((pi/T)*t))^k;
% CONSTRUCT ONE WHICH HAS SOME OSCILLATON IN THE PLATEAU TO ALLOW TAKING
% SOME SWING
dphi = 0;
ddphi = 0;

end

