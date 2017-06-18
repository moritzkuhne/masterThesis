function [terminate,options] = isTerminate(solution,rho_try,rho_failed,options)
%ISTERMINATE This function determines if the while loop is terminated

if isfield(options,'lineSearchMethod')
    switch options.lineSearchMethod
        case 'bisect'
            method = @terminateBisect;
        case 'step'
            method = @terminateStep;
        otherwise
            error('option is not supported! Choose bisect or step.')
    end
else 
    method = @terminateBisect;
    options.lineSearchMethod = 'bisect';
end

if ~isfield(options,'lineSearchMethodOptions')
    options.lineSearchMethodOptions = ...
        defaultLineSearchOptions(options.lineSearchMethod);
end

methodOptions = options.lineSearchMethodOptions;

terminate = method(solution,rho_try,rho_failed,methodOptions);

end

