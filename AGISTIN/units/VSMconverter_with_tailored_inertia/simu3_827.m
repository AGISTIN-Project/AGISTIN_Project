%% Eine VSM wie SynGen bis 4.5 Hz/s, beide anderen VSMs symm.
%% Tlfsm nahe 0, deshalb kein Über-/Rückschwingen bei f

% simu3 auf sehr gute Dokumentation der Parameter achten
% + klar aufgeteilte einheitliche Verwendung in prm3var...m und simu3...m

prm_vsm(38,:) = {'relPref' 0 0 0 1 1};  % only values 0 and 1 allowed

% put deviations in Pset here!!
prm_vsm(4,:) = {'DeltaP_lim_rise' prm_vsm{3, 2}-prm_vsm{1, 2} prm_vsm{3, 3}-prm_vsm{1, 3} prm_vsm{3, 4}-prm_vsm{1, 4} prm_vsm{3, 5}-prm_vsm{1, 5} prm_vsm{3, 6}-prm_vsm{1, 6}};
prm_vsm(5,:) = {'DeltaP_lim_fall' prm_vsm{2, 2}-prm_vsm{1, 2} prm_vsm{2, 3}-prm_vsm{1, 3} prm_vsm{2, 4}-prm_vsm{1, 4} prm_vsm{2, 5}-prm_vsm{1, 5} prm_vsm{2, 6}-prm_vsm{1, 6}};
prm_vsm(7,:) = {'xvfactor' 1.5 1.5 1.5 1.5/max(0.2, abs(prm_vsm{1, 5}))^0.5 1.5/max(0.2, abs(prm_vsm{1, 6}))^0.5};

prm_vsm(72,:) = {'LFSM-U_fdev_start' -1.7 -1.7 -1.7 -0.2 -0.2};
prm_vsm(73,:) = {'LFSM-U_fdev_end'   -2.5 -2.5 -2.5 -0.8 -0.8};
prm_vsm(47,:) = {'LFSM-U_T_delay'  0.01 0.01 0.01 0.6667 0.6667};   %s  must not be 0
prm_vsm(74,:) = {'LFSM relPset'   0 0 0 0 0};

LFSMU_gain = 1/(0.8/50);
prm_vsm(55,:) = {'LFSM-O_gain'      0 0 0 0 0};
prm_vsm(57,:) = {'LFSM-U_gain'      2*LFSMU_gain 0*LFSMU_gain LFSMU_gain 0 0};

% ATTENTION: Tp values are 'internal', i.e. |fdot*Tp| <= 50 Hz !!!
% PAY ATTENTION to Prated=Pbase of the individual VSMs! Result plots have uniform Pbase!!
% ATTENTION: For LFSM reverse inertia, the Tp values of the non-regular
% direction must indicate the desired reverse-inertia behaviour!! (in terms
% of relPref or not, depending on the setting)
prm_vsm(8,:) = {'Tp_rise0'       0   15  11   10 10};
prm_vsm(9,:) = {'Tp_fall0'      15    0  11   10 10};
% row 10 see behind row 23

prm_vsm(58,:) = {'RoCoF_rise0'  0     0     0   0 0};
prm_vsm(59,:) = {'RoCoF_rise1'  0.2   0.2   0.2   0.2 0.2};
prm_vsm(60,:) = {'RoCoF_rise2'  0.2   0.2   0.2   0.3   0.3};
prm_vsm(61,:) = {'RoCoF_rise3'  1     1     1     1 1};
prm_vsm(62,:) = {'RoCoF_rise4'  2     2     2     1.5 1.5};
prm_vsm(63,:) = {'RoCoF_rise9'  4.5   4.5   4.5 4 4};
prm_vsm(64,:) = {'RoCoF_fall0'  0     0     0   0 0};
prm_vsm(65,:) = {'RoCoF_fall1' -0.2  -0.2  -0.2 -0.2 -0.2};
prm_vsm(66,:) = {'RoCoF_fall2' -0.2  -0.2  -0.2 -0.3 -0.3};
prm_vsm(67,:) = {'RoCoF_fall3' -1    -1    -1    -1 -1};
prm_vsm(68,:) = {'RoCoF_fall4' -2    -2    -2    -1.5 -1.5};
prm_vsm(69,:) = {'RoCoF_fall9' -4.5  -4.5  -4.5 -5 -5};

prm_vsm(20,:) = {'Tp_rise2'     0   74.4   11      4 4};
prm_vsm(21,:) = {'Tp_rise9'     0     0    11      4 4};
prm_vsm(22,:) = {'Tp_fall2'    74.4   0    11      4 4};
prm_vsm(23,:) = {'Tp_fall9'     0     0    11      4 4};
%vsm_calc(6,:) = {'Tp_base' max([prm_vsm{8,2:6}], ([prm_vsm{8,2:6}].*[prm_vsm{59,2:6}]+[prm_vsm{20,2:6}].*([prm_vsm{61,2:6}]-[prm_vsm{60,2:6}])+([prm_vsm{8,2:6}]+[prm_vsm{20,2:6}])/2.*([prm_vsm{60,2:6}]-[prm_vsm{59,2:6}]))./[prm_vsm{61,2:6}])};
%tmparr = max([prm_vsm{8,2:6}], ([prm_vsm{8,2:6}].*[prm_vsm{59,2:6}]+([prm_vsm{8,2:6}]+[prm_vsm{20,2:6}])/2.*([prm_vsm{60,2:6}]-[prm_vsm{59,2:6}])+[prm_vsm{20,2:6}].*([prm_vsm{61,2:6}]-[prm_vsm{60,2:6}]))./[prm_vsm{61,2:6}], ([prm_vsm{8,2:6}].*[prm_vsm{59,2:6}]+([prm_vsm{8,2:6}]+[prm_vsm{20,2:6}])/2.*([prm_vsm{60,2:6}]-[prm_vsm{59,2:6}])+[prm_vsm{20,2:6}].*([prm_vsm{61,2:6}]-[prm_vsm{60,2:6}])+([prm_vsm{20,2:6}]+[prm_vsm{21,2:6}])/2.*([prm_vsm{62,2:6}]-[prm_vsm{61,2:6}])+[prm_vsm{21,2:6}].*([prm_vsm{63,2:6}]-[prm_vsm{62,2:6}]))./[prm_vsm{63,2:6}], [prm_vsm{9,2:6}], ([prm_vsm{9,2:6}].*[prm_vsm{65,2:6}]+([prm_vsm{9,2:6}]+[prm_vsm{22,2:6}])/2.*([prm_vsm{66,2:6}]-[prm_vsm{65,2:6}])+[prm_vsm{22,2:6}].*([prm_vsm{67,2:6}]-[prm_vsm{66,2:6}]))./[prm_vsm{67,2:6}], ([prm_vsm{9,2:6}].*[prm_vsm{65,2:6}]+([prm_vsm{9,2:6}]+[prm_vsm{22,2:6}])/2.*([prm_vsm{66,2:6}]-[prm_vsm{65,2:6}])+[prm_vsm{22,2:6}].*([prm_vsm{67,2:6}]-[prm_vsm{66,2:6}])+([prm_vsm{22,2:6}]+[prm_vsm{23,2:6}])/2.*([prm_vsm{68,2:6}]-[prm_vsm{67,2:6}])+[prm_vsm{23,2:6}].*([prm_vsm{69,2:6}]-[prm_vsm{68,2:6}]))./[prm_vsm{69,2:6}]);
tmparr_r = max([prm_vsm{8,2:6}], ([prm_vsm{8,2:6}].*[prm_vsm{59,2:6}]+([prm_vsm{8,2:6}]+[prm_vsm{20,2:6}])/2.*([prm_vsm{60,2:6}]-[prm_vsm{59,2:6}])+[prm_vsm{20,2:6}].*([prm_vsm{61,2:6}]-[prm_vsm{60,2:6}]))./[prm_vsm{61,2:6}]);
tmparr_r = max(tmparr_r, ([prm_vsm{8,2:6}].*[prm_vsm{59,2:6}]+([prm_vsm{8,2:6}]+[prm_vsm{20,2:6}])/2.*([prm_vsm{60,2:6}]-[prm_vsm{59,2:6}])+[prm_vsm{20,2:6}].*([prm_vsm{61,2:6}]-[prm_vsm{60,2:6}])+([prm_vsm{20,2:6}]+[prm_vsm{21,2:6}])/2.*([prm_vsm{62,2:6}]-[prm_vsm{61,2:6}])+[prm_vsm{21,2:6}].*([prm_vsm{63,2:6}]-[prm_vsm{62,2:6}]))./[prm_vsm{63,2:6}]);
tmparr_f = max([prm_vsm{9,2:6}], ([prm_vsm{9,2:6}].*[prm_vsm{65,2:6}]+([prm_vsm{9,2:6}]+[prm_vsm{22,2:6}])/2.*([prm_vsm{66,2:6}]-[prm_vsm{65,2:6}])+[prm_vsm{22,2:6}].*([prm_vsm{67,2:6}]-[prm_vsm{66,2:6}]))./[prm_vsm{67,2:6}]);
tmparr_f = max(tmparr_f, ([prm_vsm{9,2:6}].*[prm_vsm{65,2:6}]+([prm_vsm{9,2:6}]+[prm_vsm{22,2:6}])/2.*([prm_vsm{66,2:6}]-[prm_vsm{65,2:6}])+[prm_vsm{22,2:6}].*([prm_vsm{67,2:6}]-[prm_vsm{66,2:6}])+([prm_vsm{22,2:6}]+[prm_vsm{23,2:6}])/2.*([prm_vsm{68,2:6}]-[prm_vsm{67,2:6}])+[prm_vsm{23,2:6}].*([prm_vsm{69,2:6}]-[prm_vsm{68,2:6}]))./[prm_vsm{69,2:6}]);
tmparr = max(tmparr_r.*(-[prm_vsm{4,2:6}].*[prm_vsm{38,2:6}]-[prm_vsm{38,2:6}]+1), tmparr_f.*([prm_vsm{5,2:6}].*[prm_vsm{38,2:6}]-[prm_vsm{38,2:6}]+1));
tmparr = max(tmparr, [10 10 10 10 10]);
tmparr = min(tmparr, [10 10 10 10 10]);
prm_vsm(10,:) = {'Tp_base' tmparr(1) tmparr(2) tmparr(3) tmparr(4) tmparr(5)};
%prm_vsm(10,:) = {'Tp_base' max(prm_vsm{8, 2}/prm_vsm{59, 2})/ 30 30 30 max(prm_vsm{8,5},prm_vsm{9,5}) max(prm_vsm{8,6},prm_vsm{9,6})};
tmparr = [0.0013 0.0013 0.0013 0.0013 0.0013];
tmparr = max(tmparr, [0.001 0.001 0.001 0.001 0.001]+[prm_vsm{10,2:6}]*0.00001);
prm_vsm(16,:) = {'T_imp' tmparr(1) tmparr(2) tmparr(3) tmparr(4) tmparr(5)};

prm_vsm(28,:) = {'dampcomp_on' 1 1 1 1 1};

prm_vsm(18,:) = {'dynTp,base' 0 0 0 0 0}; % 1=on 0=off dynamic modification of Tp,base

prm_vsm(39,:) = {'modify swingback Tp' 1 1 1 1 1};  % only values 0 and 1 allowed
prm_vsm(50,:) = {'accelerate swingback' 1 1 1 1 1};  % only values 0 and 1 allowed

prm_vsm(82,:) = {'Iconfine_fall' 1 1 1 0 0};
prm_vsm(81,:) = {'Iconfine_rise' 1 1 1 0 0};

load_start_factor = 0.9;

pu_load.P.Bus2 = 2.4;   % 2.5 p.u. for 824 Paper TailorPEinertia
pu_fb1_factor = 0*0.1;
pu_fb2_factor = 0*0.1;
pu_var_factor = 0*0.1; 
pu_con_factor = 1-pu_var_factor-pu_fb2_factor-pu_fb1_factor;
if pu_con_factor < 0
    disp('PConstFactor darf nicht 0 sein')
    return
end
prm_load(1,:) = {'pu_fb1_step'   pu_load.P.Bus2*pu_fb1_factor pu_load.P.Bus3*pu_fb1_factor pu_load.P.Bus4*pu_fb1_factor pu_load.P.Bus5*pu_fb1_factor pu_load.P.Bus6*pu_fb1_factor 0 0 pu_load.P.Bus9*pu_fb1_factor pu_load.P.Bus10*pu_fb1_factor pu_load.P.Bus11*pu_fb1_factor pu_load.P.Bus12*pu_fb1_factor pu_load.P.Bus13*pu_fb1_factor pu_load.P.Bus14*pu_fb1_factor};
prm_load(2,:) = {'pu_fb2_step'   pu_load.P.Bus2*pu_fb2_factor pu_load.P.Bus3*pu_fb2_factor pu_load.P.Bus4*pu_fb2_factor pu_load.P.Bus5*pu_fb2_factor pu_load.P.Bus6*pu_fb2_factor 0 0 pu_load.P.Bus9*pu_fb2_factor pu_load.P.Bus10*pu_fb2_factor pu_load.P.Bus11*pu_fb2_factor pu_load.P.Bus12*pu_fb2_factor pu_load.P.Bus13*pu_fb2_factor pu_load.P.Bus14*pu_fb2_factor};
prm_load(3,:) = {'pu_var'        pu_load.P.Bus2*pu_var_factor pu_load.P.Bus3*pu_var_factor pu_load.P.Bus4*pu_var_factor pu_load.P.Bus5*pu_var_factor pu_load.P.Bus6*pu_var_factor 0 0 pu_load.P.Bus9*pu_var_factor pu_load.P.Bus10*pu_var_factor pu_load.P.Bus11*pu_var_factor pu_load.P.Bus12*pu_var_factor pu_load.P.Bus13*pu_var_factor pu_load.P.Bus14*pu_var_factor};
prm_load(4,:) = {'pu_indust'     0 0 0 0 0 0 0 0 0 0 0 0 0};
prm_load(5,:) = {'pu_konst'      pu_load.P.Bus2*pu_con_factor pu_load.P.Bus3*pu_con_factor pu_load.P.Bus4*pu_con_factor pu_load.P.Bus5*pu_con_factor pu_load.P.Bus6*pu_con_factor 0 0 pu_load.P.Bus9*pu_con_factor pu_load.P.Bus10*pu_con_factor pu_load.P.Bus11*pu_con_factor pu_load.P.Bus12*pu_con_factor pu_load.P.Bus13*pu_con_factor pu_load.P.Bus14*pu_con_factor};



