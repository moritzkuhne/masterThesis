function [options,string] = optionsByCounter(counter)
%%
    options.solverOptions.outputFlag = 0;
    options.rho = [0 0.5];
    options.lineSearchMethod = 'bisect';
    options.lineSearchMethodOptions = 'random'; 
    options.feasibilityTest = 'analytical';
    options.solver = @spot_gurobi;

%%
switch counter.method
    case 1
        options.method = @PsatzProg;
        string.method = 'PSatz';
    case 2
        options.method = @kSprocedureProg;
        options.methodOptions.k = 2;
        string.method = '2Sprocedure';
    case 3
        options.method = @kSprocedureProg;
        options.methodOptions.k = 3;
        string.method = '3Sprocedure';
    case 4
        options.method = @SprocedureProg;
        string.method = 'Sprocedure';
    case 5
        options.method = @HandelmanAndDSOSProg;
        string.method = 'HandelmanAndDSOS';
    case 6
        options.method = @HandelmanProg;
        string.method = 'HandelmanProg';
end

%%
switch counter.method_options
    case 2
        options.methodOptions.deg = 2;
        string.deg = '2';
    case 3
        options.methodOptions.deg = 3;
        string.deg = '3';
    case 4
        options.methodOptions.deg = 4;
        string.deg = '4';
    case 5
        options.methodOptions.deg = 5;
        string.deg = '5';
    case 6
        options.methodOptions.deg = 6;
        string.deg = '6';
    case 7
        options.methodOptions.deg = 7;
        string.deg = '7';
    case 8
        options.methodOptions.deg = 8;
        string.deg = '8';
end

%%
switch counter.solver_method
    case 1
        options.solverOptions.method = 0;
        string.solver_method = 'simplex';
    case 2
        options.solverOptions.method = 1;
        string.solver_method = 'barrier';
end

%%
switch counter.FeasibilityTol
    case 1
        options.solverOptions.FeasibilityTol = 1E-9;
        string.FeasibilityTol = '1E-9';
    case 2
        options.solverOptions.FeasibilityTol = 1E-6;
        string.FeasibilityTol = '1E-6';
    case 3
        options.solverOptions.FeasibilityTol = 1E-2;
        string.FeasibilityTol = '1E-2';
end

%%
switch counter.objective
    case 1
        options.objective = '0';
        string.objective = '0';
    case 2
        options.objective = 'Lyap'; 
        string.objective = 'Lyap';
    case 3
        options.objective = 'indets';
        string.objective = 'indets';
end
end

