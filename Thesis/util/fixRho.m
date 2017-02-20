function [rho_try,options] = fixRho(solution,rho_failed,options)
%FIXRHO A new rho_try is determined in this function
%   Detailed explanation goes here

if isfield(options,'lineSearchMethod')
    switch options.lineSearchMethod
        case 'bisect'
            method = @bisect;
        case 'step'
            method = @step;
        otherwise
            error('option is not supported! Choose bisect or step.')
    end
else 
    method = @bisect;
    options.lineSearchMethod = 'bisect';
end

if ~isfield(options,'lineSearchMethodOptions')
    options.lineSearchMethodOptions = ...
        defaultLineSearchOptions(options.lineSearchMethod);
end

methodOptions = options.lineSearchMethodOptions;

rho_try = method(solution,rho_failed,methodOptions);

end

