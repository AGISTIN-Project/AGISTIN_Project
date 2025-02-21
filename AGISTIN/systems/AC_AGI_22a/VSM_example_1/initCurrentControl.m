function [CC, VTFF, PLL] = initCurrentControl(LCL,FeedForwardU)

%% PLL
PLL.D  = 1;
PLL.T  = 0.04;
PLL.v0 = 1;
PLL.kp = 2*PLL.D/PLL.v0/PLL.T;
PLL.ki = 1/(PLL.v0*PLL.T^2);

FeedForwardU = false;
%% Current Control und Active Damping
if FeedForwardU
    VTFF.OmLead = 0;
    VTFF.OmLag  = 0;
    VTFF.EnableDQ = 0;
    VTFF.EnableCM = 0;
    
    CC.Kff = 1;
    CC.Tcc = 5e-3; % current controller desired equivalent PT1 time constant
else
    VTFF.OmLead = 2*pi*1;
    VTFF.OmLag  = 2*pi*1500;
    VTFF.EnableDQ = 1;
    VTFF.EnableCM = 0;
    
    CC.Kff = 0;
    CC.Tcc = 1e-3; % current controller desired equivalent PT1 time constant
end
PUomegab = LCL.PU.L1 / LCL.SI.L1 / (LCL.PU.R1 / LCL.SI.R1);

CC.kp =  LCL.PU.L1 / CC.Tcc / PUomegab;
CC.ki =  LCL.PU.R1 / CC.Tcc;
CC.xff = LCL.PU.L1;
CC.activate    = 0;
CC.init_uinv   = 0;
CC.i_sp_gain   = 0.5;
CC.i_set       = 1.2;
CC.i_reset     = 0.8;      %0.8;
