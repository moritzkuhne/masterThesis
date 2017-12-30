function evalAndPlot(optionsCell)
close all; clear all; clc;
%% setting the options
% constant over ALL solver_method, FeasibilityTol, objective
solver_method = 1; %1: simplex, 2: barrier
FeasibilityTol = 2; %1e-6
objective = 2; %Lyap

% option 1
method = 1; %Sprocedure

    %option 1.1
    counter11.method_options = 4;
    counter11.method = method;
    counter11.solver_method = solver_method;
    counter11.FeasibilityTol = FeasibilityTol;
    counter11.objective = objective;
    optionsCell{1} = counter11;

    %option 1.2
    counter12.method_options = 5;
    counter12.method = method;
    counter12.solver_method = solver_method;
    counter12.FeasibilityTol = FeasibilityTol;
    counter12.objective = objective;
    optionsCell{2} = counter12;

    %option 1.3
    counter13.method_options = 6;
    counter13.method = method;
    counter13.solver_method = solver_method;
    counter13.FeasibilityTol = FeasibilityTol;
    counter13.objective = objective;
    optionsCell{3} = counter13;

    %option 1.4
    counter14.method_options = 7;
    counter14.method = method;
    counter14.solver_method = solver_method;
    counter14.FeasibilityTol = FeasibilityTol;
    counter14.objective = objective;
    optionsCell{4} = counter14;
    
    %option 1.5
    counter15.method_options = 8;
    counter15.method = method;
    counter15.solver_method = solver_method;
    counter15.FeasibilityTol = FeasibilityTol;
    counter15.objective = objective;
    optionsCell{5} = counter15;
    
% option 3 
method = 2; %2Sprocedure

    %option 3.1
    counter31.method_options = 4;
    counter31.method = method;
    counter31.solver_method = solver_method;
    counter31.FeasibilityTol = FeasibilityTol;
    counter31.objective = objective;
    optionsCell{6} = counter31;

    %option 3.2
    counter32.method_options = 5;
    counter32.method = method;
    counter32.solver_method = solver_method;
    counter32.FeasibilityTol = FeasibilityTol;
    counter32.objective = objective;
    optionsCell{7} = counter32;

    %option 3.3
    counter33.method_options = 6;
    counter33.method = method;
    counter33.solver_method = solver_method;
    counter33.FeasibilityTol = FeasibilityTol;
    counter33.objective = objective;
    optionsCell{8} = counter33;

    %option 3.4
    counter34.method_options = 7;
    counter34.method = method;
    counter34.solver_method = solver_method;
    counter34.FeasibilityTol = FeasibilityTol;
    counter34.objective = objective;
    optionsCell{9} = counter34;   
    
    %option 3.5
    counter35.method_options = 8;
    counter35.method = method;
    counter35.solver_method = solver_method;
    counter35.FeasibilityTol = FeasibilityTol;
    counter35.objective = objective;
    optionsCell{10} = counter35;
    
    % option 2
method = 3; %3Sprocedure

    %option 2.1
    counter21.method_options = 4;
    counter21.method = method;
    counter21.solver_method = solver_method;
    counter21.FeasibilityTol = FeasibilityTol;
    counter21.objective = objective;
    optionsCell{11} = counter21;

    %option 2.2
    counter22.method_options = 5;
    counter22.method = method;
    counter22.solver_method = solver_method;
    counter22.FeasibilityTol = FeasibilityTol;
    counter22.objective = objective;
    optionsCell{12} = counter22;

    %option 2.3
    counter23.method_options = 6;
    counter23.method = method;
    counter23.solver_method = solver_method;
    counter23.FeasibilityTol = FeasibilityTol;
    counter23.objective = objective;
    optionsCell{13} = counter23;

    %option 2.4
    counter24.method_options = 7;
    counter24.method = method;
    counter24.solver_method = solver_method;
    counter24.FeasibilityTol = FeasibilityTol;
    counter24.objective = objective;
    optionsCell{14} = counter24;
    
    %option 2.5
    counter25.method_options = 8;
    counter25.method = method;
    counter25.solver_method = solver_method;
    counter25.FeasibilityTol = FeasibilityTol;
    counter25.objective = objective;
    optionsCell{15} = counter25;

%%
table = extractResults(optionsCell);

%%
plot1(optionsCell,table);

%% 
tablePlot1(optionsCell,table);

