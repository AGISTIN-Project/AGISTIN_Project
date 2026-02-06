
clear SimStruct

runname=strcat(parameterrun.setting,parameterrun.version,'_',num2str(parameterrun.dFF(i,1)),num2str(parameterrun.dFF(i,2)),num2str(parameterrun.dFF(i,3)),num2str(parameterrun.dFF(i,4)),num2str(parameterrun.dFF(i,5)),num2str(parameterrun.dFF(i,6)),num2str(parameterrun.dFF(i,7)));
savestart = find((tout-Event.IslandingTime) >= -1,1);                       %detemines the vector entry index 1s before islanding

SimStruct.paramlist = parameterrun.paramlist;

SimStruct.Timestamp = tout(savestart:end)-Event.IslandingTime;

if size(simout,1) ~= size(tout,1)
    SimStruct.warnings = ['##################################### WARNING: simout has size ',num2str(size(simout,1)),' whereas Timestamp has size ',num2str(size(Timestamp,1)),'############################'];
else
    SimStruct.warnings = 'none';
end    

i_save = 1;                                     %Variable to ease the selection of parameters
SimStruct.Inf_Vabc = simout(savestart:end,i_save:i_save+2);
    i_save = i_save+3 ;
SimStruct.feed0_Vabc = simout(savestart:end,i_save:i_save+2);
    i_save = i_save+3 ;
SimStruct.VSM1_Vabc = simout(savestart:end,i_save:i_save+2);
    i_save = i_save+3 ;
SimStruct.VSM2_Vabc = simout(savestart:end,i_save:i_save+2);
    i_save = i_save+3 ;
SimStruct.Load_Vabc = simout(savestart:end,i_save:i_save+2);
    i_save = i_save+3 ;

SimStruct.Inf_Iabc = simout(savestart:end,i_save:i_save+2);
    i_save = i_save+3 ;
SimStruct.feed0_Iabc = simout(savestart:end,i_save:i_save+2);
    i_save = i_save+3 ;
SimStruct.VSM1_Iabc = simout(savestart:end,i_save:i_save+2);
    i_save = i_save+3 ;
SimStruct.VSM2_Iabc = simout(savestart:end,i_save:i_save+2);
    i_save = i_save+3 ;
SimStruct.Load_Iabc = simout(savestart:end,i_save:i_save+2);
    i_save = i_save+3 ;
    
SimStruct.Inf_I = simout(savestart:end,i_save);
    i_save = i_save+1 ;
SimStruct.feed0_I = simout(savestart:end,i_save);
    i_save = i_save+1 ;
SimStruct.VSM1_I = simout(savestart:end,i_save);
    i_save = i_save+1 ;
SimStruct.VSM2_I = simout(savestart:end,i_save);
    i_save = i_save+1 ;
SimStruct.Load_I = simout(savestart:end,i_save);
    i_save = i_save+1 ;

SimStruct.Inf_V = simout(savestart:end,i_save);
    i_save = i_save+1 ;
SimStruct.feed0_V = simout(savestart:end,i_save);
    i_save = i_save+1 ;
SimStruct.VSM1_V = simout(savestart:end,i_save);
    i_save = i_save+1 ;
SimStruct.VSM2_V = simout(savestart:end,i_save);
    i_save = i_save+1 ;
SimStruct.Load_V = simout(savestart:end,i_save);
    i_save = i_save+1 ;

SimStruct.Inf_P = simout(savestart:end,i_save);
    i_save = i_save+1 ;
SimStruct.feed0_P = simout(savestart:end,i_save);
    i_save = i_save+1 ;
SimStruct.VSM1_P = simout(savestart:end,i_save);
    i_save = i_save+1 ;
SimStruct.VSM2_P = simout(savestart:end,i_save);
    i_save = i_save+1 ;
SimStruct.Load_P = simout(savestart:end,i_save);
    i_save = i_save+1 ;

SimStruct.Inf_Q = simout(savestart:end,i_save);
    i_save = i_save+1 ;
SimStruct.feed0_Q = simout(savestart:end,i_save);
    i_save = i_save+1 ;
SimStruct.VSM1_Q = simout(savestart:end,i_save);
    i_save = i_save+1 ;
SimStruct.VSM2_Q = simout(savestart:end,i_save);
    i_save = i_save+1 ;
SimStruct.Load_Q = simout(savestart:end,i_save);
    i_save = i_save+1 ;

SimStruct.Inf_f = simout(savestart:end,i_save);
    i_save = i_save+1 ;
SimStruct.feed0_f_intern = simout(savestart:end,i_save);
    i_save = i_save+1 ;
SimStruct.feed0_f_PWM = simout(savestart:end,i_save);
    i_save = i_save+1 ;
SimStruct.VSM1_f_intern = simout(savestart:end,i_save);
    i_save = i_save+1 ;
SimStruct.VSM1_f_PWM = simout(savestart:end,i_save);
    i_save = i_save+1 ;
SimStruct.VSM2_f_intern = simout(savestart:end,i_save);
    i_save = i_save+1 ;
SimStruct.VSM2_f_PWM = simout(savestart:end,i_save);
    i_save = i_save+1 ;
SimStruct.feed0_f = simout(savestart:end,i_save);
    i_save = i_save+1 ;
SimStruct.VSM1_f = simout(savestart:end,i_save);
    i_save = i_save+1 ;
SimStruct.VSM2_f = simout(savestart:end,i_save);
    i_save = i_save+1 ;
SimStruct.Load_f = simout(savestart:end,i_save);
    i_save = i_save+1 ;
SimStruct.bus_f = simout(savestart:end,i_save);
    i_save = i_save+1 ;
    
    
switch mZC
    case 1
        SimStruct.ZC_VSM1 = simout(savestart:end,i_save);
        SimStruct.ZC_VSM2 = 0;
        SimStruct.ZC_Load = 0;
        SimStruct.ZC_bus = 0;
        SimStruct.ZC_feed0 = 0;
    case 2
        SimStruct.ZC_VSM1 = 0;
        SimStruct.ZC_VSM2 = simout(savestart:end,i_save);
        SimStruct.ZC_Load = 0;
        SimStruct.ZC_bus = 0;
        SimStruct.ZC_feed0 = 0;
    case 3
        SimStruct.ZC_VSM1 = 0;
        SimStruct.ZC_VSM2 = 0;
        SimStruct.ZC_Load = simout(savestart:end,i_save);
        SimStruct.ZC_bus = 0;
        SimStruct.ZC_feed0 = 0;
    case 4
        SimStruct.ZC_VSM1 = 0;
        SimStruct.ZC_VSM2 = 0;
        SimStruct.ZC_Load = 0;
        SimStruct.ZC_bus = simout(savestart:end,i_save);
        SimStruct.ZC_feed0 = 0;
    case 5
        SimStruct.ZC_VSM1 = 0;
        SimStruct.ZC_VSM2 = 0;
        SimStruct.ZC_Load = 0;
        SimStruct.ZC_bus = 0;
        SimStruct.ZC_feed0 = simout(savestart:end,i_save);
    otherwise
        SimStruct.ZC_VSM1 = 0;
        SimStruct.ZC_VSM2 = 0;
        SimStruct.ZC_Load = 0;
        SimStruct.ZC_bus = 0;
        SimStruct.ZC_feed0 = 0;
end
    i_save = i_save+1 ;


SimStruct.Inf_Phi = simout(savestart:end,i_save);
    i_save = i_save+1 ;
SimStruct.feed0_Phi_intern = simout(savestart:end,i_save);
    i_save = i_save+1 ;
SimStruct.feed0_Phi_PWM = simout(savestart:end,i_save);
    i_save = i_save+1 ;
SimStruct.VSM1_Phi_intern = simout(savestart:end,i_save);
    i_save = i_save+1 ;
SimStruct.VSM1_Phi_PWM = simout(savestart:end,i_save);
    i_save = i_save+1 ;
SimStruct.VSM2_Phi_intern = simout(savestart:end,i_save);
    i_save = i_save+1 ;
SimStruct.VSM2_Phi_PWM = simout(savestart:end,i_save);
    i_save = i_save+1 ;
SimStruct.feed0_Phi = simout(savestart:end,i_save);
    i_save = i_save+1 ;
SimStruct.VSM1_Phi = simout(savestart:end,i_save);
    i_save = i_save+1 ;
SimStruct.VSM2_Phi = simout(savestart:end,i_save);
    i_save = i_save+1 ;
SimStruct.Load_Phi = simout(savestart:end,i_save);
    i_save = i_save+1 ;
SimStruct.bus_Phi = simout(savestart:end,i_save);
    i_save = i_save+1 ;

    
SimStruct.feed0_aux1a = simout(savestart:end,i_save);
    i_save = i_save+1 ;
SimStruct.VSM1_aux1a = simout(savestart:end,i_save);
    i_save = i_save+1 ;
SimStruct.VSM2_aux1a = simout(savestart:end,i_save);
    i_save = i_save+1 ;

SimStruct.feed0_aux2a = simout(savestart:end,i_save);
    i_save = i_save+1 ;
SimStruct.VSM1_aux2a = simout(savestart:end,i_save);
    i_save = i_save+1 ;
SimStruct.VSM2_aux2a = simout(savestart:end,i_save);
    i_save = i_save+1 ;

SimStruct.feed0_RoCoF = simout(savestart:end,i_save);
    i_save = i_save+1 ;
SimStruct.VSM1_RoCoF = simout(savestart:end,i_save);
    i_save = i_save+1 ;
SimStruct.VSM2_RoCoF = simout(savestart:end,i_save);
    i_save = i_save+1 ;

% used for evaluation of Pint, i.e. for key performance indicator(s)    
SimStruct.feed0_Pint = simout(savestart:end,i_save);
    i_save = i_save+1 ;
SimStruct.VSM1_Pint = simout(savestart:end,i_save);
    i_save = i_save+1 ;
SimStruct.VSM2_Pint = simout(savestart:end,i_save);
    i_save = i_save+1 ;

save(strcat('z',runname,'.mat'), '-struct', 'SimStruct')
