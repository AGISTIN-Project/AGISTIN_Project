%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AGISTIN WP5 - Green hydrogen production
% Plant components 
% Author: Christoph Kaufmann (Fraunhofer IWES)
% Date: 30.01.2026

% The model of the photovoltaic model is partially based on
% EPRI, "Model User Guide for Generic Renewable Energy System
% Models: 3002027129," tech. rep., Palo Alto, CA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%% PV Plant %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
PV.Prated=50e3;   % rated active power (W)
PV.Srated=50e3;   % rated apparent power (VAr) 

PV.Vrms=400;      % line-to-line rms voltage (V)
PV.Vp=PV.Vrms*sqrt(2/3); % line-to-neutral peak voltage (V)

PV.Zbase=PV.Vrms^2/PV.Srated; % base impedance  (Ohms)
PV.Lbase=PV.Zbase/(2*pi*50);   % base inductance (H)

PV.Ip=PV.Prated/(3*PV.Vrms)*sqrt(2);

% Filter
PV.Rc=0.005*PV.Zbase; % 
% PV.Rsw=0.01e-3; % (Ohm) switching losses, internal resistance of the converter 
PV.Lc=0.15*PV.Lbase;

% % 2-level IGBT Converter
PV.Vdc=750; % DC-link voltage (V)

% Controller - REEC_A

% Active power controller
PV.Tpord=0.0015; % Power order lag time constant (s)

PV.Pmax=1;
PV.Pmin=0;

PV.Ipmin=0; 
PV.Ipmax=1;

PV.dPmax=1; % REEC_A
PV.dPmin=-1;


%% Reactive power controller - REEC_A

PV.PfFlag=1;
PV.Tp=0.01; % Active power filter constant (s)
PV.Tiq=0.004; % Reactive current regulator lag time constant (s)

% QFlag=1 constant Q-control
PV.Qext=0;
PV.QFlag=0;
PV.tQact=0.3; % activation time of the Q-controller 
PV.Vref1=1;

PV.Iqmin=-0.6; 
PV.Iqmax=0.6; 

PV.Kvp=0; % Local voltage regulator proportional gain (p.u.)
PV.Kvi=1; % Local voltage regulator integral gain (p.u.)

PV.Vmin=0.86; 
PV.Vmax=1.14;

%% Voltage dip controller - REEC_A

PV.Vdip=0.9; % Low voltage condition trigger voltage (pu)
PV.Vup=1.1; % High voltage condition trigger voltage (pu)

PV.Trv=0.02; %Terminal bus voltage filter time constant (s)
PV.Vref0=1; % Reference voltage for reactive current injection (V)

PV.dbd1=-0.1; % Over-voltage deadband for reactive current injection ()
PV.dbd2=0.1; % Under-voltage deadband for reactive current injection

PV.Kqv=2;  %Reactive current injection gain (pu/pu) 

PV.Iqh1=2.0;  % Maximum reactive current injection (pu on mbase)
PV.Iql1=-2.0; % Minimum reactive current injection (pu on mbase)


% Current limit logic
PV.Imax=1;

% PLL tuning
PV.Vp_pu=1;
PV.PLL.ts=0.1;  
PV.PLL.xi=0.707; %damping ratio

PV.PLL.omega=4/(PV.PLL.ts*PV.PLL.xi);
PV.PLL.tau=2*PV.PLL.xi/PV.PLL.omega;

PV.PLL.kp=PV.PLL.xi*2*PV.PLL.omega/PV.Vp;
PV.PLL.ki=PV.PLL.kp/PV.PLL.tau;

% Current controller
PV.CC.tau=1e-3;  % time constant 
PV.CC.Kp=PV.Lc/PV.CC.tau;
PV.CC.Ki=PV.Rc/PV.CC.tau;


