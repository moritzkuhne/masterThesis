function [method,deg,degP,options] = methodOptionsROAProg(options)
%METHODOPTIONSROAPROG Returns default options for formulation details.

if isfield(options,'method')
   method = options.method;
else 
    method = @SprocedureProg;
    options.method = method;
end

if ~isfield(options,'methodOptions')
    options.methodOptions = struct();
end
    if isfield(options.methodOptions,'deg')
        deg = options.methodOptions.deg;
    else
        deg = 2;
        options.methodOptions.deg = deg;
    end

if ~isfield(options,'methodOptions')
    options.methodOptions = struct();
end
    if isfield(options.methodOptions,'degP')
        degP = options.methodOptions.degP;
    else
        degP = 2;
        options.methodOptions.degP = degP;
    end   
    
if isequal(method,@kSprocedureProg)
    if ~isfield(options.methodOptions,'k')
        options.methodOptions.k = 2;
    end
end

end