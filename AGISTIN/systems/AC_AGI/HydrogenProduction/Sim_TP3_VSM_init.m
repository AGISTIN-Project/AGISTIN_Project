%IncludeTPPaths
if ~exist('EXEC_MODE','var')
    EXEC_MODE=ExecutionMode.REALWORLD; %Sim Models set EXEC_MODE to Simulatio
end
%% Init Hardware
SM = initStateMachine(EXEC_MODE);
SIM_BRIDGE = SimBridgeMode.AVERAGE;
[LCL, PU, ControlSampleTime, HWSampleTime] = initTPHardware(SIM_BRIDGE);

Grid = initGrid(PU,'Labor');                % R & L are not very precise because of rounding 
Grid.Ulow = 1;

%% Init DC Control
DCCC = initDCCC(LCL,SM);
DCCC.PWM.tauT = 2*ControlSampleTime;
DCCC.PU = PU;

%% Init AC Control
VSM = initVSM;
VSMCTRL.SP       = initSetpoint;
[CC, VTFF, PLL]  = initCurrentControl(LCL,false); % Feedforward U = false
VTFF.OmLead = 0;
CC.Active = 0;
VSMCTRL.Mgn = initVSMManagement(SM);
VSMCTRL.CC = CC;
VSMCTRL.PLL = PLL;
VSMCTRL.PWM.tauT = 2*ControlSampleTime;
VSMCTRL.VTFF = VTFF;
VSMCTRL.VSM = VSM;
VSMCTRL.PU = PU;
VSMCTRL.VC = initVirtualCircuit(0,0);

clear CC PLL VC VSM VTFF %PU

%% for logging
Ts = ControlSampleTime;

%% Activate Fallback Current Limiter
VSMCTRL.CC.Active = 1; % this seems to be unused?
VSMCTRL.CC.activate = 1;
VSMCTRL.CC.i_sp_gain = 0;

%% configure virtual impedance
VSMCTRL.VC.L1 = 0.11;
VSMCTRL.VC.R1t = -0.13;
VSMCTRL.VC.R1 = 0.13;
VSMCTRL.VC.L1t = 0;         % bei der jetzigen Implementierung eines Tiefpasses, lässt sich kein statisches Verhalten erreichen, wenn nicht gleich 0
% VSMCTRL.VC.tauR

%% external Grid
% XR = 50;
% SCR = 50;
% U_sc = 0.7; 
% extGrid = extGridSC(VSMCTRL, XR, SCR, U_sc);
V_DC = 720;
Ipwm_off=1.2;
Ipwm_back=1.2;
scaling_factor=1/15e4;
Oversample=1;
HWSampleTime = ControlSampleTime / Oversample;
TestNetz