classdef dynamicalSystem < handle
% An object of this class holds all information for an dynamical system
% which are needed for ROA estimatioin via DSOS optimization. 

    properties (Access = public)
        
        dx = [];
        inequCon = [];
        equCon = [];
        
        states = [];
        parameters = [];

        V = [];
        rho = [];
    end
          
    methods
        
        function obj = dynamicalSystem(dx,inequCon,equCon,states,parameters,V)
                    
            obj.dx = dx;
            obj.inequCon = inequCon;
            obj.equCon = equCon;
            obj.states = states;
            obj.parameters = parameters;

            if nargin < 6
                obj.V =  findCandidate(obj);
            else
                obj.V = V;
            end
        end
        
        function V = findCandidate(obj)
            [~,A] = linearizeDynamicalSystem(obj);
            Q = eye(length(obj.states)); 
            size(A)
            size(Q)
            P = lyap(A,Q); P = 1/det(P)*P;
            
            V = obj.states.'*P*obj.states;
        end
        
    end
    
end