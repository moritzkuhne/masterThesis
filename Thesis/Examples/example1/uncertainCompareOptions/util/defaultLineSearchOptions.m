function options = defaultLineSearchOptions(method)
%DEFAULTLINESEARCHOPTIONS Summary of this function goes here
%   Detailed explanation goes here

switch method
    case 'bisect'
        options = [];
    case 'step'
        options = [];
    otherwise
        error('option is not supported! Choose bisect or step.')
end

end

