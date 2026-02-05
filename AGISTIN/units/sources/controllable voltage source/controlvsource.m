%% Parameter script for controllable voltage source
% writing all variables in one struct

%% general paramters

HWSampleTime = 1/8000;              % simulation step size


%% specific parameters

VScourceData.v_rms_ln_si = 230;                     % RMS voltage line-neutral
VScourceData.f_si        = 50;                      % nominal frequency
VScourceData.phi_init    = 0;                       % inital phase angle in rad

VScourceData.rocof_des_si = 1;                      % absolute desired RoCoF in Hz/s
VScourceData.max_f_dev_si = 0.5;                    % max. frequency deviation in Hz
VScourceData.t_rocof      = 0.5;                    % time for RoCoF activation in s
