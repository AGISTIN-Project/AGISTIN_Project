%% Script for Daniels test grid

%% park impedance

SCR = 7;
XtoR = 10;

%SCR = 5;
%XtoR = 3;

Grid = initGrid(VSMCTRL.PU, SCR, XtoR);             % Warning: not very precise calculation due to rounding!

%% external Grid + fault impedance + PCC load
XR = 50;
SCR = 200*10;
U_sc = 0.5-0.48*0-0.4*0; 
extGrid = extGridSC(VSMCTRL, XR, SCR, U_sc);

P_load = 30e3;
Q_load = 5e3;

%% fault time

t_fault = 10;
t_fault_end = 0.2;
fault_dur = t_fault_end;