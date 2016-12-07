classdef solROAprog < handle
% An object of this class holds all solution information for an 
% ROA estimating problem via optimization

    properties (Access = public)
        
        poly = msspoly.empty;       %polynomial tested to be PSD
        
        rho = 0;                   %certified rho value
        rho_extr = [];              %extreme rho value
        orthant = char.empty;       %search direction
       
        sol = spotprogsol.empty;    %solution of recent optimization

    end
          
    methods
        
        function obj = solROAprog(poly,rho_extr,orthant)
        
            if nargin == 2
                orthant = 'symm';
            end
            
            if nargin<2
                error('Not enough input arguments!')
            end
            
            if ~(isa(poly,'msspoly'))
                error('First argument needs to be an msspoly')
            end
            
            if ~(strcmp(orthant,'pos') || strcmp(orthant,'neg')...
                    || strcmp(orthant,'symm'))
                error(['third argument needs to be ','''pos'' ',...
                    '''neg'' ', 'or ','''symm''.']) 
            end

            switch orthant
            
                case {'pos', 'symm'}
                    if ~(rho_extr>=0) 
                        error(['Maximum rho needs to be ',...
                            'larger then initial rho.']);
                    end
                    
                case 'neg'
                    if ~(0>=rho_extr) 
                        error(['Minimum rho needs to be ',...
                            'smaller then initial rho.']);
                    end
                    
            end
            
            obj.poly = poly;
            obj.orthant = orthant;
            obj.rho_extr = rho_extr;

        
        end
        
    end
    
end