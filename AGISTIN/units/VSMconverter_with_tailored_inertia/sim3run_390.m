
[parameterrun.row,parameterrun.column] = size(parameterrun.dFF);

% for loop to size of dFF
for i=1:parameterrun.row
    executiontype = 1;                                  %used to determine whether it's an automated or a manual run
    index_voltage = parameterrun.dFF(i,1);
    index_RoCoF = parameterrun.dFF(i,2);
    index_length = parameterrun.dFF(i,3);
    index_TpllTg= parameterrun.dFF(i,4);
    index_CGF = parameterrun.dFF(i,5);
    index_ring1 = parameterrun.dFF(i,6);
    index_ring2 = parameterrun.dFF(i,7);
    index_event = parameterrun.dFF(i,8);

    switch index_RoCoF
        case 1
            parameterset.RoCoFup = 1 ;              
        otherwise
            parameterset.RoCoFup = 0;
    end
    
    parameterset.cable=1;
    AutoIslandingTime = 5;
    switch index_voltage                                 % at the end select variables according to matrix entries
        case 1              
            parameterset.General.Vnreg = 400;
        case 2
            parameterset.General.Vnreg = 20e3;        
        case 3             
            parameterset.General.Vnreg = 110e3;
            if parameterset.RoCoFup == 1
                AutoIslandingTime = 10;
            else
                AutoIslandingTime = 20;
            end
        case 4
            parameterset.General.Vnreg = 110e3;
            parameterset.cable=0;
            if parameterset.RoCoFup == 1
                AutoIslandingTime = 10;
            else
                AutoIslandingTime = 30;
            end
        otherwise
            parameterset.General.Vnreg = 400e3;
            parameterset.cable=0;
    end
    parameterset.Event.IslandingTime = parameterset.GeneralIslandingTime;
    if parameterset.GeneralIslandingTime == 0
        parameterset.Event.IslandingTime = AutoIslandingTime;
    end

    switch index_length
        case 1 
            parameterset.Li.length_factor = 1;
        otherwise
            parameterset.Li.length_factor = 0.1; 
    end
    
    switch index_TpllTg
       case 1
           parameterset.Trv=0.05;              
           parameterset.Tg=0.05;              
           parameterset.Tpll=0.1;              
       case 2
           parameterset.Trv=0.005;              
           parameterset.Tg=0.001;              
           parameterset.Tpll=0.1;              
       case 3
           parameterset.Trv=0.05;              
           parameterset.Tg=0.05;              
           parameterset.Tpll=0.01;              
       otherwise
           parameterset.Trv=0.005;              
           parameterset.Tg=0.001;              
           parameterset.Tpll=0.01;              
    end
    
    switch index_CGF
        case 1
            if parameterrun.setting == 'UDI'
                parameterset.UDI = 1;              
                parameterset.BDI = 0;              
                parameterrun.simmode = 'UDI';
            elseif parameterrun.setting == 'BDI'
                parameterset.BDI = 1;              
                parameterset.UDI = 0;              
                parameterrun.simmode = 'BDI';
            end
        otherwise
            parameterset.UDI = 0;
            parameterset.BDI = 0;              
            parameterrun.simmode = 'symm';
    end
    
    switch index_ring1                               
        case 1
            parameterset.k_ring1 = 1;
            parameterset.Event.ring1_switch_direction = 1;
            parameterrun.ring1 = 'open';
            parameterset.center_line_status=0;
        case 2              
            parameterset.k_ring1 = 0.5;
            parameterset.Event.ring1_switch_direction = 0;
            parameterrun.ring1 = parameterset.k_ring1;
            parameterset.center_line_status=0;
        case 3            
            parameterset.k_ring1 = 0.1;
            parameterset.Event.ring1_switch_direction = 0;
            parameterrun.ring1 = parameterset.k_ring1;
            parameterset.center_line_status=0;
        case 4
            parameterset.k_ring1 = 0.01;
            parameterset.Event.ring1_switch_direction = 0;
            parameterrun.ring1 = parameterset.k_ring1;
            parameterset.center_line_status=1;
        case 5
            parameterset.k_ring1 = 0.001;
            parameterset.Event.ring1_switch_direction = 0;
            parameterrun.ring1 = parameterset.k_ring1;
            parameterset.center_line_status=1;
        otherwise  % wird im März/April 2021 nicht verwendet          
            parameterset.k_ring1 = 1;
            parameterset.Event.ring1_switch_direction = 0;
            parameterrun.ring1 = parameterset.k_ring1;
            parameterset.center_line_status=0;
    end
    
    
    switch index_ring2                               
        case 1
            parameterset.k_ring2 = 1;
            parameterset.Event.ring2_switch_direction = 1;
            parameterrun.ring2 = 'open';
            parameterset.lower_line_status=0;
        case 2              
            parameterset.k_ring2 = 0.5;
            parameterset.Event.ring2_switch_direction = 0;
            parameterrun.ring2 = parameterset.k_ring2;
            parameterset.lower_line_status=0;
        case 3            
            parameterset.k_ring2 = 0.1;
            parameterset.Event.ring2_switch_direction = 0;
            parameterrun.ring2 = parameterset.k_ring2;
            parameterset.lower_line_status=0;
        case 4
            parameterset.k_ring2 = 0.01;
            parameterset.Event.ring2_switch_direction = 0;
            parameterrun.ring2 = parameterset.k_ring2;
            parameterset.lower_line_status=1;
        case 5
            parameterset.k_ring2 = 0.001;
            parameterset.Event.ring2_switch_direction = 0;
            parameterrun.ring2 = parameterset.k_ring2;
            parameterset.lower_line_status=1;
        otherwise  % wird im März/April 2021 nicht verwendet          
            parameterset.k_ring2 = 1;
            parameterset.Event.ring2_switch_direction = 0;
            parameterrun.ring2 = parameterset.k_ring2;
            parameterset.lower_line_status=0;
    end
    
    parameterset.simulation = num2str(index_event);
   
    if parameterset.Event.IslandingTime < 999
        parameterset.Event.LoadStepTime = parameterset.Event.IslandingTime + parameterset.time_to_loadstep;
        parameterset.Sim.tend = parameterset.Event.IslandingTime + parameterset.time_after_islanding;
    else
        parameterset.Event.LoadStepTime = 9e9;
        parameterset.Sim.tend = 15;
    end

    clearvars -except parameterset SimStruct parameterrun excutiontype i k

    gain_HPF=1;
    %clear all except executiontype und Simstruct
    %Initialisieren Defaultparameter
    %check executiontype

%    if exist('executiontype','var')==0
%        parameterset.init=1;                                                %necessary to create the struct
    %WS: Wo wird die Variable abgefragt?
    %WS: Müsste sie nicht per else auch bewusst = 0 gesetzt werden?
           %     parameterset.General.Vnreg = 110e3;
          %       parameterset.Li.type=1;
       %          parameterset.Li.length_factor = 20; 
          %       parameterset.RoCoF = 1; 
        %space for variables to set as you please. Will only be executed in a
        %non-automated run
        %Leave blank to keep default settings
        %parameterset.General_Vn=400e3
%    end


    % if 1 dann überschreiben und executiontype clearen
    %if 0 dann nicht überschreiben und executiontype clearen



    %% General
    General.fn = 50;                 %[Hz] nominal grid frequency
    General.omega0 = General.fn*2*pi; %[rad/s] nominal angular velocity
    %General.VnlvlE = 400e3;         %[V] phase-phase rms voltage
    General.VnlvlH = 110e3;          %[V] phase-phase rms voltage
    General.VnlvlM = 20e3;           %[V] phase-phase rms voltage
    General.VnlvlL = 400;            %[V] phase-phase rms voltage
    if isfield (parameterset,'General') && isfield (parameterset.General,'Vnreg') && parameterset.General.Vnreg ~= 0
        General.Vnreg = parameterset.General.Vnreg;                %[V] sets the default voltage
    else
         General.Vnreg=20e3;
    end
    fn = General.fn;                 %[Hz] nominal frequency (with a very short name)

    %% Infinite Grid
    InfBus.Vn = General.Vnreg;       %[V] phase-phase rms voltage
    InfBus.fn = General.fn;          %[Hz] Frequency
    InfBus.Vset = 1.02;  % p.u.
    
    InfBus.f_init = 50;              %[Hz] initial frequency
    InfBus.f_dot0 = 0;               %[Hz/s] initial RoCoF
    InfBus.t_f1 = 9e9;               %[s] time of first stepwise f change
    InfBus.f1 = InfBus.fn;           %[Hz] frequency jump
    InfBus.t_theta1 = 9e9;           %[s] time of first stepwise voltage angle change
    InfBus.delta_theta1 = 0/180*pi;   %[rad] signed voltage angle step

    % frequency ramps
    InfBus.t_fd1 = 3;                %[s] time of first change in RoCoF
    InfBus.f_dot1 = -2;              %[Hz/s] RoCoF after first change
    InfBus.t_fd2 = InfBus.t_fd1+1; %[s] time of second change in RoCoF
    InfBus.f_dot2 = 0;              %[Hz/s] RoCoF after second change
    InfBus.t_fd3 = InfBus.t_fd2+2;   %[s] time of third change in RoCoF
    InfBus.f_dot3 = +2;              %[Hz/s] RoCoF after third change
    InfBus.t_fd4 = InfBus.t_fd3+1.5; %[s] time of fourth change in RoCoF
    InfBus.f_dot4 = -0.3;               %[Hz/s] RoCoF after fourth change
    % no frequency ramps
    InfBus.t_fd1 = 9e9;              %[s]
    InfBus.t_fd2 = 9e9;              %[s]
    InfBus.t_fd3 = 9e9;              %[s]
    InfBus.t_fd4 = 9e9;              %[s]

    if isfield (parameterset,'cable') && parameterset.cable ~= 0
        cable = parameterset.cable;
    else
            cable = 0;                     %index for cable (Li.type=0) or overhead (Li.type=1)
    end

    switch General.Vnreg
        case 400
            % grid transformer 20/0.4 kV  0.4 MVA
            TrG.Sn = 400000;              %[VA] nominal apparent power of trafo to infinite grid
            TrG.uk = 0.06;                    %[p.u.] short-circuit voltage of trafo
            TrG.ukr = 0.01425;                    %[p.u.] short-circuit voltage of resistive part of trafo
            % no unit transformer
            TrU.Sn = 1;              %[VA] nominal apparent power of trafo to infinite grid
            TrU.uk = 0;                    %[p.u.] short-circuit voltage of trafo
            TrU.ukr = 0;                    %[p.u.] short-circuit voltage of resistive part of trafo
            % values corresponding to NAYY 4x240SE (Powerfactory 2020) 
            Li.X  =  0.079796;                    %[Ohm/km] inductive reactance per km
            Li.R  =  0.1267;                   %[Ohm/km] resistance per km
            sp_Q_CCI0 = -0.4;                   %[p.u.]

        case 20e3
            % grid transformer 110/20 kV  40 MVA
            TrG.Sn = 40000000;              %[VA] nominal apparent power of trafo to infinite grid
            TrG.uk = 0.162;                    %[p.u.] short-circuit voltage of trafo
            TrG.ukr = 0.0034;                    %[p.u.] short-circuit voltage of resistive part of trafo
            % unit transformer 20/1 kV  11 MVA
            TrU.Sn = 11000000;              %[VA] nominal apparent power of trafo to infinite grid
            TrU.uk = 0.103;                    %[p.u.] short-circuit voltage of trafo
            TrU.ukr = 0.0041;                    %[p.u.] short-circuit voltage of resistive part of trafo
            % values corresponding to NA2XS2Y 1×500 RM it (Powerfactory 2020) 
            Li.X  =  0.102415;                    %[Ohm/km] inductive reactance per km
            Li.R  =  0.0681;                   %[Ohm/km] resistance per km
            sp_Q_CCI0 = -0.2;                   %[p.u.]

        case 110e3
            % grid transformer 400/110 kV  160 MVA
            TrG.Sn = 16000000;              %[VA] nominal apparent power of trafo to infinite grid
            TrG.uk = 0.122;                    %[p.u.] short-circuit voltage of trafo
            TrG.ukr = 0.0025;                    %[p.u.] short-circuit voltage of resistive part of trafo
            % unit transformer 110/1 kV  75 MVA
            TrU.Sn = 75000000;              %[VA] nominal apparent power of trafo to infinite grid
            TrU.uk = 0.18;                    %[p.u.] short-circuit voltage of trafo
            TrU.ukr = 0.0032;                    %[p.u.] short-circuit voltage of resistive part of trafo
            if cable == 1
                % values corresponding to N2XS2Y 1x630RM/35 it (Powerfactory 2020) 
                Li.X  =  0.125663;                    %[Ohm/km] inductive reactance per km
                Li.R  =  0.0306;                   %[Ohm/km] resistance per km
                sp_Q_CCI0 = -0.05;                   %[p.u.]
            else
                % values corresponding to 110 kV -Donaumast- 2x Al/St 435(55) (Powerfactory 2020)
                Li.X  =  0.2600246;                    %[Ohm/km] inductive reactance per km
                Li.R  =  0.03339248;                   %[Ohm/km] resistance per km
                sp_Q_CCI0 = 0.05;                   %[p.u.]
            end
        case 400e3
            % no grid transformer
            TrG.Sn = 1e10;              %[VA] nominal apparent power of trafo to infinite grid
            TrG.uk = 0.0000000002;                    %[p.u.] short-circuit voltage of trafo
            TrG.ukr = 0.0000000001;                    %[p.u.] short-circuit voltage of resistive part of trafo
            % unit transformer 400/6 kV  310 MVA
            TrU.Sn = 310000000;              %[VA] nominal apparent power of trafo to infinite grid
            TrU.uk = 0.16;                    %[p.u.] short-circuit voltage of trafo
            TrU.ukr = 0.0012;                    %[p.u.] short-circuit voltage of resistive part of trafo
            % values corresponding to 380 kV -Donaumast- 4x Al/St 265/35 (Powerfactory 2020) 
            Li.X  =  0.2525553;                    %[Ohm/km] inductive reactance per km
            Li.R  =  0.02719984; %0.15%0.02719984;                   %[Ohm/km] resistance per km
            sp_Q_CCI0 = 0.05;                   %[p.u.]
    end

    SM_E.Sn = 400e6;    % 20e6
    SM_E.Vn = 27e3;
    % SM standard-parameter hardcoded (Parameters aus ÜNB)

    % for pi line model
    %Li.L  = 1000*Li.X/General.omega0;     %[mH/km] inductance per km
    % for RL line model
    Li.L  = Li.X/General.omega0;     %[H/km] inductance per km

    %% Lines
    if isfield (parameterset,'Li') && isfield (parameterset.Li,'length_factor') && parameterset.Li.length_factor ~= 0
        Li.length_factor = parameterset.Li.length_factor;
            if Li.length_factor<0.5
                sp_Q_CCI0 = -0.1;                   %[p.u.]
            end
    else
            Li.length_factor = 1;                     %[km] basevalue for 20 kV, scales with voltage
    end
    %Li.length_factor = 0.8
    Li.length = Li.length_factor * 40*((General.Vnreg/General.VnlvlH)^0.85);    %[km] default line length

    TrG.In = TrG.Sn/General.Vnreg/sqrt(3); %[A] nominal current of transformer
    TrG.X  = sqrt(TrG.uk^2-TrG.ukr^2)*General.Vnreg/sqrt(3)/TrG.In; %[Ohm] reactance of trafo
    TrG.L  = TrG.X/General.omega0;     %[H] inductance of trafo
    TrG.R  = TrG.ukr*General.Vnreg/sqrt(3)/TrG.In; %[Ohm] resistance of trafo

    TrU.In = TrU.Sn/General.Vnreg/sqrt(3); %[A] nominal current of trafo
    TrU.X  = sqrt(TrU.uk^2-TrU.ukr^2)*General.Vnreg/sqrt(3)/TrU.In; %[Ohm] reactance of trafo
    TrU.L  = TrU.X/General.omega0;     %[H] inductance of trafo
    TrU.R  = TrU.ukr*General.Vnreg/sqrt(3)/TrU.In; %[Ohm] resistance of trafo



    %VCI.SI.L1 = 0.0884*S1.pu.Lb;%0.5e-3;              %[H] corresponds to 0.088 pu
    %VCI.SI.L2 = TrU.L+0.0442*S1.pu.Lb;%0.25e-3;              %[H] additional L in lines next to VCIs, corresponds to 0.044 pu
    %VCI.SI.C = 0.0257*S1.pu.Cb;%46e-6;                %[F]   corresponds to 0.0257 pu
    %VCI.SI.R1 = 0.0562*S1.pu.Zb;%0.1; including semiconductor losses    %[Ohm]  corresponds to 0.0562 pu
    %VCI.SI.R2 = TrU.R+0.0112*S1.pu.Zb;%0.02; corrected value    %[Ohm] additional R in lines next to VCIs, corresponds to 0.0112 pu
    %VCI.SI.Rc = 0.00281*S1.pu.Zb;%0.005;               %[ohm] serial R of C, corresponds to 0.0281 pu



    
    %% values for closed/open ring

    if isfield (parameterset,'k_ring1') && parameterset.k_ring1 ~= 0
        k_ring1 = parameterset.k_ring1;
    else
            k_ring1 = 1;                     %[km] basevalue for 20 kV, scales with voltage
    end

    if isfield (parameterset,'k_ring2') && parameterset.k_ring2 ~= 0
        k_ring2 = parameterset.k_ring2;
    else
            k_ring2 = 1;                     %[km] basevalue for 20 kV, scales with voltage
    end
    
    if isfield (parameterset,'lower_line_status') 
        lower_line_status =parameterset.lower_line_status;
    else
            parameterset.lower_line_status = 0;                     
    end
    
    if isfield (parameterset,'center_line_status') 
        center_line_status =parameterset.center_line_status;
    else
            parameterset.center_line_status = 0;                     
    end



    %% VCI
    %VCI.Sn = 90e3*((General.Vnreg/General.VnlvlL)^1.15);                   %[VA] nominal S of VCI
    %VCI.Vn = General.Vnreg;         %[V]
    %VCI.Inom = VCI.Sn/VCI.Vn/sqrt(3);          %[A]

    %% Hardware parameters

    % S1.pu = pu(VCI.Sn, InfBus.Vn, 2*pi*50);
    

    %WS %% calculate transformer impedance
    %WS Tr.Sn = VCI.Sn/0.7;              %[VA] nominal apparent power of trafo to infinite grid
    %WS Tr.In = Tr.Sn/InfBus.Vn/sqrt(3); %[A] nominal current of trafo
    %WS Tr.uk = 0.06;                    %[p.u.] short-circuit voltage of trafo
    %WS Tr.X  = Tr.uk*InfBus.Vn/sqrt(3)/Tr.In; %[Ohm] reactance of trafo
    %WS Tr.L  = Tr.X/General.omega0;     %[H] inductance of trafo

    ControlSampleTime = 1/8000;      %[s]
    % PWM
    VSM.PWM.tauT = 1/8000;           %[s]
    TS = VSM.PWM.tauT;
    Ts = TS;
    % 2/VCI.ControlSampleTime
    T_PSconv = 1/8000;               %[s] Input filtering time constant of Simulink-PS Converter
    parameterset.TS = TS;

    % virtual circuit
    %[s] time constant of vc (ca. 8 ms)
    VSM.VC.tau_rv =1/(20*2*pi);
    VSM.VC.rv =0.13*3;%0.26% 0.13; 
    %if parameterset.UDI == 1 || parameterset.BDI == 1
    %    VSM.VC.xv = 0.11*0.4;             % *0.4 für neg. RoCoF   %[p.u.] 0.11%[p.u.] 0.13
    %else
        VSM.VC.xv = 0.11;             % *0.4 für neg. RoCoF   %[p.u.] 0.11%[p.u.] 0.13
    %end


    %% PLLs

    % PLL for f measurement (followed by low-pass filter)
    % design criterion: very quick f adaption, f amplitude after angular jump
    % doesn't matter
    VSM.PLLf.D  = 1;                 % damping
    VSM.PLLf.T  = 0.045;             %[s] time constant of PLL
    VSM.PLLf.v0 = General.Vnreg;            %[V] regular voltage for intended damping
    VSM.PLLf.kp = 2*VSM.PLLf.D/VSM.PLLf.v0/VSM.PLLf.T; % see Diss. D.Duckwitz p.104
    VSM.PLLf.ki = 1/(VSM.PLLf.v0*VSM.PLLf.T^2);
    % associated low-pass filter
    tau = 85;   % 85;
    a0 = 1;
    a1 = -2*2*tau/(2*tau+3);
    a2 = 2*tau*(2*tau+1)/((2*tau+3)*(2*tau+3+1));
    % RoCoF correction for associated low-pass filter
    Rco_lim = 4;                     % [Hz/s] max. abs value of RoCoF to be corrected
    Rco_Tint = 0.001;                % [s] integrator time constant for RoCoF correction
    Rco_gain = tau*ControlSampleTime; % gain of RoCoF correction

    % PLL for voltage-angle measurement
    % design criterion: high gain for very quick angle adaption (f doesn't matter)
    % ATTENTION: input voltage in p.u.
    VSM.PLLa.T  = 0.02;              %[s] time constant of PLL
    VSM.PLLa.D  = 1;                 % damping
    VSM.PLLa.v0 = General.Vnreg/5;          %[V] regular voltage for intended damping
    VSM.PLLa.kp = 2*VSM.PLLa.D/VSM.PLLa.v0/VSM.PLLa.T; % see Diss. D.Duckwitz p.104
    VSM.PLLa.ki = 1/(VSM.PLLa.v0*VSM.PLLa.T^2);   

    %% Unfavoured RoCof mechanism

    if isfield (parameterset,'UDI')
        UDI = parameterset.UDI;
    else
            UDI=0;                    % 1 = UDI aktiv, 0 = symmetrische VSM
                                        % zero is used for sym. VSM
    end

    if isfield (parameterset,'BDI')
        BDI = parameterset.BDI;
    else
            BDI=0;                    % 1 = BDI aktiv, 0 = BDI or symmetric VSM
    end      

    %% CCI parameters

    if isfield (parameterset,'Trv') 
            Trv = parameterset.Trv;
    else
            Trv = 0.02;                             %[s]  Time constant of Filtering of voltage absolute value           
    end

    if isfield (parameterset,'Tg') 
            Tg = parameterset.Tg;
    else
            Tg = 0.02;                             %[s]  Time constant of Filtering of voltage absolute value           
    end

    if isfield (parameterset,'Tpll') 
            VSM.PLL.T = parameterset.Tpll;
    else
        VSM.PLL.T  = 0.04; 
    end

    VSM.PLL.D  = 1;   % 1
    VSM.PLL.v0 = 1;
    VSM.PLL.kp = VSM.PLL.D/VSM.PLL.v0/VSM.PLL.T;  % 2*
    VSM.PLL.ki = 1/(VSM.PLL.v0*VSM.PLL.T^2);     % 1*   1/(VSM.PLL.v0*VSM.PLL.T^2)

    Tq = 0.01; % sec
    Td = 0.01; % sec
    Kq = 1; 
    Kd = 1;

    %% active damping

    VSM.VTFF.OmLead = 2*pi*50;
    VSM.VTFF.OmLag  = 2*pi*1100;


    %% Load Configuration


    if isfield (parameterset,'RoCoFup') && parameterset.RoCoFup ~= 0
       RoCoFup=parameterset.RoCoFup;
    else
        RoCoFup=0;
    end 

    if RoCoFup == 1
        % for frequency up with 2 Hz/s, after 0.65s frequency down
        mZC = 1;                         % 1= VSM1, 2= VSM2, 3=load, 4=bus, 5=feed0
    else
        % for frequency down with -2 Hz/s, after 0.65s frequency up
        factor_P = 1;
        mZC = 3;                         % 1= VSM1, 2= VSM2, 3=load, 4=bus, 5=feed0
    end

    feval(strcat('prm3var_',parameterrun.version));
    
    feval(strcat('UFLS3_',parameterrun.version));
    
    feval(strcat('simu3_',parameterset.simulation));

    if isfield (parameterset,'Sim') && isfield (parameterset.Sim,'tend')
       Sim.tend = parameterset.Sim.tend ;
    else
        Sim.tend = 10;
    end

    if isfield (parameterset,'Event') && isfield (parameterset.Event,'IslandingTime')
        Event.IslandingTime = parameterset.Event.IslandingTime;
    else
        Event.IslandingTime = 4;
    end

    if isfield (parameterset,'Event') && isfield (parameterset.Event,'LoadStepTime')
        Event.LoadStepTime = parameterset.Event.LoadStepTime;
    else
        Event.LoadStepTime = 4;
    end

    if isfield (parameterset,'Event') && isfield (parameterset.Event,'ring1_switch_time')
        Event.ring1_switch_time = parameterset.Event.ring1_switch_time;
    else
        Event.ring1_switch_time = 9e9;
    end

    if isfield (parameterset,'Event') && isfield (parameterset.Event,'ring2_switch_time')
        Event.ring2_switch_time = parameterset.Event.ring2_switch_time;
    else
        Event.ring2_switch_time = 9e9;
    end

    if isfield (parameterset,'Event') && isfield (parameterset.Event,'ring1_switch_direction')
        Event.ring1_switch_direction = parameterset.Event.ring1_switch_direction;
    else
        Event.ring1_switch_direction = 1;                          % 1=on, 0=off     
    end

    if isfield (parameterset,'Event') && isfield (parameterset.Event,'ring2_switch_direction')
        Event.ring2_switch_direction = parameterset.Event.ring2_switch_direction;
    else
        Event.ring2_switch_direction = 1;                          % 1=on, 0=off     
    end


    clear executiontype
    
    parameterrun.set_id(i) = (((((parameterrun.dFF(i,1)*10+parameterrun.dFF(i,2))*10+parameterrun.dFF(i,3))*10+parameterrun.dFF(i,4))*10+parameterrun.dFF(i,5))*10+parameterrun.dFF(i,6))*10+parameterrun.dFF(i,7);
    if parameterrun.setting == 'BDI'
        parameterrun.paramlist = [parameterrun.setting,parameterrun.version,' run ',num2str(i),' of ',num2str(size(parameterrun.dFF,1)),': ','dFF=',num2str(parameterrun.set_id(i)),' t0=',num2str(parameterset.Event.IslandingTime),'s,',' U=',num2str(parameterset.General.Vnreg/1000),'kV, cable=',num2str(parameterset.cable),' | ', 'RoCoFup=', num2str(parameterset.RoCoFup),' | ', 'lines*',num2str(parameterset.Li.length_factor),' | ', 'Tpll=',num2str(parameterset.Tpll),'s, Trv=',num2str(parameterset.Trv),'s',' | ','mode=',parameterrun.simmode,' | ', 'ring1=', num2str(parameterrun.ring1),' | ', 'ring2=', num2str(parameterrun.ring2)];
    else
        parameterrun.paramlist = [parameterrun.setting,parameterrun.version,' run ',num2str(i),' of ',num2str(size(parameterrun.dFF,1)),': ','dFF=',num2str(parameterrun.set_id(i)),' t0=',num2str(parameterset.Event.IslandingTime),'s,',' U=',num2str(parameterset.General.Vnreg/1000),'kV, cable=',num2str(parameterset.cable),' | ', 'RoCoFup=', num2str(parameterset.RoCoFup),' | ', 'lines*',num2str(parameterset.Li.length_factor),' | ',' | ','mode=',parameterrun.simmode,' | ', 'ring1=', num2str(parameterrun.ring1),' | ', 'ring2=', num2str(parameterrun.ring2)];
    end
    disp(parameterrun.paramlist);
   %sim(strcat(parameterrun.setting,parameterrun.version)); 
   %Older versions only, used, it is to be used, when different
   %Simulink models in the same version exist (e.g. BDI120 and UDI120)
    sim(strcat('A3VSM',parameterrun.version));
    save3simout_dFF;
    %comment previous two lines to evaluate already simulated runs
    disp(datestr(now, 'dd.mm.yyyy-HH:MM:SS'));

end   

disp([parameterrun.setting,parameterrun.version,' ',num2str(i),' runs finished.']);
    
clear(strcat('evaluation3_',parameterrun.version)); % see https://uk.mathworks.com/matlabcentral/answers/360769-call-function-when-the-function-name-is-saved-in-variable
feval(strcat('evaluation3_',parameterrun.version));

