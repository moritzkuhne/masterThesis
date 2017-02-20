function [method,deg,options] = methodOptionsROAProg(options)
%METHODOPTIONSROAPROG Summary of this function goes here
%   Detailed explanation goes here

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

if isequal(method,@kSprocedureProg)
    if ~isfield(options.methodOptions,'k')
        options.methodOptions.k = 2;
    end
end

end