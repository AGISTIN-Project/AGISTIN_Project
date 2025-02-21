function [LCL, PU, ControlSampleTime, HWSampleTime] = initTPHardware(SIM_BRIDGE,PU)
%% PU System
if nargin < 2
    PU = pu(90e3, 400, 50*2*pi);
end

%% Simulation Mode and Timings
if nargout > 2
    ControlSampleTime = 1/8000;
    switch SIM_BRIDGE
        case SimBridgeMode.SWITCHED
            HWSampleTime = ControlSampleTime/500;
        case SimBridgeMode.AVERAGE
            HWSampleTime = ControlSampleTime/4;
    end
end

%% LCL Hardware
LCL.SI.R1 = 50e-3;
LCL.SI.R2 = 20e-3;
LCL.SI.Rc = 5e-3;
LCL.SI.L1 = 0.5e-3;
LCL.SI.L2 = 0.25e-3;
LCL.SI.C  = 47e-6;

LCL.PU.R1 = LCL.SI.R1 / PU.Zb;
LCL.PU.R2 = LCL.SI.R2 / PU.Zb;
LCL.PU.Rc = LCL.SI.Rc / PU.Zb;
LCL.PU.L1 = LCL.SI.L1 / PU.Lb;
LCL.PU.L2 = LCL.SI.L2 / PU.Lb;
LCL.PU.C  = LCL.SI.C  / PU.Cb;
end