function DCCC = initDCCC(LCL,SM)

DCCC = initHSS(LCL,SM);
% In Simulation nicht stabil dafür im Labor
DCCC.VDC.kp = 15; %nach labor 31.07: 10->15
DCCC.VDC.ki = 1050;
[DCCC.CC, DCCC.VTFF, DCCC.PLL] = initCurrentControl(LCL,false); % Feedforward U = false