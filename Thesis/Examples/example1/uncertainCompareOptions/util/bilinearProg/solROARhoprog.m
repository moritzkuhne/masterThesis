classdef solROARhoprog < handle
% An object of this class holds all solution information for an 
% ROA estimating problem via optimization

    properties (Access = public)
        
        rho = 0;                   %certified rho value
        sol = spotprogsol.empty;    %solution of recent optimization

    end
    
end