classdef solROAprog < handle
% An object of this class holds all solution information for an 
% ROA estimating problem via optimization

    properties (Access = public)
        
        poly = msspoly.empty;       %polynomial tested to be PSD
        
        rho = [];                   %certified rho value
        rho_extr = [];              %extreme rho value
       
        sol = spotprogsol.empty;    %solution of recent optimization
        options = struct.empty;
    end
          
    methods
        
        function obj = solROAprog(poly,options)
        
            if nargin == 1
                options = struct.empty;
                options.rho = [0 1];
            end
            
            if ~(isa(poly,'msspoly'))
                error('First argument needs to be an msspoly')
            end
            
            obj.poly = poly;
            obj.rho = options.rho(1);
            obj.rho_extr = options.rho(2);
            obj.options = options;
        
        end
        
    end
    
end