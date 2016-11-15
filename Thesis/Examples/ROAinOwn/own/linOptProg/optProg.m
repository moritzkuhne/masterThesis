classdef optProg < handle
% this is a basic class the example OOP project

    properties (Access = protected)
        
        sol = [];
        
    end

    properties (Access = private) 
        
        % objective function
        c = [];
        
        % constraints
        A = []; 
        b = [];
        
    end
    
    methods (Access = public)
        
        function value = returnProperty(prog,property)
            %property can be out of 'objectivec', 'constrainA', 'constrainb'  
            
            switch property
                case 'objectivec'
                    value = prog.c;
                case 'constrainA'
                    value = prog.A;
                case 'constrainb'
                    value = prog.b;
                case 'OpSolution'
                    value = prog.sol;
                otherwise
                    disp('invalid property requested, chose from objectivec, constrainA, constrainb or OpSolution')
            end
          
        end
        
        function value = assignProperty(prog,property,value)
            
            switch property
                case 'objectivec'
                    prog.c = value;
                case 'constrainA'
                    prog.A = value;
                case 'constrainb'
                    prog.b = value;
                otherwise
                    disp('invalid property requested, chose from objectivec, constrainA or constrainb')
            end
            
        end
        
        function accessfunction(prog)
        
            disp('accessfunction in optProg')
            
        end
          
    end
                   
end