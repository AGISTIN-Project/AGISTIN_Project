%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AGISTIN WP5 - Green hydrogen production
% Plant components 
% Author: Christoph Kaufmann (Fraunhofer IWES)
% Date: 19.12.2023
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% simulation set up
exe.tstep=2e-5;     % Simulation time step (s)
exe.tsim=15;        % Duration (s)
exe.tdist=6;        % Time instant of disturbance (s)

%%%%%%%%%%%%%%% Network parameters  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
grid.f0=50;     % nominal grid frequency(Hz)
grid.Vrms=400;  % line-to-line RMS grid voltage (V) 
grid.Vp=400*sqrt(2/3); % line-to-neutral voltage (V)
grid.Ssc=5.19e6;  % short circuit power (VAr)
grid.XRratio=8.5; % R/X ratio 
% OPEN: Ssc
  
grid.R1=0.031; % Line resistance (Ohm)
grid.L1=0.098e-3;  % Line inductance (H)


%%%%%%%%%%% Switch time circuit breaker %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Grid
Grid.CB.off=exe.tsim+10;
%
SCLR.CB.off=exe.tsim+10;

%ESS
ESS.CB.off=exe.tsim+10;

%%%%%%%%%%%%%% ETCA AC Rail %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rail.R1=0;     % Line resistance (Ohm)
rail.L1=0;  % Line inductance (H)

%%%%%%%%%%%%%% SCLR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
SCLR.SCR=[0.5;1;1.5;2;5;];
SCLR.Ldata=[20.46; 10.19; 6.65; 4.91; 1.90 ]*1e-3;
SCLR.Rdata=[893.78; 361.04; 151.36; 97.72; 38.33]*1e-3;

SCLR.setting=find(SCLR.SCR==SCRsetting);

SCLR.L=SCLR.Ldata(SCLR.setting);
SCLR.R=SCLR.Rdata(SCLR.setting);

%%%%%%%%%%%%%%%%% PV %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
PV_param;

%%%%%%%%%%%%%%%%% Electrolyzer %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ELY_param;


%%%%%%%%%%%%%%%%% ESS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ESS_param;

%%%%%%%%%%%% Setting up different test configurations %%%%%%%%%%%%%%%%%%%

        switch modes_exe
        
            case 'Mode_1' 
                 
                % circuit breakers setting    
                 Grid.CB.on=0;
                 SCLR.CB.on=exe.tsim+5;
                 ESS.CB.on=exe.tsim+5;
                
                 imp_set="";   

                       
            case 'Mode_2'

                % circuit breakers setting    
                Grid.CB.on=exe.tsim+5;
                SCLR.CB.on=0;
                ESS.CB.on=exe.tsim+5;

                % testing for different impedances               
                SCLR.L=SCLR.Ldata(SCLR.setting);
                SCLR.R=SCLR.Rdata(SCLR.setting);

                       
            case 'Mode_3'
                % circuit breakers setting    
                 Grid.CB.on=exe.tsim+5;
                 SCLR.CB.on=0;
                 ESS.CB.on=0;
                     
                 SCLR.L=SCLR.Ldata(SCLR.setting);
                 SCLR.R=SCLR.Rdata(SCLR.setting);
                                 
            case 'Mode_4'
                % circuit breakers setting    
                 Grid.CB.on=exe.tsim+5;
                 SCLR.CB.on=exe.tsim+5;
                 ESS.CB.on=0;
           
                 imp_set="";   
             
            otherwise    
        
        end

%% Solar reference 

solar_ref='step_up';
t_ELY_on=0.88; % activation time of the ELY to follow the solar reference
switch solar_ref
    case 'step_up'
        setP_t=[0   0.4     4       7    10];
        setP_P=[0 12.5e3   25e3  37.5e3 50e3]; 
    case 'step_down'
        setP_t=[0 0.4 4 7 10 12];
        setP_P=[0 50e3 37.5e3 25e3 12.5e3 12.5]; 
end
