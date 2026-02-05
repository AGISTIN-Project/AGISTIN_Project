%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AGISTIN WP5 - Green hydrogen production
% Plant components 
% Author: Christoph Kaufmann (Fraunhofer IWES)
% Date: 19.12.2023

% Grid-forming model: The grid-forming converter is based on the generic
% grid-forming model avaible here https://github.com/l2ep-epmlab/VSC_Lib 
% 
% C. Cardozo et al., "Promises and challenges of grid forming: Transmission 
% system operator, manufacturer and academic view points," Electric Power
% Systems Research, Volume 235, 2024, doi: 10.1016/j.epsr.2024.110855


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%% ESS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% General parameters
ESS.Prated=25e3;              % rated active power of one converter unit (W)
ESS.Srated=25e3;              % rated apparent power of one converter unit (VAr) 

ESS.Vrms=400;                 % line-to-line low voltage grid connection (V)
ESS.Vp=ESS.Vrms*sqrt(2/3);    % line-to-neutral voltage amplitude/peak (V)

ESS.Imax=ESS.Prated*sqrt(2)/(3*ESS.Vrms);

Ug = 400; % Nominal Grid Voltage (V)

% %% PLL 
 fb=50;
 wb = 2*pi*fb;


% %% GFM Lille
Time_Step=exe.tstep;

Lc_pu = 0.15;           % per unit in grid base
Rc_pu = Lc_pu/10; 

% Filter time constant 
Tau_f = 0.01;


Enable_Lv = 0;

Lc_virt = (0.15-Lc_pu)*Enable_Lv;

Cf_pu = 0.066;
Lf_pu = Lc_pu;
Rf_pu = 0;

% Pole placement method 
Trp = 1*1e-3;

wn_cc = 1200;
Ki_cc_cp = wn_cc*Rc_pu; 
Kp_cc_cp = wn_cc*Lc_pu/wb; 



VSC01_mp1 = 0.0043;         % gain of the power loop 
VSC01_wc1 = wb/10;          % low-pass  filter  cut-frequency 

Lc_pu = 0.15;           % per unit in grid base
Rc_pu = Lc_pu/10; 

n=1;m=-1;

W_TVR = 60;


   