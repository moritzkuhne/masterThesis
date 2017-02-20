classdef solROAprog < handle
% An object of this class holds all solution information for an 
% ROA estimating problem via optimization

    properties (Access = public)
        
        system = dynamicalSystem.empty;
        options = struct.empty;
        
        rho = [];                   %certified rho value
        rho_extr = [];              %extreme rho value     
        sol = spotprogsol.empty;    %solution of recent optimization

    end
          
    methods
        
        function obj = solROAprog(system,options)
        
            if nargin == 1
                options = struct.empty;
                options.rho = [0 1];
            end
            
            obj.system = system;
            obj.rho = options.rho(1);
            obj.rho_extr = options.rho(2);
            obj.options = options;
        
        end
        
    end
    
end