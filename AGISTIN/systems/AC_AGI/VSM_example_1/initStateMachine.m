function SM = initStateMachine(EXEC_MODE)
%% Initialisation of state machine
SM.TsTimer        = 1/1000;
SM.TsStateMachine = 1/100;
switch EXEC_MODE
    case ExecutionMode.SIMULATION
        SM.TimeDelayConnect    = 0.1;       
        SM.TimeDelayDisconnect = 0.1;
        SM.RateLimitSimGain    = 10;        % Rate Limit Gain beschleunigt Simulation
        SM.SetpointSaveGain    = 1;         % Setpoint Save Gain reduziert maximal zulässige Setpoints
    case ExecutionMode.REALWORLD
        SM.TimeDelayConnect    = 3;
        SM.TimeDelayDisconnect = 1;
        SM.RateLimitSimGain    = 1;
        SM.SetpointSaveGain    = 0.5;
end