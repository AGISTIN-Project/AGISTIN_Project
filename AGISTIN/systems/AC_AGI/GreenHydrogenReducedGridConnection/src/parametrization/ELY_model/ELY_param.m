%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AGISTIN WP5 - Green hydrogen production
% Plant components 
% Author: Christoph Kaufmann (Fraunhofer IWES)
% Date: 30.01.2026
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%% Electrolyzer %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% General parameters

ELY.Prated=25e3;           % rated active power (W)
ELY.Srated=25e3;           % rated apparent power (VAr) 


ELY.Vrms=400;              % line-to-line low voltage grid connection (V)
ELY.Vp=ELY.Vrms*sqrt(2/3); % line-to-neutral voltage amplitude/peak (V)

ELY.Imax=ELY.Srated/(3*ELY.Vrms/sqrt(3)); % RMS maximum current per phase (A)
ELY.Imax_p=ELY.Imax*sqrt(2); % peak maximum current per phase (A)

ELY.Zbase=ELY.Vrms^2/ELY.Srated; % base impedance  (Ohms)
ELY.Lbase=ELY.Zbase/(2*pi*50);   % base inductance (H)
ELY.Cbase=1/(ELY.Zbase*2*pi*50); % base capcitance (F)

% Filter
ELY.Rc=0.01*ELY.Zbase;
ELY.Lc=0.15*ELY.Lbase;
ELY.Cc=0.066*ELY.Cbase;

% Converter 
ELY.fsw=10e3; % switching frequency (Hz) 

ELY.Vdc=780; % DC-link voltage 
ELY.tau_dc=40e-3; % Time to maintain the power on the dc link (s)

ELY.Cdc.cf=1e2; 
ELY.Cdc.param=10*7800e-6;


%% Converter control

% PLL tuning % 
% S.-K. Chung, ‘‘A phase tracking system for three phase utility interface
%inverters,’% IEEE Trans. Power Electron., vol. 15, no. 3, pp. 431–438,
%May 2000
ELY.PLL.ts=0.1;  % time constant
ELY.PLL.zeta=1/sqrt(2); %damping ratio
ELY.PLL.omega=4/(ELY.PLL.ts*ELY.PLL.zeta);
ELY.PLL.kp=2*ELY.PLL.zeta*ELY.PLL.omega/ELY.Vp;
ELY.PLL.tau=2*ELY.PLL.zeta/ELY.PLL.omega;
ELY.PLL.ki=ELY.PLL.kp/ELY.PLL.tau;

% VSC 1
fg=50;
ksw1 = 27;                       % Switching ratio (number of times the AC frequency)
wsw1 =2*pi*ELY.fsw ;             % Converter angular switching-frequency 
wc = wsw1/10;                    % current-loop bandwidth
wpq = wc/10;                     % power-loop bandwidth
wdc = wc/10;                     % DC voltage loop banddiwth

% DC voltage controller (Agusti et al, 2012, p. 15)
ELY.DCV.omega=2*pi*1/0.1; % angular velocity of the DC voltage loop
ELY.DCV.zeta=0.707; % damping ration
ELY.DCV.Kp=ELY.Cdc.param*ELY.DCV.zeta*ELY.DCV.omega; 
ELY.DCV.Ki=ELY.Cdc.param*ELY.DCV.omega^2/2;

% Current controller
ELY.CC.Lf=ELY.Lc; % inductance considered for tuning, depending on the point of measurment
ELY.CC.Rf=ELY.Rc; % resistance considered for tuning

Vbasepu=326;
Ibasepu=50e3/(Vbasepu);


ELY.CC.tau=1/(ELY.fsw/10); % time constant 
ELY.CC.Kp=ELY.CC.Lf/ELY.CC.tau;
ELY.CC.Ki=ELY.CC.Rf/ELY.CC.tau;



%% DC/DC controller
% General

ELY.DCDC.Vout=150;
ELY.DCDC.d=ELY.DCDC.Vout/ELY.Vdc;
ELY.DCDC.Imax=400; % (A)

ELY.DCDC.fsw=5e3;

ELY.DCDC.L=1e-3; % inductor of the buck converter
ELY.DCDC.R_L=0.0002; % parasitic resistor

ELY.DCDC.C=252.4e-6; %capacitor of the buck converter
ELY.DCDC.R_C=0.02; % parasitic resistor

ELY.DCDC.R_C=0.02;

% bandwidths
ELY.DCDC.CC.wCC=2*pi*ELY.DCDC.fsw/10;
ELY.DCDC.VC.wVC=ELY.DCDC.CC.wCC/10;

% Current controller 
ELY.DCDC.CC.Kp=9.4;
ELY.DCDC.CC.Ki=120;

% Full Bridge DC/DC Converter
 P_fb=50e3;     % rated power
 Vi_fb=4e3;      % input voltage


 ELY.DCDC.VC.Kp=10;
 ELY.DCDC.VC.Ki=1;

ELY.DCDC.P.ramp.upperlimit=100000; 
ELY.DCDC.P.ramp.lowerlimit=-100000;
 
ELY.stack.Vstack=171; 
ELY.stack.R=1e-3;




