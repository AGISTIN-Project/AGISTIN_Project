function Mgn = initVSMManagement(SM)
%% Management
Mgn.PQSpRateUp   = 0.5*SM.RateLimitSimGain; %pu/s
Mgn.PQSpRateDown = 0.5*SM.RateLimitSimGain; %pu/s
Mgn.PQSpMax      =  +1*SM.SetpointSaveGain; %pu/s
Mgn.PQSpMin      =  -1*SM.SetpointSaveGain; %pu/s