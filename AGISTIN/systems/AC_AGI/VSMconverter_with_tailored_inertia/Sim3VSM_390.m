clear;
clc;

parameterrun.setting = 'UDI';           %Alternativen: UDI oder BDI

parameterrun.version = '390';

% For manual tests: 
%parameterrun.dFF = [1 1 1 1 1 1 1 920];    %Beispiel tailor-paper Frequenzanstieg
%parameterrun.dFF = [4 2 1 1 1 1 1 826];    %Beispiel tailor-paper Frequenzabfall mit sym. shaping
parameterrun.dFF = [4 2 1 1 1 1 1 827];    %Beispiel tailor-paper Frequenzabfall mit asym. shaping
%parameterrun.dFF = [1 2 1 1 1 1 1 301];   % Beispiel für paper C-GFM&Tp


parameterset.GeneralIslandingTime = 0;  % 4  0=auto, see sim3runxxx.m
parameterset.time_to_loadstep = 1;   % 0.65
parameterset.time_after_islanding = 7;  % > time_to_loadstep !!

if ~isfield (parameterrun,'dFF')
    %parameterrun.dFF =  fullfact ([5 2 2 1 1 3 3]); % define dFF as fullfactorial matrix
    % parameterrun.dFF =  fullfact ([5 2 2 1 1 3 1]); % define dFF as fullfactorial matrix
    parameterrun.dFF =  fullfact ([5 2 2 1 1 5 5]); % define dFF as fullfactorial matrix
    %parameterrun.dFF =  fullfact ([5 1 2 1 1 5 5]); % define dFF as fullfactorial matrix
    %parameterrun.dFF(:,8) = 907+101-parameterrun.dFF(:,2)*101;
    %parameterrun.dFF = dFF_delete([1 0 0 0 0 0 0],parameterrun.dFF);
    %parameterrun.dFF = dFF_delete([2 0 0 0 0 0 0],parameterrun.dFF);
    %parameterrun.dFF = dFF_delete([3 0 0 0 0 0 0],parameterrun.dFF);
    parameterrun.dFF = dFF_delete([0 1 0 0 0 0 0],parameterrun.dFF);
    % Next 4 lines must always be executed!
    parameterrun.dFF = dFF_delete([0 0 0 0 0 4 4],parameterrun.dFF);
    parameterrun.dFF = dFF_delete([0 0 0 0 0 4 5],parameterrun.dFF);
    parameterrun.dFF = dFF_delete([0 0 0 0 0 5 4],parameterrun.dFF);
    parameterrun.dFF = dFF_delete([0 0 0 0 0 5 5],parameterrun.dFF);
    parameterrun.dFF(:,8) = 824;
    %parameterrun.dFF = dFF_delete([0 1 0 0 0 0 0;0 0 0 2 0 0 0;0 0 0 3 0 0 0;0 0 0 4 0 0 0;0 0 0 0 2 0 0],parameterrun.dFF);
    %parameterrun.dFF = dFF_delete([0 0 2 0 0 2 0;0 0 2 0 0 3 0;0 0 2 0 0 0 2;0 0 2 0 0 0 3],parameterrun.dFF);
    %parameterrun.dFF([51:end],:) = [];
    %parameterrun.dFF([1 11 21],:) = [];
end

    
clear(strcat('sim3run_',parameterrun.version)); % see https://uk.mathworks.com/matlabcentral/answers/360769-call-function-when-the-function-name-is-saved-in-variable
feval(strcat('sim3run_',parameterrun.version));

 