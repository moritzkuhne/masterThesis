classdef linOptProg < optProg
% this is a subclass in the example OOP project

    methods (Access = public)
         
        function solveProg(prog)
            
            prog.sol = sedumi(prog.returnProperty('constrainA'),...
                prog.returnProperty('constrainb'),...
                prog.returnProperty('objectivec'));
            
        end
        
        function accessfunction(prog,a)
            
            if nargin == 1
            
                accessfunction@optProg(prog)
                return
                
            end
            
            disp(['accessfunction in linOptProg ' num2str(a)])
            
        end
          
    end
                  
end