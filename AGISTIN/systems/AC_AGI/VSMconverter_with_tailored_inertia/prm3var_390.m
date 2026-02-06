%% parameters for 3(5) VSMs

% WICHTIG!! Unterschied zu 5VSMs-Modell: Hier ist
% - sp_Q = prm_vsm(51,:) und nicht mehr prm_vsm(6,:)
% - Prated_pu = prm_vsm(6,:)
% vcm_calc wird nicht verwendet.

Pbase_sys = 40e6;   % p.u. base for active power, set for 110 kV

if parameterset.RoCoFup == 1
    prm_vsm(6,:) = {'Prated_pu' 1 1 1 1 1};
else
    % prm_vsm(6,:) = {'Prated_pu' 0.5 1 0.75 1 1};
    prm_vsm(6,:) = {'Prated_pu' 1 1 1 1 1};
end    
if parameterset.simulation == "301"
    prm_vsm(6,:) = {'Prated_pu' 1 0.6 2 1 1};
end    

pu_vsm(1,:) = pu(Pbase_sys*((General.Vnreg/110e3)^1.15), General.Vnreg, 2*pi*50);                      % pu for the System
pu_vsm(2,:) = pu(prm_vsm{6,2}*Pbase_sys*((General.Vnreg/110e3)^1.15), General.Vnreg, 2*pi*50);                    % pu for VSM2 (angepasst)
pu_vsm(3,:) = pu(prm_vsm{6,3}*Pbase_sys*((General.Vnreg/110e3)^1.15), General.Vnreg, 2*pi*50);                    % pu for VSM3 (angepasst)
pu_vsm(4,:) = pu(prm_vsm{6,4}*Pbase_sys*((General.Vnreg/110e3)^1.15), General.Vnreg, 2*pi*50);                   % pu for VSM4 (angepasst)
pu_vsm(5,:) = pu(prm_vsm{6,5}*Pbase_sys*((General.Vnreg/110e3)^1.15), General.Vnreg, 2*pi*50);                   % pu for VSM5 (angepasst)
pu_vsm(6,:) = pu(prm_vsm{6,6}*Pbase_sys*((General.Vnreg/110e3)^1.15), General.Vnreg, 2*pi*50);                      % pu for VSM6

%dP_max_pu = 0.6;

Li.Cll  = pu_vsm(1).Cb*200*0.02;    %  0:001  %  0.273;                     %[uF/km] capacitance per km
Li.Clg  = pu_vsm(1).Cb*4000*2;    % 0.02 % >=0.015

pu_load.P.Bus2 = 1;   % max. 1.32 p.u.

%VSM Array
if RoCoFup == 1
    prm_vsm(1,:) = {'sp_P' 1 0.58 0.58 0 0};
    prm_vsm(51,:) = {'sp_Q' 0 0 0 0 0};
else
    %prm_vsm(1,:) = {'sp_P' -1 0.5 -1 0 0};
    prm_vsm(1,:) = {'sp_P' -1 1 0 0 0};
    prm_vsm(51,:) = {'sp_Q' 0 0 0 0 0};
end

if UDI == 1
    prm_vsm(2,:) = {'P_lim_fall'  max(0,prm_vsm{1, 2})+1-sign(max(0,prm_vsm{1, 2}))  max(0,prm_vsm{1, 3})+1-sign(max(0,prm_vsm{1, 3}))  max(0,prm_vsm{1, 4})+1-sign(max(0,prm_vsm{1, 4}))  0 0};
    prm_vsm(3,:) = {'P_lim_rise'  min(0,prm_vsm{1, 2})-1-sign(min(0,prm_vsm{1, 2}))  min(0,prm_vsm{1, 3})-1-sign(min(0,prm_vsm{1, 3}))  min(0,prm_vsm{1, 4})-1-sign(min(0,prm_vsm{1, 4}))  0 0};
elseif BDI == 1
    prm_vsm(2,:) = {'P_lim_fall'  1  1  1  0  0};
    prm_vsm(3,:) = {'P_lim_rise' -1 -1 -1  0  0};
else
    prm_vsm(2,:) = {'P_lim_fall'  1  1  1  1  1};
    prm_vsm(3,:) = {'P_lim_rise' -1 -1 -1 -1 -1};
end

               % values negative or zero 
prm_vsm(4,:) = {'DeltaP_lim_rise' prm_vsm{3, 2}-prm_vsm{1, 2} prm_vsm{3, 3}-prm_vsm{1, 3} prm_vsm{3, 4}-prm_vsm{1, 4} prm_vsm{3, 5}-prm_vsm{1, 5} prm_vsm{3, 6}-prm_vsm{1, 6}};
               % values positive or zero
prm_vsm(5,:) = {'DeltaP_lim_fall' prm_vsm{2, 2}-prm_vsm{1, 2} prm_vsm{2, 3}-prm_vsm{1, 3} prm_vsm{2, 4}-prm_vsm{1, 4} prm_vsm{2, 5}-prm_vsm{1, 5} prm_vsm{2, 6}-prm_vsm{1, 6}};
prm_vsm(7,:) = {'xvfactor' 1.5/max(0.2, abs(prm_vsm{1, 2}))^0.5 1.5/max(0.2, abs(prm_vsm{1, 3}))^0.5 1.5/max(0.2, abs(prm_vsm{1, 4}))^0.5 1.5/max(0.2, abs(prm_vsm{1, 5}))^0.5 1.5/max(0.2, abs(prm_vsm{1, 6}))^0.5};

prm_vsm(11,:) = {'OmLead' 2*pi*50 2*pi*50 2*pi*50 2*pi*50 2*pi*50};
prm_vsm(12,:) = {'OmLag' 2*pi*1100 2*pi*1100 2*pi*1100 2*pi*1100 2*pi*1100};
prm_vsm(13,:) = {'tau_rv' 1/(20*2*pi) 1/(20*2*pi) 1/(20*2*pi) 1/(20*2*pi) 1/(20*2*pi)};
prm_vsm(14,:) = {'rv' 0.13*3 0.13*3 0.13*3 0.13*3 0.13*3};
prm_vsm(15,:) = {'xv' 0.11 0.11 0.11 0.11 0.11};  % p.u.
% prm_vsm(16,:) = {'T_imp' ... see behind row 23
prm_vsm(17,:) = {'Tp_min' 10 10 10 10 10}; % is only valid if dynTp,base = on
prm_vsm(18,:) = {'dynTp,base' 0 0 0 0 0}; % 1=on 0=off dynamic modification of Tp,base
prm_vsm(19,:) = {'Phi0' 0 0 0 0 0};

vsm_Tdaco = 0.01;  % Integrator gain not possible via index
ddfmax = 60;  % Hz/s/s  for DampComp
TVRint = 0.85;   % s   0.5 s

prm_vsm(8,:) = {'Tp_rise0' 0 28  0  0 0};
prm_vsm(9,:) = {'Tp_fall0' 0  0 56  0 0};
% row 10 see behind row 23
%prm_vsm(10,:) = {'Tp_base' 30 30 30 max(prm_vsm{8,5},prm_vsm{9,5}) max(prm_vsm{8,6},prm_vsm{9,6})};

prm_vsm(38,:) = {'relPref' 1 1 1 1 1};  % only values 0 and 1 allowed
prm_vsm(39,:) = {'modify swingback Tp' 0 0 0 0 0};  % only values 0 and 1 allowed
prm_vsm(50,:) = {'accelerate swingback' 0 0 0 0 0};  % only values 0 and 1 allowed

prm_vsm(58,:) = {'RoCoF_rise0' 0   0   0   0 0};
prm_vsm(59,:) = {'RoCoF_rise1' 0.2 1.0 0.2 0.2 0.2};
prm_vsm(60,:) = {'RoCoF_rise2' 0.3 1.5 0.3 0.3 0.3};
prm_vsm(61,:) = {'RoCoF_rise3' 1   5   1   1 1};
prm_vsm(62,:) = {'RoCoF_rise4' 1.5 5   1.5 1.5 1.5};
prm_vsm(63,:) = {'RoCoF_rise9' 5   5   5   4 4};
prm_vsm(64,:) = {'RoCoF_fall0' 0 0 0 0 0};
prm_vsm(65,:) = {'RoCoF_fall1' -0.2 -0.2 -0.2 -0.2 -0.2};
prm_vsm(66,:) = {'RoCoF_fall2' -0.3 -0.3 -0.3 -0.3 -0.3};
prm_vsm(67,:) = {'RoCoF_fall3' -1 -1 -1 -1 -1};
prm_vsm(68,:) = {'RoCoF_fall4' -1.5 -1.5 -1.5 -1.5 -1.5};
prm_vsm(69,:) = {'RoCoF_fall9' -5 -5 -5 -4 -4};

prm_vsm(20,:) = {'Tp_rise2' 0  4 0  4 4};
prm_vsm(21,:) = {'Tp_rise9' 0  4 0  4 4};
prm_vsm(22,:) = {'Tp_fall2' 35 0 21 4 4};
prm_vsm(23,:) = {'Tp_fall9' 4  0 4  4 4};
%vsm_calc(6,:) = {'Tp_base' max([prm_vsm{8,2:6}], ([prm_vsm{8,2:6}].*[prm_vsm{59,2:6}]+[prm_vsm{20,2:6}].*([prm_vsm{61,2:6}]-[prm_vsm{60,2:6}])+([prm_vsm{8,2:6}]+[prm_vsm{20,2:6}])/2.*([prm_vsm{60,2:6}]-[prm_vsm{59,2:6}]))./[prm_vsm{61,2:6}])};
%tmparr = max([prm_vsm{8,2:6}], ([prm_vsm{8,2:6}].*[prm_vsm{59,2:6}]+([prm_vsm{8,2:6}]+[prm_vsm{20,2:6}])/2.*([prm_vsm{60,2:6}]-[prm_vsm{59,2:6}])+[prm_vsm{20,2:6}].*([prm_vsm{61,2:6}]-[prm_vsm{60,2:6}]))./[prm_vsm{61,2:6}], ([prm_vsm{8,2:6}].*[prm_vsm{59,2:6}]+([prm_vsm{8,2:6}]+[prm_vsm{20,2:6}])/2.*([prm_vsm{60,2:6}]-[prm_vsm{59,2:6}])+[prm_vsm{20,2:6}].*([prm_vsm{61,2:6}]-[prm_vsm{60,2:6}])+([prm_vsm{20,2:6}]+[prm_vsm{21,2:6}])/2.*([prm_vsm{62,2:6}]-[prm_vsm{61,2:6}])+[prm_vsm{21,2:6}].*([prm_vsm{63,2:6}]-[prm_vsm{62,2:6}]))./[prm_vsm{63,2:6}], [prm_vsm{9,2:6}], ([prm_vsm{9,2:6}].*[prm_vsm{65,2:6}]+([prm_vsm{9,2:6}]+[prm_vsm{22,2:6}])/2.*([prm_vsm{66,2:6}]-[prm_vsm{65,2:6}])+[prm_vsm{22,2:6}].*([prm_vsm{67,2:6}]-[prm_vsm{66,2:6}]))./[prm_vsm{67,2:6}], ([prm_vsm{9,2:6}].*[prm_vsm{65,2:6}]+([prm_vsm{9,2:6}]+[prm_vsm{22,2:6}])/2.*([prm_vsm{66,2:6}]-[prm_vsm{65,2:6}])+[prm_vsm{22,2:6}].*([prm_vsm{67,2:6}]-[prm_vsm{66,2:6}])+([prm_vsm{22,2:6}]+[prm_vsm{23,2:6}])/2.*([prm_vsm{68,2:6}]-[prm_vsm{67,2:6}])+[prm_vsm{23,2:6}].*([prm_vsm{69,2:6}]-[prm_vsm{68,2:6}]))./[prm_vsm{69,2:6}]);
tmparr_r = max([prm_vsm{8,2:6}], ([prm_vsm{8,2:6}].*[prm_vsm{59,2:6}]+([prm_vsm{8,2:6}]+[prm_vsm{20,2:6}])/2.*([prm_vsm{60,2:6}]-[prm_vsm{59,2:6}])+[prm_vsm{20,2:6}].*([prm_vsm{61,2:6}]-[prm_vsm{60,2:6}]))./[prm_vsm{61,2:6}]);
tmparr_r = max(tmparr_r, ([prm_vsm{8,2:6}].*[prm_vsm{59,2:6}]+([prm_vsm{8,2:6}]+[prm_vsm{20,2:6}])/2.*([prm_vsm{60,2:6}]-[prm_vsm{59,2:6}])+[prm_vsm{20,2:6}].*([prm_vsm{61,2:6}]-[prm_vsm{60,2:6}])+([prm_vsm{20,2:6}]+[prm_vsm{21,2:6}])/2.*([prm_vsm{62,2:6}]-[prm_vsm{61,2:6}])+[prm_vsm{21,2:6}].*([prm_vsm{63,2:6}]-[prm_vsm{62,2:6}]))./[prm_vsm{63,2:6}]);
tmparr_f = max([prm_vsm{9,2:6}], ([prm_vsm{9,2:6}].*[prm_vsm{65,2:6}]+([prm_vsm{9,2:6}]+[prm_vsm{22,2:6}])/2.*([prm_vsm{66,2:6}]-[prm_vsm{65,2:6}])+[prm_vsm{22,2:6}].*([prm_vsm{67,2:6}]-[prm_vsm{66,2:6}]))./[prm_vsm{67,2:6}]);
tmparr_f = max(tmparr_f, ([prm_vsm{9,2:6}].*[prm_vsm{65,2:6}]+([prm_vsm{9,2:6}]+[prm_vsm{22,2:6}])/2.*([prm_vsm{66,2:6}]-[prm_vsm{65,2:6}])+[prm_vsm{22,2:6}].*([prm_vsm{67,2:6}]-[prm_vsm{66,2:6}])+([prm_vsm{22,2:6}]+[prm_vsm{23,2:6}])/2.*([prm_vsm{68,2:6}]-[prm_vsm{67,2:6}])+[prm_vsm{23,2:6}].*([prm_vsm{69,2:6}]-[prm_vsm{68,2:6}]))./[prm_vsm{69,2:6}]);
tmparr = max(tmparr_r.*(-[prm_vsm{4,2:6}].*[prm_vsm{38,2:6}]-[prm_vsm{38,2:6}]+1), tmparr_f.*([prm_vsm{5,2:6}].*[prm_vsm{38,2:6}]-[prm_vsm{38,2:6}]+1));
tmparr = max(tmparr, [10 10 10 10 10]);
tmparr = min(tmparr, [30 30 30 30 30]);
prm_vsm(10,:) = {'Tp_base0' tmparr(1) tmparr(2) tmparr(3) tmparr(4) tmparr(5)};
%prm_vsm(10,:) = {'Tp_base' max(prm_vsm{8, 2}/prm_vsm{59, 2})/ 30 30 30 max(prm_vsm{8,5},prm_vsm{9,5}) max(prm_vsm{8,6},prm_vsm{9,6})};
tmparr = [0.0013 0.0013 0.0013 0.0013 0.0013];
tmparr = max(tmparr, [0.001 0.001 0.001 0.001 0.001]+[prm_vsm{10,2:6}]*0.00001);
prm_vsm(16,:) = {'T_imp' tmparr(1) tmparr(2) tmparr(3) tmparr(4) tmparr(5)};

%prm_vsm(24,:) = {'kpf' 0 0 0 0 0};   % not in use
prm_vsm(25,:) = {'kdf' 0.1 0.1 0.1 0.1 0.1};
prm_vsm(26,:) = {'ku' 0 0 0 0 0};
prm_vsm(27,:) = {'Tu' 1 1 1 1 1};
prm_vsm(28,:) = {'dampcomp_on' 1 1 1 1 1};
prm_vsm(29,:) = {'damping amplification' 0.5 0.5 0.5 0.5 0.5};
prm_vsm(30,:) = {'dyn_state' 2.6 2.6 2.6 2.6 2.6};
% row 31 see behind row 40

% ad_einit = 0.28;
% prm_vsm(32,:) = {'Einit' 1.045+ad_einit 1.01+ad_einit 1.07+ad_einit-0.1 1.09+ad_einit-0.01 1.06+ad_einit-0.1};

% okay für simulation7
% ad_einit = 0.25;
% prm_vsm(32,:) = {'Einit' 1.045+ad_einit 1.01+ad_einit 1.07+ad_einit-0.1 1.09+ad_einit-0.01 1.06+ad_einit-0.07};

% okay für simulation721
ad_einit = 0.15;
prm_vsm(32,:) = {'Einit' 1+ad_einit 1+ad_einit 1+ad_einit 1+ad_einit 1+ad_einit};

prm_vsm(33,:) = {'f0' General.fn General.fn General.fn General.fn General.fn};

prm_vsm(34,:) = {'dE_dyn' 0 0 0 0 0};
prm_vsm(35,:) = {'dE_step' 0 0 0 0 0};

prm_vsm(36,:) = {'Uinit_max' 1.03 1.03 1.03 1.03 1.03};
prm_vsm(37,:) = {'Uinit_min' 1.02 1.02 1.02 1.02 1.02};

%rows 38+39 see above

%prm_vsm(XX,:) = {'tauT' 1/8000 1/8000 1/8000 1/8000};
%prm_vsm(XX,:) = {'TS' prm_vsm{32,2} prm_vsm{32,3} prm_vsm{32,4} prm_vsm{32,5}};

%Parameter RLC VSM
prm_vsm(40,:) = {'L1'   0.0884*pu_vsm(2).Lb 0.0884*pu_vsm(3).Lb 0.0884*pu_vsm(4).Lb 0.0884*pu_vsm(5).Lb 0.0884*pu_vsm(6).Lb};                        %0.5e-3;                                %[H] corresponds to 0.088 pu
prm_vsm(31,:) = {'gain' 1 1 1 1 1};  % for RoCoF up
%prm_vsm(31,:) = {'gain' 1.54 1.41 1.41 2 2};  % for RoCoF up
%prm_vsm(31,:) = {'gain' ((prm_vsm{15,2}*prm_vsm{7,2}+prm_vsm{40,2}/pu_vsm(2).Lb)/prm_vsm{15,2}/prm_vsm{7,2}-1)*0.5+1  ((prm_vsm{15,3}*prm_vsm{7,3}+prm_vsm{40,3}/pu_vsm(3).Lb)/prm_vsm{15,3}/prm_vsm{7,3}-1)*0.5+1  ((prm_vsm{15,4}*prm_vsm{7,4}+prm_vsm{40,4}/pu_vsm(4).Lb)/prm_vsm{15,4}/prm_vsm{7,4}-1)*0.5+1  (prm_vsm{15,5}*prm_vsm{7,5}+prm_vsm{40,5}/pu_vsm(5).Lb)/prm_vsm{15,5}/prm_vsm{7,5}  (prm_vsm{15,6}*prm_vsm{7,6}+prm_vsm{40,6}/pu_vsm(6).Lb)/prm_vsm{15,6}/prm_vsm{7,6}};
prm_vsm(41,:) = {'L2'   0.0442*pu_vsm(2).Lb 0.0442*pu_vsm(3).Lb 0.0442*pu_vsm(4).Lb 0.0442*pu_vsm(5).Lb 0.0442*pu_vsm(6).Lb};    %delete unit Transformer (+TrU.L)       %[H] additional L in lines next to VCIs, corresponds to 0.044 pu
prm_vsm(42,:) = {'C'    0.0257*pu_vsm(2).Cb 0.0257*pu_vsm(3).Cb 0.0257*pu_vsm(4).Cb 0.0257*pu_vsm(5).Cb 0.0257*pu_vsm(6).Cb};     %46e-6;                                %[F]   corresponds to 0.0257 pu
prm_vsm(43,:) = {'R1'   0.0562*pu_vsm(2).Zb 0.0562*pu_vsm(3).Zb 0.0562*pu_vsm(4).Zb 0.0562*pu_vsm(5).Zb 0.0562*pu_vsm(6).Zb};    %0.1; including semiconductor losses    %[Ohm]  corresponds to 0.0562 pu
prm_vsm(44,:) = {'R2'   0.0112*pu_vsm(2).Zb 0.0112*pu_vsm(3).Zb 0.0112*pu_vsm(4).Zb 0.0112*pu_vsm(5).Zb 0.0112*pu_vsm(6).Zb};    %delete unit Transformer (+TrU.R)       %[Ohm] additional R in lines next to VCIs, corresponds to 0.0112 pu
prm_vsm(45,:) = {'Rc'   0.00281*pu_vsm(2).Zb 0.00281*pu_vsm(3).Zb 0.00281*pu_vsm(4).Zb 0.00281*pu_vsm(5).Zb 0.00281*pu_vsm(6).Zb};%0.005;                                 %[ohm] serial R of C, corresponds to 0.0281 pu
prm_vsm(46,:) = {'LFSM-O_T_delay' 0.6667 0.6667 0.6667 0.6667 0.6667};   %s  must not be 0
prm_vsm(47,:) = {'LFSM-U_T_delay' 0.6667 0.6667 0.6667 0.6667 0.6667};   %s  must not be 0

%UFLS VSM
prm_vsm(48,:)  = {'UFLS_state' 0 0 0 0 0};
% necessary only for the 3-VSM model
prm_vsm(49,:) = {'effective Ta at -1 Hz/s' prm_vsm{9,2} prm_vsm{9,3} prm_vsm{9,4} prm_vsm{9,5} prm_vsm{9,6}};

%secondary control
prm_vsm(52,:) = {'seccontrol_gain' 0 0 0 0 100*100e6/pu_vsm(6).Sb};  %nicht verwendet
prm_vsm(53,:) = {'seccontrol_DeltaPmax' 0 0 0 0 0.5};  % in p.u. of the machine
prm_vsm(54,:) = {'seccontrol_DeltaPmin' 0 0 0 0 -0.5};  % in p.u. of the machine
T_seccontrol = 20;

%primary control
prm_vsm(55,:) = {'LFSM-O_gain'      0 0 0 0 0};
prm_vsm(56,:) = {'primcontrol_gain' 0 0.0000*0.03*pu_load.P.Bus2*pu_vsm(1).Sb/pu_vsm(3).Sb/abs(prm_vsm{1,3})/(0.2/50) 0 0 0};
prm_vsm(57,:) = {'LFSM-U_gain'      0.6/(0.2/50) 0.6/(0.2/50) 0.6/(0.2/50) 0 0};

% LFSM start and end values of f deviation
prm_vsm(70,:) = {'LFSM-O_fdev_start' 0.2 0.2 0.2 0.2 0.2};
prm_vsm(71,:) = {'LFSM-O_fdev_end'   1.5 1.5 1.5 1.5 1.5};
prm_vsm(72,:) = {'LFSM-U_fdev_start' -0.2 -0.2 -0.2 -0.2 -0.2};
prm_vsm(73,:) = {'LFSM-U_fdev_end'   -0.8 -0.8 -0.8 -0.8 -0.8};
prm_vsm(74,:) = {'LFSM relPset'   1 1 1 1 1};

prm_vsm(77,:) = {'f_min' 40/50 40/50 40/50 40/50 40/50};
prm_vsm(78,:) = {'f_max' 60/50 60/50 60/50 60/50 60/50};

prm_vsm(82,:) = {'Iconfine_fall' 0 0 0 0 0};
%prm_vsm(82,:) = {'Iconfine_fall' 0 0 0 0 0};
prm_vsm(81,:) = {'Iconfine_rise' 0 0 0 0 0};
%prm_vsm(81,:) = {'Iconfine_rise' 0 0 0 0 0};
prm_vsm(83,:) = {'Iconfine_threshold' 0.04 0.04 0.04 0.04 0.04};

mutal_inductance_lv = 0;
mutal_inductance_hv = 0;
lowvoltage_def.LL = 1e-2;
lowvoltage_def.LG = 3e-2;
Voltagetime = 0.001;%ControlSampleTime*8; %0.001;
int_sup_vol1 = parameterset.General.Vnreg;

load_start_factor = 1;

%% parameter for 11 Loads

%parameter
%buffersize = 1024*3;
pos_array = 2;

FB_area1_uplim = 49.8;
FB_area1_downlim = 49.5;
FB_area2_uplim = 49.5;
FB_area2_downlim = 49.2;

pu_load.P.Bus2 = 1.4;
pu_load.P.Bus3 = 0.942*0.5;
pu_load.P.Bus4 = 0.478;
pu_load.P.Bus5 = 0.076;

pu_load.P.Bus6 = 0.112*0.5;
pu_load.P.Bus7 = 0;
pu_load.P.Bus8 = 0;
pu_load.P.Bus9 = 0.295;
pu_load.P.Bus10 = 0.09;
pu_load.P.Bus11 = 0.035;
pu_load.P.Bus12 = 0.061;
pu_load.P.Bus13 = 0.135;
pu_load.P.Bus14 = 0.149;

pu_load.Q.Bus2 = 0.127;
pu_load.Q.Bus3 = 0.19;
pu_load.Q.Bus4 = -0.039;
pu_load.Q.Bus5 = 0.016;
pu_load.Q.Bus6 = 0.075;
pu_load.Q.Bus7 = 0;
pu_load.Q.Bus8 = 0;
pu_load.Q.Bus9 = 0.166;
pu_load.Q.Bus10 = 0.058;
pu_load.Q.Bus11 = 0.018;
pu_load.Q.Bus12 = 0.016;
pu_load.Q.Bus13 = 0.058;
pu_load.Q.Bus14 = 0.05;

%Calculation Load

pu_fb1_factor = 1/12;
pu_fb2_factor = 1/12;
pu_var_factor = 1/12; 
pu_con_factor = 1-pu_var_factor-pu_fb2_factor-pu_fb1_factor;

if pu_con_factor < 0
    disp('PConstFactor darf nicht 0 sein')
    return
else
end


QLoadFactor = 1;
%Load Array
prm_load(1,:) = {'pu_fb1_step'   pu_load.P.Bus2*pu_fb1_factor pu_load.P.Bus3*pu_fb1_factor pu_load.P.Bus4*pu_fb1_factor pu_load.P.Bus5*pu_fb1_factor pu_load.P.Bus6*pu_fb1_factor 0 0 pu_load.P.Bus9*pu_fb1_factor pu_load.P.Bus10*pu_fb1_factor pu_load.P.Bus11*pu_fb1_factor pu_load.P.Bus12*pu_fb1_factor pu_load.P.Bus13*pu_fb1_factor pu_load.P.Bus14*pu_fb1_factor};
prm_load(2,:) = {'pu_fb2_step'   pu_load.P.Bus2*pu_fb2_factor pu_load.P.Bus3*pu_fb2_factor pu_load.P.Bus4*pu_fb2_factor pu_load.P.Bus5*pu_fb2_factor pu_load.P.Bus6*pu_fb2_factor 0 0 pu_load.P.Bus9*pu_fb2_factor pu_load.P.Bus10*pu_fb2_factor pu_load.P.Bus11*pu_fb2_factor pu_load.P.Bus12*pu_fb2_factor pu_load.P.Bus13*pu_fb2_factor pu_load.P.Bus14*pu_fb2_factor};
prm_load(3,:) = {'pu_var'        pu_load.P.Bus2*pu_var_factor pu_load.P.Bus3*pu_var_factor pu_load.P.Bus4*pu_var_factor pu_load.P.Bus5*pu_var_factor pu_load.P.Bus6*pu_var_factor 0 0 pu_load.P.Bus9*pu_var_factor pu_load.P.Bus10*pu_var_factor pu_load.P.Bus11*pu_var_factor pu_load.P.Bus12*pu_var_factor pu_load.P.Bus13*pu_var_factor pu_load.P.Bus14*pu_var_factor};
prm_load(4,:) = {'pu_indust'     0 0 0 0 0 0 0 0 0 0 0 0 0};
prm_load(5,:) = {'pu_konst'      pu_load.P.Bus2*pu_con_factor pu_load.P.Bus3*pu_con_factor pu_load.P.Bus4*pu_con_factor pu_load.P.Bus5*pu_con_factor pu_load.P.Bus6*pu_con_factor 0 0 pu_load.P.Bus9*pu_con_factor pu_load.P.Bus10*pu_con_factor pu_load.P.Bus11*pu_con_factor pu_load.P.Bus12*pu_con_factor pu_load.P.Bus13*pu_con_factor pu_load.P.Bus14*pu_con_factor};
prm_load(6,:) = {'pu_Q'          pu_load.Q.Bus2*QLoadFactor pu_load.Q.Bus3*QLoadFactor pu_load.Q.Bus4*QLoadFactor pu_load.Q.Bus5*QLoadFactor pu_load.Q.Bus6*QLoadFactor 0 0 pu_load.Q.Bus9*QLoadFactor pu_load.Q.Bus10*QLoadFactor pu_load.Q.Bus11*QLoadFactor pu_load.Q.Bus12*QLoadFactor pu_load.Q.Bus13*QLoadFactor pu_load.Q.Bus14*QLoadFactor};

prm_load(10,:) = {'anteil_step_fb1_low'     1/3 1/3 1/3 1/3 1/3 0 0 1/3 1/3 1/3 1/3 1/3 1/3};
prm_load(11,:) = {'anteil_step_fb1_medium'  1/3 1/3 1/3 1/3 1/3 0 0 1/3 1/3 1/3 1/3 1/3 1/3};
prm_load(12,:) = {'anteil_step_fb1_high'    };

prm_load(13,:) = {'anteil_step_fb2_low'     1/3 1/3 1/3 1/3 1/3 0 0 1/3 1/3 1/3 1/3 1/3 1/3};
prm_load(14,:) = {'anteil_step_fb2_medium'  1/3 1/3 1/3 1/3 1/3 0 0 1/3 1/3 1/3 1/3 1/3 1/3};
prm_load(15,:) = {'anteil_step_fb2_high'    };

prm_load(16,:) = {'anteil_var_low'          1/3 1/3 1/3 1/3 1/3 0 0 1/3 1/3 1/3 1/3 1/3 1/3};
prm_load(17,:) = {'anteil_var_medium'       1/3 1/3 1/3 1/3 1/3 0 0 1/3 1/3 1/3 1/3 1/3 1/3};
prm_load(18,:) = {'anteil_var_high'         };

while pos_array <= length(prm_load(10,:))                                   % die Anteile von step_fb1, step_fb2 und var werden zu 100% aufgefüllt
    prm_load{12,pos_array}=(1-prm_load{10,pos_array}-prm_load{11,pos_array});
    prm_load{15,pos_array}=(1-prm_load{13,pos_array}-prm_load{14,pos_array});
    prm_load{18,pos_array}=(1-prm_load{16,pos_array}-prm_load{17,pos_array});
    if prm_load{12,pos_array} < 0
        disp('"anteil_step_fb1_high" darf nicht negativ sein')              %abbruch falls einer der Anteile negativ wird
        return
    elseif prm_load{15,pos_array} < 0
        disp('"anteil_step_fb2_high" darf nicht negativ sein')
        return
    elseif prm_load{18,pos_array} < 0
        disp('"anteil_var_high" darf nicht negativ sein')
        return
    else 
    end
    pos_array = pos_array + 1;
end
pos_array = 2;

prm_load(20,:) = {'del_step_load_low'     0.05 0.05 0.05 0.05 0.05 0 0 0.05 0.05 0.05 0.05 0.05 0.05};
prm_load(21,:) = {'del_step_load_medium'  0.1 0.1 0.1 0.1 0.1 0 0 0.1 0.1 0.1 0.1 0.1 0.1};
prm_load(22,:) = {'del_step_load_high'    0.15 0.15 0.15 0.15 0.15 0 0 0.15 0.15 0.15 0.15 0.15 0.15};

prm_load(23,:) = {'del_var_load_low'      0.05 0.05 0.05 0.05 0.05 0 0 0.05 0.05 0.05 0.05 0.05 0.05};
prm_load(24,:) = {'del_var_load_medium'   0.1 0.1 0.1 0.1 0.1 0 0 0.1 0.1 0.1 0.1 0.1 0.1};
prm_load(25,:) = {'del_var_load_high'     0.15 0.15 0.15 0.15 0.15 0 0 0.15 0.15 0.15 0.15 0.15 0.15};

prm_load(32,:) = {'UFLS_state'              0 0 0 0 0 0 0 0 0 0 0 0 0};

prm_load(33,:) = {'Vnom'                  int_sup_vol1 int_sup_vol1 int_sup_vol1 int_sup_vol1 int_sup_vol1 int_sup_vol1 int_sup_vol1 int_sup_vol1 int_sup_vol1 int_sup_vol1 int_sup_vol1 int_sup_vol1 int_sup_vol1};

p_load_ges = (pu_load.P.Bus2 + pu_load.P.Bus3 + pu_load.P.Bus4 + pu_load.P.Bus5 + pu_load.P.Bus6 + pu_load.P.Bus9 + pu_load.P.Bus10 + pu_load.P.Bus11 + pu_load.P.Bus12 + pu_load.P.Bus13 + pu_load.P.Bus14) * pu_vsm(1).Sb;
TVint = 0.05;

%delete Variable
clear pos_array pu_fb1_factor pu_fb2_factor pu_var_factor pu_con_factor

%% parameter for Lines

Vn1 = General.Vnreg;
%Pbase = VCI.Sn;
fn = General.fn;

%Pu-Values
%69kV Grid
pu_line.L12.R = 0.01938;                                                    % pu_Wert
pu_line.L15.R = 0.05403;                                                    % pu_Wert
pu_line.L23.R = 0.04699;                                                    % pu_Wert
pu_line.L24.R = 0.05811;                                                    % pu_Wert
pu_line.L25.R = 0.05695;                                                    % pu_Wert
pu_line.L34.R = 0.06701;                                                    % pu_Wert
pu_line.L45.R = 0.01335;                                                    % pu_Wert

pu_line.L12.X = 0.05917;                                                    % pu_Wert
pu_line.L15.X = 0.22304;                                                    % pu_Wert
pu_line.L23.X = 0.19797;                                                    % pu_Wert
pu_line.L24.X = 0.17632;                                                    % pu_Wert
pu_line.L25.X = 0.17388;                                                    % pu_Wert
pu_line.L34.X = 0.17103;                                                    % pu_Wert
pu_line.L45.X = 0.04211;                                                    % pu_Wert

pu_line.L12.B = 0.0528;                                                     % pu_Wert
pu_line.L15.B = 0.0492;                                                     % pu_Wert
pu_line.L23.B = 0.0438;                                                     % pu_Wert
pu_line.L24.B = 0.0374;                                                     % pu_Wert
pu_line.L25.B = 0.0340;                                                     % pu_Wert
pu_line.L34.B = 0.0346;                                                     % pu_Wert
pu_line.L45.B = 0.0128;                                                     % pu_Wert

%13,8kV Netz
pu_line.L611.R = 0.09498;                                                   % pu_Wert
pu_line.L612.R = 0.12291;                                                   % pu_Wert
pu_line.L613.R = 0.06615;                                                   % pu_Wert
pu_line.L910.R = 0.03181;                                                   % pu_Wert
pu_line.L914.R = 0.12711;                                                   % pu_Wert
pu_line.L1011.R = 0.08205;                                                  % pu_Wert
pu_line.L1213.R = 0.22092;                                                  % pu_Wert
pu_line.L1314.R = 0.17093;                                                  % pu_Wert

pu_line.L611.X = 0.19890;                                                   % pu_Wert
pu_line.L612.X = 0.25581;                                                   % pu_Wert
pu_line.L613.X = 0.13027;                                                   % pu_Wert
pu_line.L910.X = 0.08450;                                                   % pu_Wert
pu_line.L914.X = 0.27038;                                                   % pu_Wert
pu_line.L1011.X = 0.19207;                                                  % pu_Wert
pu_line.L1213.X = 0.19988;                                                  % pu_Wert
pu_line.L1314.X = 0.34802;                                                  % pu_Wert

pu_line.L611.B = 0;                                                         % pu_Wert
pu_line.L612.B = 0;                                                         % pu_Wert
pu_line.L613.B = 0;                                                         % pu_Wert
pu_line.L910.B = 0;                                                         % pu_Wert
pu_line.L914.B = 0;                                                         % pu_Wert
pu_line.L1011.B = 0;                                                        % pu_Wert
pu_line.L1213.B = 0;                                                        % pu_Wert
pu_line.L1314.B = 0;                                                        % pu_Wert

%18 kV Netz

%Berechnungen
Zbase1 = pu_vsm(1).Zb;                                                     % Basiswert Impedanz (Ohm)
Ybase1 = 1/Zbase1;                                                          % Basiswert Admitanz (1/Ohm)

%69kV Netz  (Vn1)
line.L12.R = pu_line.L12.R*Zbase1;                                          % Einheit in Ohm
line.L15.R = pu_line.L15.R*Zbase1;                                          % Einheit in Ohm
line.L23.R = pu_line.L23.R*Zbase1;                                          % Einheit in Ohm
line.L24.R = pu_line.L24.R*Zbase1;                                          % Einheit in Ohm
line.L25.R = pu_line.L25.R*Zbase1;                                          % Einheit in Ohm
line.L34.R = pu_line.L34.R*Zbase1;                                          % Einheit in Ohm
line.L45.R = pu_line.L45.R*Zbase1;                                          % Einheit in Ohm

line.L12.L = (pu_line.L12.X*Zbase1)/(2*pi*fn)*1e3;                          % Einheit in mH
line.L15.L = (pu_line.L15.X*Zbase1)/(2*pi*fn)*1e3;                          % Einheit in mH
line.L23.L = (pu_line.L23.X*Zbase1)/(2*pi*fn)*1e3;                          % Einheit in mH
line.L24.L = (pu_line.L24.X*Zbase1)/(2*pi*fn)*1e3;                          % Einheit in mH
line.L25.L = (pu_line.L25.X*Zbase1)/(2*pi*fn)*1e3;                          % Einheit in mH
line.L34.L = (pu_line.L34.X*Zbase1)/(2*pi*fn)*1e3;                          % Einheit in mH
line.L45.L = (pu_line.L45.X*Zbase1)/(2*pi*fn)*1e3;                          % Einheit in mH

line.L12.C = (pu_line.L12.B*Ybase1)/(2*pi*fn)*1e6;                          % Einheit in uF 
line.L15.C = (pu_line.L15.B*Ybase1)/(2*pi*fn)*1e6;                          % Einheit in uF
line.L23.C = (pu_line.L23.B*Ybase1)/(2*pi*fn)*1e6;                          % Einheit in uF
line.L24.C = (pu_line.L24.B*Ybase1)/(2*pi*fn)*1e6;                          % Einheit in uF
line.L25.C = (pu_line.L25.B*Ybase1)/(2*pi*fn)*1e6;                          % Einheit in uF
line.L34.C = (pu_line.L34.B*Ybase1)/(2*pi*fn)*1e6;                          % Einheit in uF
line.L45.C = (pu_line.L45.B*Ybase1)/(2*pi*fn)*1e6;                          % Einheit in uF

line.L12.LG = line.L12.C*0.2;                                               % Einheit in uF (Ground-Line)
line.L15.LG = line.L15.C*0.2;                                               % Einheit in uF (Ground-Line)
line.L23.LG = line.L23.C*0.2;                                               % Einheit in uF (Ground-Line)
line.L24.LG = line.L24.C*0.2;                                               % Einheit in uF (Ground-Line)
line.L25.LG = line.L25.C*0.2;                                               % Einheit in uF (Ground-Line)
line.L34.LG = line.L34.C*0.2;                                               % Einheit in uF (Ground-Line)
line.L45.LG = line.L45.C*0.2;                                               % Einheit in uF (Ground-Line)

line.L12.LL = line.L12.C*0.4;                                               % Einheit in uF (Ground-Line)
line.L15.LL = line.L15.C*0.4;                                               % Einheit in uF (Ground-Line)
line.L23.LL = line.L23.C*0.4;                                               % Einheit in uF (Ground-Line)
line.L24.LL = line.L24.C*0.4;                                               % Einheit in uF (Ground-Line)
line.L25.LL = line.L25.C*0.4;                                               % Einheit in uF (Ground-Line)
line.L34.LL = line.L34.C*0.4;                                               % Einheit in uF (Ground-Line)
line.L45.LL = line.L45.C*0.4;                                               % Einheit in uF (Ground-Line)

%Parameter löschen
clear Vn1 b_9pu b_9f Pbase fn Ybase1

 