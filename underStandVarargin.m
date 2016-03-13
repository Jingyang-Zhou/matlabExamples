function [] = underStandVarargin(varargin)


% EXAMPLE ------------------------------------------
exampleOn = 1;
exampleOn     = checkExampleOn(exampleOn, mfilename);

if exampleOn == 1
    varargin{1} = ones(3);
    varargin{2} = 'asd';
end
    

%% 

disp(sprintf('\nDisplay variables list :\n'))
disp(varargin)

end