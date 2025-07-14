function HSS = initHSS(LCL,SM)
%% NO PU
HSS.Mgn.UDCbusSpMax      = 720; %V
HSS.Mgn.UDCbusSpMin      = 500; %V
HSS.Mgn.UDCbusSpRateUp   = 50*SM.RateLimitSimGain; %V/s
HSS.Mgn.UDCbusSpRateDown = 50*SM.RateLimitSimGain; %V/s

%% PU
HSS.VDC.kp = 3.5;
HSS.VDC.ki = 350;
HSS.CC.kp = 0.35;
HSS.CC.ki = 70;