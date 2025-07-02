
        begin1 = 0.0;                         % [s] begin of 1st time window for osc-detection
        begin2 = 0.2;                       % [s] begin of 2nd time window for osc-detection
        begin3 = parameterset.time_to_loadstep;                       % [s] begin of 3rd time window for osc-detection (immediately after end of RoCoF)
        begin4 = min(1.0,parameterset.time_after_islanding-0.05);                         % [s] begin of 4th time window for osc-detection; for the end use :end

        widthV = 15;                        % Spannung mit unter 2 ms ausgewertet
        widthIabc = 7;                         % Strom mit unter 1 ms ausgewertet
        threshold_osc_f = 3e-6;                       %threshold for when a value is set to zero
        threshold_osc_P = 3e-5;                       %threshold for when a value is set to zero
        threshold_osc_V = 1e-5;                       %threshold for when a value is set to zero
        
        eval.allsets_winmax_V(1:6)=0;
        eval.allsets_winmin_V(1:6)=10;
        eval.set_winmax_V(6) = 0;
        eval.set_winmin_V(6) = 0;
        eval.allsets_max_V(1:6)=0;            %necessary initialisation 
        eval.allsets_min_V(1:6)=10;           % 10 is used to overwrite the defaultvalue of zero
        eval.set_max_V(6) = 0;
        eval.set_min_V(6) = 0;
        
        eval.allsets_max_Iabc(1:10)=0;
        eval.allsets_max_Iabc(6)=10;
        eval.allsets_max_Iabc(8)=10;
        eval.allsets_max_Iabc(10)=10;
        eval.allsets_winmax_Iabc(1:4)=0;
        eval.set_max_Iabc(10)  = 0;
        eval.set_winmax_Iabc(4) = 0;
        
        eval.allsets_max_aux1 = 0;
        eval.set_max_aux1=0;
        
        eval.allsets_max_Vabc(1:4) = 0;
        eval.set_max_Vabc = 0;

        eval.allsets_max_P_feed0(1:6) = -10;
        eval.allsets_min_P_feed0(1:6) = 10;
        eval.set_max_P_feed0(6) = 0;
        eval.set_min_P_feed0(6) = 0;
        eval.allsets_max_P_VSM12(1:10) = -10;
        eval.allsets_min_P_VSM12(1:10) = 10;
        eval.set_max_P_VSM12(10) = 0;
        eval.set_min_P_VSM12(10) = 0;
        
        eval.allsets_max_Pint_feed0(1:6) = -100;
        eval.allsets_min_Pint_feed0(1:6) = 100;
        eval.set_max_Pint_feed0(6) = 0;
        eval.set_min_Pint_feed0(6) = 0;
        eval.allsets_max_Pint_VSM12(1:10) = -100;
        eval.allsets_min_Pint_VSM12(1:10) = 100;
        eval.set_max_Pint_VSM12(10) = 0;
        eval.set_min_Pint_VSM12(10) = 0;
        
        eval.allsets_posmax_RoCoF(1:9) = -100;
        eval.allsets_posmin_RoCoF(1:9) = 100;
        eval.set_posmax_RoCoF(9) = 0;
        eval.set_posmin_RoCoF(9) = 0;
        eval.allsets_negmax_RoCoF(1:9) = -100;
        eval.allsets_negmin_RoCoF(1:9) = 100;
        eval.set_negmax_RoCoF(9) = 0;
        eval.set_negmin_RoCoF(9) = 0;
        
        eval.allsets_max_PPset_t0(1:3) = -10;
        eval.allsets_min_PPset_t0(1:3) = 10;
        eval.set_max_PPset_t0(3) = 0;
        eval.set_min_PPset_t0(3) = 0;

        eval.allsets_max_f_t0(1:3) = 40.0;
        eval.allsets_min_f_t0(1:3) = 60.0;
        eval.set_max_f_t0(3) = 0;
        eval.set_min_f_t0(3) = 0;

        eval.allsets_plus_osc_f(1:5) = 0;
        eval.allsets_base_osc_f(1:5) = 9e9;
        eval.set_maxosc_f(5) = 0;
        
        eval.allsets_plus_osc_P(1:5) = 0;
        eval.allsets_base_osc_P(1:5) = 9e9;
        eval.set_maxosc_P(5) = 0;
        
        eval.allsets_plus_osc_V(1:5) = 0;
        eval.allsets_base_osc_V(1:5) = 9e9;
        eval.set_maxosc_V(5) = 0;

for i=1:parameterrun.row
    
    name=strcat('z',parameterrun.setting,parameterrun.version,'_',num2str(parameterrun.set_id(i)));
    load(strcat(name,'.mat'));
    
    paramlistname = strcat('paramlist',num2str(parameterrun.set_id(i)));
    eval.(paramlistname) = paramlist;

    warningsname = strcat('WARNING',num2str(parameterrun.set_id(i)));
    if size(warnings,2) > 4
        eval.(warningsname) = warnings;
    end
    
    if size(Timestamp,1) <= 8000
        errorname = strcat('ERROR',num2str(parameterrun.set_id(i)));
        eval.(errorname) = ['############################################ ERROR: This simulation has been aborted!!'];
    else

        from1 = find(Timestamp>=begin1-parameterset.TS/2,1);          % 0 s   --> 8001
        fro2 = find(Timestamp>=begin2-parameterset.TS/2,1)-(from1-1);     % 0.1 s -->  8801 - 8000 = 801
        fro3 = find(Timestamp>=begin3-parameterset.TS/2,1)-(from1-1);     % 0.7 s --> 13601 - 8000 = 5601
        fro4 = find(Timestamp>=begin4-parameterset.TS/2,1)-(from1-1);     % 0.8 s --> 14401 - 8000 = 6401

        winmaxname=strcat(name,'_winmax_V');
        winminname=strcat(name,'_winmin_V');
        maxname=strcat(name,'_max_V');
        minname=strcat(name,'_min_V');
        
        winmaxname_Iabc=strcat(name,'_winmax_Iabc');
        maxname_Iabc=strcat(name,'_max_Iabc');
        
        maxname_Vabc=strcat(name,'_max_Vabc');
        name_osc_f=strcat(name,'_osc_f');
        name_osc_P=strcat(name,'_osc_P');
        name_osc_V=strcat(name,'_osc_V');
          
       
%% window
        winmin_Load_V  = 10;
        winmin_Inf_V   = 10;
        winmin_feed0_V = 10;
        winmin_VSM1_V  = 10;
        winmin_VSM2_V  = 10;
        winmax_Load_V  = 0;
        winmax_Inf_V   = 0;
        winmax_feed0_V = 0;
        winmax_VSM1_V  = 0;
        winmax_VSM2_V  = 0;
        
        % winmax/min V first, hence these variables come first

        for i1=1:(size(Timestamp,1)-widthV)
            % This approach ignores some spikes at the beginning and end of the
            % time, which is intended.

            if Inf_V(i1) > winmax_Inf_V
               if Inf_V(i1) <= Inf_V(i1+widthV)
                   winmax_Inf_V=Inf_V(i1);
               elseif Inf_V(i1+widthV) > winmax_Inf_V
                   winmax_Inf_V=Inf_V(i1+widthV);
               end
            end 
            if feed0_V(i1) > winmax_feed0_V
               if feed0_V(i1) <= feed0_V(i1+widthV)
                   winmax_feed0_V=feed0_V(i1);
               elseif feed0_V(i1+widthV) > winmax_feed0_V
                   winmax_feed0_V=feed0_V(i1+widthV);
               end
            end 
            if VSM1_V(i1) > winmax_VSM1_V
               if VSM1_V(i1) <= VSM1_V(i1+widthV)
                   winmax_VSM1_V=VSM1_V(i1);
               elseif VSM1_V(i1+widthV) > winmax_VSM1_V
                   winmax_VSM1_V=VSM1_V(i1+widthV);
               end
            end 
            if VSM2_V(i1) > winmax_VSM2_V
               if VSM2_V(i1) <= VSM2_V(i1+widthV)
                   winmax_VSM2_V=VSM2_V(i1);
               elseif VSM2_V(i1+widthV) > winmax_VSM2_V
                   winmax_VSM2_V=VSM2_V(i1+widthV);
               end
            end 
            if Load_V(i1) > winmax_Load_V
               if Load_V(i1) <= Load_V(i1+widthV)
                   winmax_Load_V=Load_V(i1);
               elseif Load_V(i1+widthV) > winmax_Load_V
                   winmax_Load_V=Load_V(i1+widthV);
               end
            end 

            % winmin

            if Inf_V(i1) < winmin_Inf_V
               if Inf_V(i1) >= Inf_V(i1+widthV)
                   winmin_Inf_V=Inf_V(i1);
               elseif Inf_V(i1+widthV) < winmin_Inf_V
                   winmin_Inf_V=Inf_V(i1+widthV);
               end
            end 
            if feed0_V(i1) < winmin_feed0_V
               if feed0_V(i1) >= feed0_V(i1+widthV)
                   winmin_feed0_V=feed0_V(i1);
               elseif feed0_V(i1+widthV) < winmin_feed0_V
                   winmin_feed0_V=feed0_V(i1+widthV);
               end
            end 
            if VSM1_V(i1) < winmin_VSM1_V
               if VSM1_V(i1) >= VSM1_V(i1+widthV)
                   winmin_VSM1_V=VSM1_V(i1);
               elseif VSM1_V(i1+widthV) < winmin_VSM1_V
                   winmin_VSM1_V=VSM1_V(i1+widthV);
               end
            end 
            if VSM2_V(i1) < winmin_VSM2_V
               if VSM2_V(i1) >= VSM2_V(i1+widthV)
                   winmin_VSM2_V=VSM2_V(i1);
               elseif VSM2_V(i1+widthV) < winmin_VSM2_V
                   winmin_VSM2_V=VSM2_V(i1+widthV);
               end
            end 
            if Load_V(i1) < winmin_Load_V
               if Load_V(i1) >= Load_V(i1+widthV)
                   winmin_Load_V=Load_V(i1);
               elseif Load_V(i1+widthV) < winmin_Load_V
                   winmin_Load_V=Load_V(i1+widthV);
               end
            end
        end    
        eval.(winmaxname) = [max([winmax_Inf_V,winmax_feed0_V,winmax_VSM1_V,winmax_VSM2_V,winmax_Load_V]) winmax_Inf_V winmax_feed0_V winmax_VSM1_V winmax_VSM2_V winmax_Load_V];
        eval.(winminname) = [min([winmin_Inf_V,winmin_feed0_V,winmin_VSM1_V,winmin_VSM2_V,winmin_Load_V]) winmin_Inf_V winmin_feed0_V winmin_VSM1_V winmin_VSM2_V winmin_Load_V];

        
        % max, min ...
        
        eval.(maxname)(2) = max(Inf_V);
        if eval.allsets_max_V(2) < eval.(maxname)(2)
           eval.allsets_max_V(2) = eval.(maxname)(2); 
           eval.set_max_V(2) = parameterrun.set_id(i);
        end 
        eval.(maxname)(3) = max(feed0_V);
        if eval.allsets_max_V(3) < eval.(maxname)(3)
           eval.allsets_max_V(3) = eval.(maxname)(3); 
           eval.set_max_V(3) = parameterrun.set_id(i);
        end 
        eval.(maxname)(4) = max(VSM1_V);
        if eval.allsets_max_V(4) < eval.(maxname)(4)
           eval.allsets_max_V(4) = eval.(maxname)(4); 
           eval.set_max_V(4) = parameterrun.set_id(i);
        end
        eval.(maxname)(5) = max(VSM2_V);
        if eval.allsets_max_V(5) < eval.(maxname)(5)
           eval.allsets_max_V(5) = eval.(maxname)(5); 
           eval.set_max_V(5) = parameterrun.set_id(i);
        end
        eval.(maxname)(6) = max(Load_V);
        if eval.allsets_max_V(6) < eval.(maxname)(6)
           eval.allsets_max_V(6) = eval.(maxname)(6); 
           eval.set_max_V(6) = parameterrun.set_id(i);
           
        end
        eval.(maxname)(1) = max(eval.(maxname)(2:6));
        if eval.allsets_max_V(1) < eval.(maxname)(1)
            eval.allsets_max_V(1) = eval.(maxname)(1);
            eval.set_max_V(1) = parameterrun.set_id(i);
        end
        
        eval.(minname)(2) = min(Inf_V);
        if eval.allsets_min_V(2) > eval.(minname)(2)
           eval.allsets_min_V(2) = eval.(minname)(2); 
           eval.set_min_V(2) = parameterrun.set_id(i);
        end 
        eval.(minname)(3) = min(feed0_V);
        if eval.allsets_min_V(3) > eval.(minname)(3)
           eval.allsets_min_V(3) = eval.(minname)(3); 
           eval.set_min_V(3) = parameterrun.set_id(i);
        end 
        eval.(minname)(4) = min(VSM1_V);
        if eval.allsets_min_V(4) > eval.(minname)(4)
           eval.allsets_min_V(4) = eval.(minname)(4); 
           eval.set_min_V(4) = parameterrun.set_id(i);
        end
        eval.(minname)(5) = min(VSM2_V);
        if eval.allsets_min_V(5) > eval.(minname)(5)
           eval.allsets_min_V(5) = eval.(minname)(5); 
           eval.set_min_V(5) = parameterrun.set_id(i);
        end
        eval.(minname)(6) = min(Load_V);
        if eval.allsets_min_V(6) > eval.(minname)(6)
           eval.allsets_min_V(6) = eval.(minname)(6); 
           eval.set_min_V(6) = parameterrun.set_id(i);
        end
        eval.(minname)(1) = min(eval.(minname)(2:6));
        if eval.allsets_min_V(1) > eval.(minname)(1)
            eval.allsets_min_V(1) = eval.(minname)(1);
            eval.set_min_V(1) = parameterrun.set_id(i);
        end
        
        %global max of Vabc 
        eval.(maxname_Vabc)(2) = max(max(abs(feed0_Vabc)));
        if eval.allsets_max_Vabc(2) < eval.(maxname_Vabc)(2)
           eval.allsets_max_Vabc(2) = eval.(maxname_Vabc)(2); 
           eval.set_max_Vabc(2) = parameterrun.set_id(i);
        end 
        eval.(maxname_Vabc)(3) = max(max(abs(VSM1_Vabc)));
        if eval.allsets_max_Vabc(3) < eval.(maxname_Vabc)(3)
           eval.allsets_max_Vabc(3) = eval.(maxname_Vabc)(3); 
           eval.set_max_Vabc(3) = parameterrun.set_id(i);
        end 
        eval.(maxname_Vabc)(4) = max(max(abs(VSM2_Vabc)));
        if eval.allsets_max_Vabc(4) < eval.(maxname_Vabc)(4)
           eval.allsets_max_Vabc(4) = eval.(maxname_Vabc)(4); 
           eval.set_max_Vabc(4) = parameterrun.set_id(i);
        end
        eval.(maxname_Vabc)(1) = max(eval.(maxname_Vabc)(2:4));
        if eval.allsets_max_Vabc(1) < eval.(maxname_Vabc)(1)
            eval.allsets_max_Vabc(1) = eval.(maxname_Vabc)(1);
            eval.set_max_Vabc(1) = parameterrun.set_id(i);
        end
        
        
        %Currents 
        eval.(maxname_Iabc)(2) = max(max(abs(feed0_Iabc)));
        if eval.allsets_max_Iabc(2) < eval.(maxname_Iabc)(2)
           eval.allsets_max_Iabc(2) = eval.(maxname_Iabc)(2); 
           eval.set_max_Iabc(2) = parameterrun.set_id(i);
        end 
        eval.(maxname_Iabc)(3) = max(max(abs(VSM1_Iabc)));
        if eval.allsets_max_Iabc(3) < eval.(maxname_Iabc)(3)
           eval.allsets_max_Iabc(3) = eval.(maxname_Iabc)(3); 
           eval.set_max_Iabc(3) = parameterrun.set_id(i);
        end 
        eval.(maxname_Iabc)(4) = max(max(abs(VSM2_Iabc)));
        if eval.allsets_max_Iabc(4) < eval.(maxname_Iabc)(4)
           eval.allsets_max_Iabc(4) = eval.(maxname_Iabc)(4); 
           eval.set_max_Iabc(4) = parameterrun.set_id(i);
        end
        eval.(maxname_Iabc)(1) = max(eval.(maxname_Iabc)(2:4));
        if eval.allsets_max_Iabc(1) < eval.(maxname_Iabc)(1)
            eval.allsets_max_Iabc(1) = eval.(maxname_Iabc)(1);
            eval.set_max_Iabc(1) = parameterrun.set_id(i);
        end
        Tsteady = find(Timestamp>=begin1-parameterset.TS/2,1)-5;
        eval.(maxname_Iabc)(5) = feed0_I(Tsteady);
        if eval.allsets_max_Iabc(5) < eval.(maxname_Iabc)(5)
           eval.allsets_max_Iabc(5) = eval.(maxname_Iabc)(5); 
           eval.set_max_Iabc(5) = parameterrun.set_id(i);
        end 
        eval.(maxname_Iabc)(6) = feed0_I(Tsteady);
        if eval.allsets_max_Iabc(6) > eval.(maxname_Iabc)(6)
           eval.allsets_max_Iabc(6) = eval.(maxname_Iabc)(6); 
           eval.set_max_Iabc(6) = parameterrun.set_id(i);
        end 
        eval.(maxname_Iabc)(7) = VSM1_I(Tsteady);
        if eval.allsets_max_Iabc(7) < eval.(maxname_Iabc)(7)
           eval.allsets_max_Iabc(7) = eval.(maxname_Iabc)(7); 
           eval.set_max_Iabc(7) = parameterrun.set_id(i);
        end 
        eval.(maxname_Iabc)(8) = VSM1_I(Tsteady);
        if eval.allsets_max_Iabc(8) > eval.(maxname_Iabc)(8)
           eval.allsets_max_Iabc(8) = eval.(maxname_Iabc)(8); 
           eval.set_max_Iabc(8) = parameterrun.set_id(i);
        end 
        eval.(maxname_Iabc)(9) = VSM2_I(Tsteady);
        if eval.allsets_max_Iabc(9) < eval.(maxname_Iabc)(9)
           eval.allsets_max_Iabc(9) = eval.(maxname_Iabc)(9); 
           eval.set_max_Iabc(9) = parameterrun.set_id(i);
        end 
        eval.(maxname_Iabc)(10) = VSM2_I(Tsteady);
        if eval.allsets_max_Iabc(10) > eval.(maxname_Iabc)(10)
           eval.allsets_max_Iabc(10) = eval.(maxname_Iabc)(10); 
           eval.set_max_Iabc(10) = parameterrun.set_id(i);
        end 
        
        %winmax for currents
       
        winmax_feed0_Iabc = 0;
        winmax_VSM1_Iabc  = 0;
        winmax_VSM2_Iabc  = 0;
        for i1=1:(size(Timestamp,1)-widthIabc)
            % This approach ignores some spikes at the beginning and end of the
            % time, which is intended.

            if max(abs(feed0_Iabc(i1,:))) > winmax_feed0_Iabc
               if max(abs(feed0_Iabc(i1,:))) <= max(abs(feed0_Iabc(i1+widthIabc,:)))
                   winmax_feed0_Iabc=max(abs(feed0_Iabc(i1,:)));
               elseif max(abs(feed0_Iabc(i1+widthIabc,:))) > winmax_feed0_Iabc
                   winmax_feed0_Iabc=max(abs(feed0_Iabc((i1+widthIabc),:)));
               end
            end   
            if max(abs(VSM1_Iabc(i1,:))) > winmax_VSM1_Iabc
               if max(abs(VSM1_Iabc(i1,:))) <= max(abs(VSM1_Iabc(i1+widthIabc,:)))
                   winmax_VSM1_Iabc=max(abs(VSM1_Iabc(i1,:)));
               elseif max(abs(VSM1_Iabc(i1+widthIabc,:))) > winmax_VSM1_Iabc
                   winmax_VSM1_Iabc=max(abs(VSM1_Iabc(i1+widthIabc,:)));
               end
            end
            if max(abs(VSM2_Iabc(i1,:))) > winmax_VSM2_Iabc
               if max(abs(VSM2_Iabc(i1,:))) <= max(abs(VSM2_Iabc(i1+widthIabc,:)))
                   winmax_VSM2_Iabc=max(abs(VSM2_Iabc(i1,:)));
               elseif max(abs(VSM2_Iabc(i1+widthIabc,:))) > winmax_VSM2_Iabc
                   winmax_VSM2_Iabc=max(abs(VSM2_Iabc(i1+widthIabc,:)));
               end
            end
        end
        eval.(winmaxname_Iabc) = [max([winmax_feed0_Iabc,winmax_VSM1_Iabc,winmax_VSM2_Iabc]) winmax_feed0_Iabc winmax_VSM1_Iabc winmax_VSM2_Iabc];
   
        % allsets_winmax/min
        
        if eval.allsets_winmax_V(2) < winmax_Inf_V
           eval.allsets_winmax_V(2) = winmax_Inf_V; 
           eval.set_winmax_V(2) = parameterrun.set_id(i);
        end 
        if eval.allsets_winmax_V(3) < winmax_feed0_V
           eval.allsets_winmax_V(3) = winmax_feed0_V; 
           eval.set_winmax_V(3) = parameterrun.set_id(i);
        end 
        if eval.allsets_winmax_V(4) < winmax_VSM1_V
           eval.allsets_winmax_V(4) = winmax_VSM1_V; 
           eval.set_winmax_V(4) = parameterrun.set_id(i);
        end
        if eval.allsets_winmax_V(5) < winmax_VSM2_V
           eval.allsets_winmax_V(5) = winmax_VSM2_V; 
           eval.set_winmax_V(5) = parameterrun.set_id(i);
        end
        if eval.allsets_winmax_V(6) < winmax_Load_V
           eval.allsets_winmax_V(6) = winmax_Load_V; 
           eval.set_winmax_V(6) = parameterrun.set_id(i);
        end
        if eval.allsets_winmax_V(1) < max(eval.allsets_winmax_V(2:6))
            eval.allsets_winmax_V(1) = max(eval.allsets_winmax_V(2:6));
            eval.set_winmax_V(1) = parameterrun.set_id(i);
        end

        if eval.allsets_winmin_V(2) > winmin_Inf_V
           eval.allsets_winmin_V(2) = winmin_Inf_V; 
           eval.set_winmin_V(2) = parameterrun.set_id(i);
        end 
        if eval.allsets_winmin_V(3) > winmin_feed0_V
           eval.allsets_winmin_V(3) = winmin_feed0_V; 
           eval.set_winmin_V(3) = parameterrun.set_id(i);
        end 
        if eval.allsets_winmin_V(4) > winmin_VSM1_V
           eval.allsets_winmin_V(4) = winmin_VSM1_V; 
           eval.set_winmin_V(4) = parameterrun.set_id(i);
        end
        if eval.allsets_winmin_V(5) > winmin_VSM2_V
           eval.allsets_winmin_V(5) = winmin_VSM2_V; 
           eval.set_winmin_V(5) = parameterrun.set_id(i);
        end
        if eval.allsets_winmin_V(6) > winmin_Load_V
           eval.allsets_winmin_V(6) = winmin_Load_V; 
           eval.set_winmin_V(6) = parameterrun.set_id(i);
        end
        if eval.allsets_winmin_V(1) > min(eval.allsets_winmin_V(2:6))
            eval.allsets_winmin_V(1) = min(eval.allsets_winmin_V(2:6));
            eval.set_winmin_V(1) = parameterrun.set_id(i);
        end
        
        if eval.allsets_winmax_Iabc(2) < winmax_feed0_Iabc
           eval.allsets_winmax_Iabc(2) = winmax_feed0_Iabc; 
           eval.set_winmax_Iabc(2) = parameterrun.set_id(i);
        end 
        if eval.allsets_winmax_Iabc(3) < winmax_VSM1_Iabc
           eval.allsets_winmax_Iabc(3) = winmax_VSM1_Iabc; 
           eval.set_winmax_Iabc(3) = parameterrun.set_id(i);
        end 
        if eval.allsets_winmax_Iabc(4) < winmax_VSM2_Iabc
           eval.allsets_winmax_Iabc(4) = winmax_VSM2_Iabc; 
           eval.set_winmax_Iabc(4) = parameterrun.set_id(i);
        end
        if eval.allsets_winmax_Iabc(1) < max(eval.allsets_winmax_Iabc(2:4))
            eval.allsets_winmax_Iabc(1) = max(eval.allsets_winmax_Iabc(2:4));
            eval.set_winmax_Iabc(1) = parameterrun.set_id(i);
        end
        
        %max of VSM aux a
        maxname_aux1=strcat(name,'_max_aux1');
        arr = cat(2,max(abs(VSM1_aux1a(1:8000))),max(abs(VSM2_aux1a(1:8000))),max(abs(feed0_aux1a(1:8000)))); 
        eval.(maxname_aux1) = max(arr);
        if eval.(maxname_aux1) >  eval.allsets_max_aux1
                 eval.allsets_max_aux1 = eval.(maxname_aux1);
                 eval.set_max_aux1 = parameterrun.set_id(i);
        end

        
        % P/Q/W evaluation
        
        t_0 = find(Timestamp>=begin1-parameterset.TS/2,1);            %  --> 8001
        t_before0 = t_0-1;                                            %  --> 8000
        t_rocof1end = find(Timestamp>=begin3-parameterset.TS/2,1)-1;  %  --> 13600
       
        name_P_feed0=strcat(name,'_P_feed0');
        name_P_VSM12=strcat(name,'_P_VSM12');
        eval.(name_P_feed0)(2) = Inf_Q(t_before0);            % Q_inf before system split

        % feed0
        eval.(name_P_feed0)(3) = feed0_P(t_before0);           % P before system split
        eval.(name_P_feed0)(6) = feed0_P(t_rocof1end);         % P before end of first RoCoF
        % P overshoot and reverse overshoot immediately after system split
        Pav = eval.(name_P_feed0)(3);
        eval.(name_P_feed0)(1) = (sum(feed0_P(t_0:t_rocof1end))-Pav*(t_rocof1end-t_0+1))*parameterset.TS;  % Delta W
        if mod(parameterrun.set_id(i),1000000) < 200000                                  % i.e. RoCoFup was = 1 for this set, upper part of if clause used for RoCoFup = 1, else statement used when RoCoFup = 0
            eval.(name_P_feed0)(4) = min(feed0_P(t_0:t_rocof1end));                        % P at overshoot
            t_overshoot = t_0-1+find(feed0_P(t_0:t_rocof1end)==eval.(name_P_feed0)(4),1);
            eval.(name_P_feed0)(5) = max(feed0_P(t_overshoot:t_rocof1end));                % P at reverse overshoot
            t_Wend = t_overshoot;
            t_Wend = t_Wend-2+find(feed0_P(t_Wend:t_rocof1end)>=Pav,1);
            while size(t_Wend,1) > 0
                eval.(name_P_feed0)(1) = min(eval.(name_P_feed0)(1) , (sum(feed0_P(t_0:t_Wend))-Pav*(t_Wend-t_0+1))*parameterset.TS);
                t_Wend = t_Wend+1;
                t_Wend = t_Wend-1+find(feed0_P(t_Wend:t_rocof1end)<Pav,1);
                t_Wend = t_Wend-2+find(feed0_P(t_Wend:t_rocof1end)>=Pav,1);
            end
        else
            eval.(name_P_feed0)(4) = max(feed0_P(t_0:t_rocof1end));
            t_overshoot = t_0-1+find(feed0_P(t_0:t_rocof1end)==eval.(name_P_feed0)(4),1);
            eval.(name_P_feed0)(5) = min(feed0_P(t_overshoot:t_rocof1end));
            t_Wend = t_overshoot;
            t_Wend = t_Wend-2+find(feed0_P(t_Wend:t_rocof1end)<=Pav,1);
            while size(t_Wend,1) > 0
                eval.(name_P_feed0)(1) = max(eval.(name_P_feed0)(1) , (sum(feed0_P(t_0:t_Wend))-Pav*(t_Wend-t_0+1))*parameterset.TS);
                t_Wend = t_Wend+1;
                t_Wend = t_Wend-1+find(feed0_P(t_Wend:t_rocof1end)>Pav,1);
                t_Wend = t_Wend-2+find(feed0_P(t_Wend:t_rocof1end)<=Pav,1);
            end
        end
        
        % P_feed0 max/min
        for i1 = 1:6
            if eval.allsets_max_P_feed0(i1) < eval.(name_P_feed0)(i1)
                eval.allsets_max_P_feed0(i1) = eval.(name_P_feed0)(i1);
                eval.set_max_P_feed0(i1) = parameterrun.set_id(i);
            end
            if eval.allsets_min_P_feed0(i1) > eval.(name_P_feed0)(i1)
                eval.allsets_min_P_feed0(i1) = eval.(name_P_feed0)(i1);
                eval.set_min_P_feed0(i1) = parameterrun.set_id(i);
            end
        end
        
        % VSM1
        eval.(name_P_VSM12)(3) = VSM1_P(t_before0);           % P before system split
        eval.(name_P_VSM12)(6) = VSM1_P(t_rocof1end);         % P before end of first RoCoF
        % P overshoot and reverse overshoot immediately after system split
        Pav = eval.(name_P_VSM12)(3);
        eval.(name_P_VSM12)(1) = (sum(VSM1_P(t_0:t_rocof1end))-Pav*(t_rocof1end-t_0+1))*parameterset.TS;  % Delta W
        if mod(parameterrun.set_id(i),1000000) < 200000                                  % i.e. RoCoFup was = 1 for this set
            eval.(name_P_VSM12)(4) = min(VSM1_P(t_0:t_rocof1end));                        % P at overshoot
            t_overshoot = t_0-1+find(VSM1_P(t_0:t_rocof1end)==eval.(name_P_VSM12)(4),1);
            eval.(name_P_VSM12)(5) = max(VSM1_P(t_overshoot:t_rocof1end));                % P at reverse overshoot
            t_Wend = t_overshoot;
            t_Wend = t_Wend-2+find(VSM1_P(t_Wend:t_rocof1end)>=Pav,1);
            while size(t_Wend,1) > 0
                eval.(name_P_VSM12)(1) = min(eval.(name_P_VSM12)(1) , (sum(VSM1_P(t_0:t_Wend))-Pav*(t_Wend-t_0+1))*parameterset.TS);
                t_Wend = t_Wend+1;
                t_Wend = t_Wend-1+find(VSM1_P(t_Wend:t_rocof1end)<Pav,1);
                t_Wend = t_Wend-2+find(VSM1_P(t_Wend:t_rocof1end)>=Pav,1);
            end
        else
            eval.(name_P_VSM12)(4) = max(VSM1_P(t_0:t_rocof1end));
            t_overshoot = t_0-1+find(VSM1_P(t_0:t_rocof1end)==eval.(name_P_VSM12)(4),1);
            eval.(name_P_VSM12)(5) = min(VSM1_P(t_overshoot:t_rocof1end));
            t_Wend = t_overshoot;
            t_Wend = t_Wend-2+find(VSM1_P(t_Wend:t_rocof1end)<=Pav,1);
            while size(t_Wend,1) > 0
                eval.(name_P_VSM12)(1) = max(eval.(name_P_VSM12)(1) , (sum(VSM1_P(t_0:t_Wend))-Pav*(t_Wend-t_0+1))*parameterset.TS);
                t_Wend = t_Wend+1;
                t_Wend = t_Wend-1+find(VSM1_P(t_Wend:t_rocof1end)>Pav,1);
                t_Wend = t_Wend-2+find(VSM1_P(t_Wend:t_rocof1end)<=Pav,1);
            end
        end

        
        % VSM2
        eval.(name_P_VSM12)(7) = VSM2_P(t_before0);           % P before system split
        eval.(name_P_VSM12)(10) = VSM2_P(t_rocof1end);         % P before end of first RoCoF
        % P overshoot and reverse overshoot immediately after system split
        Pav = eval.(name_P_VSM12)(7);
        eval.(name_P_VSM12)(2) = (sum(VSM2_P(t_0:t_rocof1end))-Pav*(t_rocof1end-t_0+1))*parameterset.TS;  % Delta W
        if mod(parameterrun.set_id(i),1000000) < 200000                                  % i.e. RoCoFup was = 1 for this set
            eval.(name_P_VSM12)(8) = min(VSM2_P(t_0:t_rocof1end));                        % P at overshoot
            t_overshoot = t_0-1+find(VSM2_P(t_0:t_rocof1end)==eval.(name_P_VSM12)(8),1);
            eval.(name_P_VSM12)(9) = max(VSM2_P(t_overshoot:t_rocof1end));                % P at reverse overshoot
            t_Wend = t_overshoot;
            t_Wend = t_Wend-2+find(VSM2_P(t_Wend:t_rocof1end)>=Pav,1);
            while size(t_Wend,1) > 0
                eval.(name_P_VSM12)(2) = min(eval.(name_P_VSM12)(2) , (sum(VSM2_P(t_0:t_Wend))-Pav*(t_Wend-t_0+1))*parameterset.TS);
                t_Wend = t_Wend+1;
                t_Wend = t_Wend-1+find(VSM2_P(t_Wend:t_rocof1end)<Pav,1);
                t_Wend = t_Wend-2+find(VSM2_P(t_Wend:t_rocof1end)>=Pav,1);
            end
        else
            eval.(name_P_VSM12)(8) = max(VSM2_P(t_0:t_rocof1end));
            t_overshoot = t_0-1+find(VSM2_P(t_0:t_rocof1end)==eval.(name_P_VSM12)(8),1);
            eval.(name_P_VSM12)(9) = min(VSM2_P(t_overshoot:t_rocof1end));
            t_Wend = t_overshoot;
            t_Wend = t_Wend-2+find(VSM2_P(t_Wend:t_rocof1end)<=Pav,1);
            while size(t_Wend,1) > 0
                eval.(name_P_VSM12)(2) = max(eval.(name_P_VSM12)(2) , (sum(VSM2_P(t_0:t_Wend))-Pav*(t_Wend-t_0+1))*parameterset.TS);
                t_Wend = t_Wend+1;
                t_Wend = t_Wend-1+find(VSM2_P(t_Wend:t_rocof1end)>Pav,1);
                t_Wend = t_Wend-2+find(VSM2_P(t_Wend:t_rocof1end)<=Pav,1);
            end
        end


        % P_VSM12 max/min
        for i1 = 1:10
            if eval.allsets_max_P_VSM12(i1) < eval.(name_P_VSM12)(i1)
                eval.allsets_max_P_VSM12(i1) = eval.(name_P_VSM12)(i1);
                eval.set_max_P_VSM12(i1) = parameterrun.set_id(i);
            end
            if eval.allsets_min_P_VSM12(i1) > eval.(name_P_VSM12)(i1)
                eval.allsets_min_P_VSM12(i1) = eval.(name_P_VSM12)(i1);
                eval.set_min_P_VSM12(i1) = parameterrun.set_id(i);
            end
        end


        name_Pint_feed0=strcat(name,'_Pint_feed0');
        name_Pint_VSM12=strcat(name,'_Pint_VSM12');
        eval.(name_Pint_feed0)(2) = Inf_Q(t_before0);            % Q_inf before system split

        % VSM1
        eval.(name_Pint_VSM12)(3) = VSM1_Pint(t_before0);           % P before system split
        eval.(name_Pint_VSM12)(6) = VSM1_Pint(t_rocof1end);         % P before end of first RoCoF
        % P overshoot and reverse overshoot immediately after system split
        Pav = eval.(name_Pint_VSM12)(3);
        if mod(parameterrun.set_id(i),1000000) < 200000                                  % i.e. RoCoFup was = 1 for this set
            eval.(name_Pint_VSM12)(1) = min(0 , (sum(VSM1_Pint(t_0:t_rocof1end))-Pav*(t_rocof1end-t_0+1))*parameterset.TS);  % Delta W
            eval.(name_Pint_VSM12)(4) = min(VSM1_Pint(t_0:t_rocof1end));                        % P at overshoot
            t_overshoot = t_0-1+find(VSM1_Pint(t_0:t_rocof1end)==eval.(name_Pint_VSM12)(4),1);
            eval.(name_Pint_VSM12)(5) = max(VSM1_Pint(t_overshoot:t_rocof1end));                % P at backswing
            t_Wend = t_overshoot;
            t_Wend = t_Wend-2+find(VSM1_Pint(t_Wend:t_rocof1end)>=Pav,1);
            while size(t_Wend,1) > 0
                eval.(name_Pint_VSM12)(1) = min(eval.(name_Pint_VSM12)(1) , (sum(VSM1_Pint(t_0:t_Wend))-Pav*(t_Wend-t_0+1))*parameterset.TS);
                t_Wend = t_Wend+1;
                t_Wend = t_Wend-1+find(VSM1_Pint(t_Wend:t_rocof1end)<Pav,1);
                t_Wend = t_Wend-2+find(VSM1_Pint(t_Wend:t_rocof1end)>=Pav,1);
            end
        else
            eval.(name_Pint_VSM12)(1) = max(0 , (sum(VSM1_Pint(t_0:t_rocof1end))-Pav*(t_rocof1end-t_0+1))*parameterset.TS);  % Delta W
            eval.(name_Pint_VSM12)(4) = max(VSM1_Pint(t_0:t_rocof1end));
            t_overshoot = t_0-1+find(VSM1_Pint(t_0:t_rocof1end)==eval.(name_Pint_VSM12)(4),1);
            eval.(name_Pint_VSM12)(5) = min(VSM1_Pint(t_overshoot:t_rocof1end));
            t_Wend = t_overshoot;
            t_Wend = t_Wend-2+find(VSM1_Pint(t_Wend:t_rocof1end)<=Pav,1);
            while size(t_Wend,1) > 0
                eval.(name_Pint_VSM12)(1) = max(eval.(name_Pint_VSM12)(1) , (sum(VSM1_Pint(t_0:t_Wend))-Pav*(t_Wend-t_0+1))*parameterset.TS);
                t_Wend = t_Wend+1;
                t_Wend = t_Wend-1+find(VSM1_Pint(t_Wend:t_rocof1end)>Pav,1);
                t_Wend = t_Wend-2+find(VSM1_Pint(t_Wend:t_rocof1end)<=Pav,1);
            end
        end

        
        % VSM2
        eval.(name_Pint_VSM12)(7) = VSM2_Pint(t_before0);           % P before system split
        eval.(name_Pint_VSM12)(10) = VSM2_Pint(t_rocof1end);         % P before end of first RoCoF
        % P overshoot and reverse overshoot immediately after system split
        Pav = eval.(name_Pint_VSM12)(7);
        if mod(parameterrun.set_id(i),1000000) < 200000                                  % i.e. RoCoFup was = 1 for this set
            eval.(name_Pint_VSM12)(2) = min(0 , (sum(VSM2_Pint(t_0:t_rocof1end))-Pav*(t_rocof1end-t_0+1))*parameterset.TS);  % Delta W
            eval.(name_Pint_VSM12)(8) = min(VSM2_Pint(t_0:t_rocof1end));                        % P at overshoot
            t_overshoot = t_0-1+find(VSM2_Pint(t_0:t_rocof1end)==eval.(name_Pint_VSM12)(8),1);
            eval.(name_Pint_VSM12)(9) = max(VSM2_Pint(t_overshoot:t_rocof1end));                % P at backswing
            t_Wend = t_overshoot;
            t_Wend = t_Wend-2+find(VSM2_Pint(t_Wend:t_rocof1end)>=Pav,1);
            while size(t_Wend,1) > 0
                eval.(name_Pint_VSM12)(2) = min(eval.(name_Pint_VSM12)(2) , (sum(VSM2_Pint(t_0:t_Wend))-Pav*(t_Wend-t_0+1))*parameterset.TS);
                t_Wend = t_Wend+1;
                t_Wend = t_Wend-1+find(VSM2_Pint(t_Wend:t_rocof1end)<Pav,1);
                t_Wend = t_Wend-2+find(VSM2_Pint(t_Wend:t_rocof1end)>=Pav,1);
            end
        else
            eval.(name_Pint_VSM12)(2) = max(0 , (sum(VSM2_Pint(t_0:t_rocof1end))-Pav*(t_rocof1end-t_0+1))*parameterset.TS);  % Delta W
            eval.(name_Pint_VSM12)(8) = max(VSM2_Pint(t_0:t_rocof1end));
            t_overshoot = t_0-1+find(VSM2_Pint(t_0:t_rocof1end)==eval.(name_Pint_VSM12)(8),1);
            eval.(name_Pint_VSM12)(9) = min(VSM2_Pint(t_overshoot:t_rocof1end));
            t_Wend = t_overshoot;
            t_Wend = t_Wend-2+find(VSM2_Pint(t_Wend:t_rocof1end)<=Pav,1);
            while size(t_Wend,1) > 0
                eval.(name_Pint_VSM12)(2) = max(eval.(name_Pint_VSM12)(2) , (sum(VSM2_Pint(t_0:t_Wend))-Pav*(t_Wend-t_0+1))*parameterset.TS);
                t_Wend = t_Wend+1;
                t_Wend = t_Wend-1+find(VSM2_Pint(t_Wend:t_rocof1end)>Pav,1);
                t_Wend = t_Wend-2+find(VSM2_Pint(t_Wend:t_rocof1end)<=Pav,1);
            end
        end


        % P_VSM12 max/min
        for i1 = 1:10
            if eval.allsets_max_Pint_VSM12(i1) < eval.(name_Pint_VSM12)(i1)
                eval.allsets_max_Pint_VSM12(i1) = eval.(name_Pint_VSM12)(i1);
                eval.set_max_Pint_VSM12(i1) = parameterrun.set_id(i);
            end
            if eval.allsets_min_Pint_VSM12(i1) > eval.(name_Pint_VSM12)(i1)
                eval.allsets_min_Pint_VSM12(i1) = eval.(name_Pint_VSM12)(i1);
                eval.set_min_Pint_VSM12(i1) = parameterrun.set_id(i);
            end
        end


        % feed0
        eval.(name_Pint_feed0)(3) = feed0_Pint(t_before0);           % P before system split
        eval.(name_Pint_feed0)(6) = feed0_Pint(t_rocof1end);         % P before end of first RoCoF
        % P overshoot and reverse overshoot immediately after system split
        Pav = eval.(name_Pint_feed0)(3);
        if mod(parameterrun.set_id(i),1000000) < 200000                                  % i.e. RoCoFup was = 1 for this set, upper part of if clause used for RoCoFup = 1, else statement used when RoCoFup = 0
            eval.(name_Pint_feed0)(1) = min(0 , (sum(feed0_Pint(t_0:t_rocof1end))-Pav*(t_rocof1end-t_0+1))*parameterset.TS);  % Delta W
            eval.(name_Pint_feed0)(4) = min(feed0_Pint(t_0:t_rocof1end));                        % P at overshoot
            t_overshoot = t_0-1+find(feed0_Pint(t_0:t_rocof1end)==eval.(name_Pint_feed0)(4),1);
            eval.(name_Pint_feed0)(5) = max(feed0_Pint(t_overshoot:t_rocof1end));                % P at backswing
            t_Wend = t_overshoot;
            t_Wend = t_Wend-2+find(feed0_Pint(t_Wend:t_rocof1end)>=Pav,1);
            while size(t_Wend,1) > 0
                eval.(name_Pint_feed0)(1) = min(eval.(name_Pint_feed0)(1) , (sum(feed0_Pint(t_0:t_Wend))-Pav*(t_Wend-t_0+1))*parameterset.TS);
                t_Wend = t_Wend+1;
                t_Wend = t_Wend-1+find(feed0_Pint(t_Wend:t_rocof1end)<Pav,1);
                t_Wend = t_Wend-2+find(feed0_Pint(t_Wend:t_rocof1end)>=Pav,1);
            end
        else
            eval.(name_Pint_feed0)(1) = max(0 , (sum(feed0_Pint(t_0:t_rocof1end))-Pav*(t_rocof1end-t_0+1))*parameterset.TS);  % Delta W
            eval.(name_Pint_feed0)(4) = max(feed0_Pint(t_0:t_rocof1end));
            t_overshoot = t_0-1+find(feed0_Pint(t_0:t_rocof1end)==eval.(name_Pint_feed0)(4),1);
            eval.(name_Pint_feed0)(5) = min(feed0_Pint(t_overshoot:t_rocof1end));
            t_Wend = t_overshoot;
            t_Wend = t_Wend-2+find(feed0_Pint(t_Wend:t_rocof1end)<=Pav,1);
            while size(t_Wend,1) > 0
                eval.(name_Pint_feed0)(1) = max(eval.(name_Pint_feed0)(1) , (sum(feed0_Pint(t_0:t_Wend))-Pav*(t_Wend-t_0+1))*parameterset.TS);
                t_Wend = t_Wend+1;
                t_Wend = t_Wend-1+find(feed0_Pint(t_Wend:t_rocof1end)>Pav,1);
                t_Wend = t_Wend-2+find(feed0_Pint(t_Wend:t_rocof1end)<=Pav,1);
            end
        end
        
        % Pint_feed0 max/min
        for i1 = 1:6
            if eval.allsets_max_Pint_feed0(i1) < eval.(name_Pint_feed0)(i1)
                eval.allsets_max_Pint_feed0(i1) = eval.(name_Pint_feed0)(i1);
                eval.set_max_Pint_feed0(i1) = parameterrun.set_id(i);
            end
            if eval.allsets_min_Pint_feed0(i1) > eval.(name_Pint_feed0)(i1)
                eval.allsets_min_Pint_feed0(i1) = eval.(name_Pint_feed0)(i1);
                eval.set_min_Pint_feed0(i1) = parameterrun.set_id(i);
            end
        end
        
        
        %rocofs

        name_rocof=strcat(name,'_rocof');
        sec07 = min(0.7,parameterset.time_after_islanding-0.05);
        sec2  = min(2,parameterset.time_after_islanding-0.05);

        if parameterrun.setting == 'UDI'
            eval.(name_rocof)(4)=mean([feed0_f_intern(find(Timestamp >=sec07,1)-2),VSM1_f_intern(find(Timestamp >=sec07,1)-2),VSM2_f_intern(find(Timestamp >=sec07,1)-2)])-50;
            eval.(name_rocof)(5)=mean([feed0_f_intern(find(Timestamp >=0,1)-1),VSM1_f_intern(find(Timestamp >=0,1)-1),VSM2_f_intern(find(Timestamp >=0,1)-1)])-50;

            eval.(name_rocof)(8)=mean([feed0_f_intern(end),VSM1_f_intern(end),VSM2_f_intern(end)])-50;
            eval.(name_rocof)(9)=mean([feed0_f_intern(find(Timestamp >=sec2,1)),VSM1_f_intern(find(Timestamp >=sec2,1)),VSM2_f_intern(find(Timestamp >=sec2,1))])-50;

        elseif parameterrun.setting == 'BDI'
            eval.(name_rocof)(4)=mean([VSM1_f_intern(find(Timestamp >=sec07,1)-2),VSM2_f_intern(find(Timestamp >=sec07,1)-2)])-50;
            eval.(name_rocof)(5)=mean([VSM1_f_intern(find(Timestamp >=0,1)-1),VSM2_f_intern(find(Timestamp >=0,1)-1)])-50;

            eval.(name_rocof)(8)=mean([VSM1_f_intern(end),VSM2_f_intern(end)])-50;
            eval.(name_rocof)(9)=mean([VSM1_f_intern(find(Timestamp >=sec2,1)),VSM2_f_intern(find(Timestamp >=sec2,1))])-50;
        
        
        end

        eval.(name_rocof)(6)=eval.(name_rocof)(4)+50-(feed0_f_intern(find(Timestamp >=sec07,1)-2));
        eval.(name_rocof)(7)=eval.(name_rocof)(5)+50-(feed0_f_intern(find(Timestamp >=0,1)-1));
        
        eval.(name_rocof)(1)=(eval.(name_rocof)(4)-eval.(name_rocof)(5))/0.7;
        eval.(name_rocof)(2)=(eval.(name_rocof)(8)-eval.(name_rocof)(9))/(Timestamp(end)-2);
        eval.(name_rocof)(3)=-1.3*eval.(name_rocof)(2)+(eval.(name_rocof)(9)+50) - (eval.(name_rocof)(4)+50);
        

        if eval.(name_rocof)(1) > 0
            for i1=1:9
                if eval.allsets_posmax_RoCoF(i1) < eval.(name_rocof)(i1)
                    eval.allsets_posmax_RoCoF(i1) = eval.(name_rocof)(i1);
                    eval.set_posmax_RoCoF(i1) = parameterrun.set_id(i);
                end
                if eval.allsets_posmin_RoCoF(i1) > eval.(name_rocof)(i1)
                    eval.allsets_posmin_RoCoF(i1) = eval.(name_rocof)(i1);
                    eval.set_posmin_RoCoF(i1) = parameterrun.set_id(i);
                end
            end
        end
        
        if eval.(name_rocof)(1) < 0
            for i1=1:9
                if eval.allsets_negmax_RoCoF(i1) < eval.(name_rocof)(i1)
                    eval.allsets_negmax_RoCoF(i1) = eval.(name_rocof)(i1);
                    eval.set_negmax_RoCoF(i1) = parameterrun.set_id(i);
                end
                if eval.allsets_negmin_RoCoF(i1) > eval.(name_rocof)(i1)
                    eval.allsets_negmin_RoCoF(i1) = eval.(name_rocof)(i1);
                    eval.set_negmin_RoCoF(i1) = parameterrun.set_id(i);
                end
            end
        end
                
        %P-Pset min/max

        name_PPset_t0=strcat(name,'_PPset_t0');
        eval.(name_PPset_t0)(1)=feed0_Pint(t_before0)-prm_vsm{1,3};
        if eval.allsets_max_PPset_t0(1) < eval.(name_PPset_t0)(1)
            eval.allsets_max_PPset_t0(1) = eval.(name_PPset_t0)(1);
            eval.set_max_PPset_t0(1) = parameterrun.set_id(i);
        end
        if eval.allsets_min_PPset_t0(1) > eval.(name_PPset_t0)(1)
            eval.allsets_min_PPset_t0(1) = eval.(name_PPset_t0)(1);
            eval.set_min_PPset_t0(1) = parameterrun.set_id(i);
        end
        eval.(name_PPset_t0)(2)=VSM1_Pint(t_before0)-prm_vsm{1,4};
        if eval.allsets_max_PPset_t0(2) < eval.(name_PPset_t0)(2)
            eval.allsets_max_PPset_t0(2) = eval.(name_PPset_t0)(2);
            eval.set_max_PPset_t0(2) = parameterrun.set_id(i);
        end
        if eval.allsets_min_PPset_t0(2) > eval.(name_PPset_t0)(2)
            eval.allsets_min_PPset_t0(2) = eval.(name_PPset_t0)(2);
            eval.set_min_PPset_t0(2) = parameterrun.set_id(i);
        end
        eval.(name_PPset_t0)(3)=VSM2_Pint(t_before0)-prm_vsm{1,2};
        if eval.allsets_max_PPset_t0(3) < eval.(name_PPset_t0)(3)
            eval.allsets_max_PPset_t0(3) = eval.(name_PPset_t0)(3);
            eval.set_max_PPset_t0(3) = parameterrun.set_id(i);
        end
        if eval.allsets_min_PPset_t0(3) > eval.(name_PPset_t0)(3)
            eval.allsets_min_PPset_t0(3) = eval.(name_PPset_t0)(3);
            eval.set_min_PPset_t0(3) = parameterrun.set_id(i);
        end

        %f-min/max

        name_f_t0=strcat(name,'_f_t0');
        eval.(name_f_t0)(1)=feed0_f_intern(t_before0);
        if eval.allsets_max_f_t0(1) < eval.(name_f_t0)(1)
            eval.allsets_max_f_t0(1) = eval.(name_f_t0)(1);
            eval.set_max_f_t0(1) = parameterrun.set_id(i);
        end
        if eval.allsets_min_f_t0(1) > eval.(name_f_t0)(1)
            eval.allsets_min_f_t0(1) = eval.(name_f_t0)(1);
            eval.set_min_f_t0(1) = parameterrun.set_id(i);
        end
        eval.(name_f_t0)(2)=VSM1_f_intern(t_before0);
        if eval.allsets_max_f_t0(2) < eval.(name_f_t0)(2)
            eval.allsets_max_f_t0(2) = eval.(name_f_t0)(2);
            eval.set_max_f_t0(2) = parameterrun.set_id(i);
        end
        if eval.allsets_min_f_t0(2) > eval.(name_f_t0)(2)
            eval.allsets_min_f_t0(2) = eval.(name_f_t0)(2);
            eval.set_min_f_t0(2) = parameterrun.set_id(i);
        end
        eval.(name_f_t0)(3)=VSM2_f_intern(t_before0);
        if eval.allsets_max_f_t0(3) < eval.(name_f_t0)(3)
            eval.allsets_max_f_t0(3) = eval.(name_f_t0)(3);
            eval.set_max_f_t0(3) = parameterrun.set_id(i);
        end
        if eval.allsets_min_f_t0(3) > eval.(name_f_t0)(3)
            eval.allsets_min_f_t0(3) = eval.(name_f_t0)(3);
            eval.set_min_f_t0(3) = parameterrun.set_id(i);
        end

        %detection oscillations 
        
        osc.d2_f_feed0 = diff(diff(feed0_f_intern(from1-2:end)));   % must start at from1-2 in order to get all 2nd derivations influenced by from1
        osc.d2_f_VSM1 = diff(diff(VSM1_f_intern(from1-2:end)));
        osc.d2_f_VSM2 = diff(diff(VSM2_f_intern(from1-2:end)));
            
        for i1=1:(size(Timestamp,1)-(from1-3)-2)
           if abs(osc.d2_f_feed0(i1)) < threshold_osc_f
               osc.d2_f_feed0(i1) = 0;
           end
           if abs(osc.d2_f_VSM1(i1)) < threshold_osc_f
                osc.d2_f_VSM1(i1) = 0;
           end
           if abs(osc.d2_f_VSM2(i1)) < threshold_osc_f
                osc.d2_f_VSM2(i1) = 0;
           end
        end
            osc.d2_f_feed0_area1 = osc.d2_f_feed0(1:fro2-1);   % must include exactly fro2-1 elements because the following element is the first one influenced by fro2
            osc.d2_f_feed0_area1non0 =osc.d2_f_feed0_area1(osc.d2_f_feed0_area1~=0);
            osc.d2_f_feed0_area2 = osc.d2_f_feed0(fro2:fro3-1);
            osc.d2_f_feed0_area2non0 =osc.d2_f_feed0_area2(osc.d2_f_feed0_area2~=0);
            osc.d2_f_feed0_area3 = osc.d2_f_feed0(fro3:fro4-1);
            osc.d2_f_feed0_area3non0 =osc.d2_f_feed0_area3(osc.d2_f_feed0_area3~=0);
            osc.d2_f_feed0_area4 = osc.d2_f_feed0(fro4:end);
            osc.d2_f_feed0_area4non0 =osc.d2_f_feed0_area4(osc.d2_f_feed0_area4~=0);
            
            osc.d2_f_VSM1_area1 = osc.d2_f_VSM1(1:fro2-1);
            osc.d2_f_VSM1_area1non0 =osc.d2_f_VSM1_area1(osc.d2_f_VSM1_area1~=0);
            osc.d2_f_VSM1_area2 = osc.d2_f_VSM1(fro2:fro3-1);
            osc.d2_f_VSM1_area2non0 =osc.d2_f_VSM1_area2(osc.d2_f_VSM1_area2~=0);
            osc.d2_f_VSM1_area3 = osc.d2_f_VSM1(fro3:fro4-1);
            osc.d2_f_VSM1_area3non0 = osc.d2_f_VSM1_area3(osc.d2_f_VSM1_area3~=0);
            osc.d2_f_VSM1_area4 = osc.d2_f_VSM1(fro4:end);
            osc.d2_f_VSM1_area4non0 =osc.d2_f_VSM1_area4(osc.d2_f_VSM1_area4~=0);
            
            osc.d2_f_VSM2_area1 = osc.d2_f_VSM2(1:fro2-1);
            osc.d2_f_VSM2_area1non0 =osc.d2_f_VSM2_area1(osc.d2_f_VSM2_area1~=0);
            osc.d2_f_VSM2_area2 = osc.d2_f_VSM2(fro2:fro3-1);
            osc.d2_f_VSM2_area2non0 =osc.d2_f_VSM2_area2(osc.d2_f_VSM2_area2~=0);
            osc.d2_f_VSM2_area3 = osc.d2_f_VSM2(fro3:fro4-1);
            osc.d2_f_VSM2_area3non0 =osc.d2_f_VSM2_area3(osc.d2_f_VSM2_area3~=0);
            osc.d2_f_VSM2_area4 = osc.d2_f_VSM2(fro4:end);
            osc.d2_f_VSM2_area4non0 =osc.d2_f_VSM2_area4(osc.d2_f_VSM2_area4~=0);
               
            

            eval.(name_osc_f)(2)=max([max(size(find([diff(sign(osc.d2_f_feed0_area1non0))]~=0))),max(size(find([diff(sign(osc.d2_f_VSM1_area1non0))]~=0))),max(size(find([diff(sign(osc.d2_f_VSM2_area1non0))]~=0)))]);
            eval.(name_osc_f)(3)=max([max(size(find([diff(sign(osc.d2_f_feed0_area2non0))]~=0))),max(size(find([diff(sign(osc.d2_f_VSM1_area2non0))]~=0))),max(size(find([diff(sign(osc.d2_f_VSM2_area2non0))]~=0)))]);
            eval.(name_osc_f)(4)=max([max(size(find([diff(sign(osc.d2_f_feed0_area3non0))]~=0))),max(size(find([diff(sign(osc.d2_f_VSM1_area3non0))]~=0))),max(size(find([diff(sign(osc.d2_f_VSM2_area3non0))]~=0)))]);
            eval.(name_osc_f)(5)=max([max(size(find([diff(sign(osc.d2_f_feed0_area4non0))]~=0))),max(size(find([diff(sign(osc.d2_f_VSM1_area4non0))]~=0))),max(size(find([diff(sign(osc.d2_f_VSM2_area4non0))]~=0)))]);
            eval.(name_osc_f)(1)=max(eval.(name_osc_f)(2:5));
            
        for i1=1:5
            if eval.allsets_plus_osc_f(i1) < eval.(name_osc_f)(i1)
                eval.allsets_plus_osc_f(i1) = eval.(name_osc_f)(i1);
                eval.set_maxosc_f(i1) = parameterrun.set_id(i);
            end
            if eval.allsets_base_osc_f(i1) > eval.(name_osc_f)(i1)
                eval.allsets_base_osc_f(i1) = eval.(name_osc_f)(i1);
            end
        end
        
        osc.d2_P_feed0 = diff(diff(feed0_P(from1-2:end)));
        osc.d2_P_VSM1 = diff(diff(VSM1_P(from1-2:end)));
        osc.d2_P_VSM2 = diff(diff(VSM2_P(from1-2:end)));
            
        for i1=1:(size(Timestamp,1)-(from1-3)-2)
           if abs(osc.d2_P_feed0(i1)) < threshold_osc_P
               osc.d2_P_feed0(i1) = 0;
           end
           if abs(osc.d2_P_VSM1(i1)) < threshold_osc_P
                osc.d2_P_VSM1(i1) = 0;
           end
           if abs(osc.d2_P_VSM2(i1)) < threshold_osc_P
                osc.d2_P_VSM2(i1) = 0;
           end
        end
            osc.d2_P_feed0_area1 = osc.d2_P_feed0(1:fro2-1);   
            osc.d2_P_feed0_area1non0 =osc.d2_P_feed0_area1(osc.d2_P_feed0_area1~=0);
            osc.d2_P_feed0_area2 = osc.d2_P_feed0(fro2:fro3-1);
            osc.d2_P_feed0_area2non0 =osc.d2_P_feed0_area2(osc.d2_P_feed0_area2~=0);
            osc.d2_P_feed0_area3 = osc.d2_P_feed0(fro3:fro4-1);
            osc.d2_P_feed0_area3non0 =osc.d2_P_feed0_area3(osc.d2_P_feed0_area3~=0);
            osc.d2_P_feed0_area4 = osc.d2_P_feed0(fro4:end);
            osc.d2_P_feed0_area4non0 =osc.d2_P_feed0_area4(osc.d2_P_feed0_area4~=0);
            
            osc.d2_P_VSM1_area1 = osc.d2_P_VSM1(1:fro2-1);
            osc.d2_P_VSM1_area1non0 =osc.d2_P_VSM1_area1(osc.d2_P_VSM1_area1~=0);
            osc.d2_P_VSM1_area2 = osc.d2_P_VSM1(fro2:fro3-1);
            osc.d2_P_VSM1_area2non0 =osc.d2_P_VSM1_area2(osc.d2_P_VSM1_area2~=0);
            osc.d2_P_VSM1_area3 = osc.d2_P_VSM1(fro3:fro4-1);
            osc.d2_P_VSM1_area3non0 = osc.d2_P_VSM1_area3(osc.d2_P_VSM1_area3~=0);
            osc.d2_P_VSM1_area4 = osc.d2_P_VSM1(fro4:end);
            osc.d2_P_VSM1_area4non0 =osc.d2_P_VSM1_area4(osc.d2_P_VSM1_area4~=0);
            
            osc.d2_P_VSM2_area1 = osc.d2_P_VSM2(1:fro2-1);
            osc.d2_P_VSM2_area1non0 =osc.d2_P_VSM2_area1(osc.d2_P_VSM2_area1~=0);
            osc.d2_P_VSM2_area2 = osc.d2_P_VSM2(fro2:fro3-1);
            osc.d2_P_VSM2_area2non0 =osc.d2_P_VSM2_area2(osc.d2_P_VSM2_area2~=0);
            osc.d2_P_VSM2_area3 = osc.d2_P_VSM2(fro3:fro4-1);
            osc.d2_P_VSM2_area3non0 =osc.d2_P_VSM2_area3(osc.d2_P_VSM2_area3~=0);
            osc.d2_P_VSM2_area4 = osc.d2_P_VSM2(fro4:end);
            osc.d2_P_VSM2_area4non0 =osc.d2_P_VSM2_area4(osc.d2_P_VSM2_area4~=0);
               
            

            eval.(name_osc_P)(2)=max([max(size(find([diff(sign(osc.d2_P_feed0_area1non0))]~=0))),max(size(find([diff(sign(osc.d2_P_VSM1_area1non0))]~=0))),max(size(find([diff(sign(osc.d2_P_VSM2_area1non0))]~=0)))]);
            eval.(name_osc_P)(3)=max([max(size(find([diff(sign(osc.d2_P_feed0_area2non0))]~=0))),max(size(find([diff(sign(osc.d2_P_VSM1_area2non0))]~=0))),max(size(find([diff(sign(osc.d2_P_VSM2_area2non0))]~=0)))]);
            eval.(name_osc_P)(4)=max([max(size(find([diff(sign(osc.d2_P_feed0_area3non0))]~=0))),max(size(find([diff(sign(osc.d2_P_VSM1_area3non0))]~=0))),max(size(find([diff(sign(osc.d2_P_VSM2_area3non0))]~=0)))]);
            eval.(name_osc_P)(5)=max([max(size(find([diff(sign(osc.d2_P_feed0_area4non0))]~=0))),max(size(find([diff(sign(osc.d2_P_VSM1_area4non0))]~=0))),max(size(find([diff(sign(osc.d2_P_VSM2_area4non0))]~=0)))]);
            eval.(name_osc_P)(1)=max(eval.(name_osc_P)(2:5));
            
        for i1=1:5
            if eval.allsets_plus_osc_P(i1) < eval.(name_osc_P)(i1)
                eval.allsets_plus_osc_P(i1) = eval.(name_osc_P)(i1);
                eval.set_maxosc_P(i1) = parameterrun.set_id(i);
            end
            if eval.allsets_base_osc_P(i1) > eval.(name_osc_P)(i1)
                eval.allsets_base_osc_P(i1) = eval.(name_osc_P)(i1);
            end
        end
        
        osc.d2_V_feed0 = diff(diff(feed0_V(from1-2:end)));
        osc.d2_V_VSM1 = diff(diff(VSM1_V(from1-2:end)));
        osc.d2_V_VSM2 = diff(diff(VSM2_V(from1-2:end)));
            
        for i1=1:(size(Timestamp,1)-(from1-3)-2)
           if abs(osc.d2_V_feed0(i1)) < threshold_osc_V
               osc.d2_V_feed0(i1) = 0;
           end
           if abs(osc.d2_V_VSM1(i1)) < threshold_osc_V
                osc.d2_V_VSM1(i1) = 0;
           end
           if abs(osc.d2_V_VSM2(i1)) < threshold_osc_V
                osc.d2_V_VSM2(i1) = 0;
           end
        end
            osc.d2_V_feed0_area1 = osc.d2_V_feed0(1:fro2-1);   
            osc.d2_V_feed0_area1non0 =osc.d2_V_feed0_area1(osc.d2_V_feed0_area1~=0);
            osc.d2_V_feed0_area2 = osc.d2_V_feed0(fro2-1:fro3-2);
            osc.d2_V_feed0_area2non0 =osc.d2_V_feed0_area2(osc.d2_V_feed0_area2~=0);
            osc.d2_V_feed0_area3 = osc.d2_V_feed0(fro3-1:fro4-2);
            osc.d2_V_feed0_area3non0 =osc.d2_V_feed0_area3(osc.d2_V_feed0_area3~=0);
            osc.d2_V_feed0_area4 = osc.d2_V_feed0(fro4-1:end);
            osc.d2_V_feed0_area4non0 =osc.d2_V_feed0_area4(osc.d2_V_feed0_area4~=0);
           
            osc.d2_V_VSM1_area1 = osc.d2_V_VSM1(1:fro2-1);
            osc.d2_V_VSM1_area1non0 =osc.d2_V_VSM1_area1(osc.d2_V_VSM1_area1~=0);
            osc.d2_V_VSM1_area2 = osc.d2_V_VSM1(fro2:fro3-1);
            osc.d2_V_VSM1_area2non0 =osc.d2_V_VSM1_area2(osc.d2_V_VSM1_area2~=0);
            osc.d2_V_VSM1_area3 = osc.d2_V_VSM1(fro3:fro4-1);
            osc.d2_V_VSM1_area3non0 = osc.d2_V_VSM1_area3(osc.d2_V_VSM1_area3~=0);
            osc.d2_V_VSM1_area4 = osc.d2_V_VSM1(fro4:end);
            osc.d2_V_VSM1_area4non0 =osc.d2_V_VSM1_area4(osc.d2_V_VSM1_area4~=0);
           
            osc.d2_V_VSM2_area1 = osc.d2_V_VSM2(1:fro2-1);
            osc.d2_V_VSM2_area1non0 =osc.d2_V_VSM2_area1(osc.d2_V_VSM2_area1~=0);
            osc.d2_V_VSM2_area2 = osc.d2_V_VSM2(fro2:fro3-1);
            osc.d2_V_VSM2_area2non0 =osc.d2_V_VSM2_area2(osc.d2_V_VSM2_area2~=0);
            osc.d2_V_VSM2_area3 = osc.d2_V_VSM2(fro3:fro4-1);
            osc.d2_V_VSM2_area3non0 =osc.d2_V_VSM2_area3(osc.d2_V_VSM2_area3~=0);
            osc.d2_V_VSM2_area4 = osc.d2_V_VSM2(fro4:end);
            osc.d2_V_VSM2_area4non0 =osc.d2_V_VSM2_area4(osc.d2_V_VSM2_area4~=0);
               
            

            eval.(name_osc_V)(2)=max([max(size(find([diff(sign(osc.d2_V_feed0_area1non0))]~=0))),max(size(find([diff(sign(osc.d2_V_VSM1_area1non0))]~=0))),max(size(find([diff(sign(osc.d2_V_VSM2_area1non0))]~=0)))]);
            eval.(name_osc_V)(3)=max([max(size(find([diff(sign(osc.d2_V_feed0_area2non0))]~=0))),max(size(find([diff(sign(osc.d2_V_VSM1_area2non0))]~=0))),max(size(find([diff(sign(osc.d2_V_VSM2_area2non0))]~=0)))]);
            eval.(name_osc_V)(4)=max([max(size(find([diff(sign(osc.d2_V_feed0_area3non0))]~=0))),max(size(find([diff(sign(osc.d2_V_VSM1_area3non0))]~=0))),max(size(find([diff(sign(osc.d2_V_VSM2_area3non0))]~=0)))]);
            eval.(name_osc_V)(5)=max([max(size(find([diff(sign(osc.d2_V_feed0_area4non0))]~=0))),max(size(find([diff(sign(osc.d2_V_VSM1_area4non0))]~=0))),max(size(find([diff(sign(osc.d2_V_VSM2_area4non0))]~=0)))]);
            eval.(name_osc_V)(1)=max(eval.(name_osc_V)(2:5));
            
        for i1=1:5
            if eval.allsets_plus_osc_V(i1) < eval.(name_osc_V)(i1)
                eval.allsets_plus_osc_V(i1) = eval.(name_osc_V)(i1);
                eval.set_maxosc_V(i1) = parameterrun.set_id(i);
            end
            if eval.allsets_base_osc_V(i1) > eval.(name_osc_V)(i1)
                eval.allsets_base_osc_V(i1) = eval.(name_osc_V)(i1);
            end
        end
        clear osc
        
    end
    
    %eval.deltaW(i)=eval.(name_Pint_feed0)(1);
end

%WS: Dies darf erst nach Ende aller Durchl ufe passieren.
eval.allsets_plus_osc_f = eval.allsets_plus_osc_f-eval.allsets_base_osc_f;
eval.allsets_plus_osc_P = eval.allsets_plus_osc_P-eval.allsets_base_osc_P;
eval.allsets_plus_osc_V = eval.allsets_plus_osc_V-eval.allsets_base_osc_V;
%space for graphical outputs
%boxplot(eval.deltaW)

    disp('evaluation done')
    disp(datestr(now, 'dd.mm.yyyy-HH:MM:SS'));

save(strcat('eval3_',parameterrun.version,'_',num2str(parameterrun.dFF(end,:)),'_',datestr(now, 'yyyymmdd-HHMM'),'.mat'), 'eval')
save(strcat('Z:\\WSchittek_results\\eval3_',parameterrun.version,'_',num2str(parameterrun.dFF(end,:)),'_',datestr(now, 'yyyymmdd-HHMM'),'.mat'), 'eval')
