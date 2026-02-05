%% Load simulation data
      
    dT=out.GHPdet.Time;
    % Active power 
    dPpv=out.GHPdet.Data(:,1)/1e3;
    dPely=out.GHPdet.Data(:,2)/1e3;
    dPsc=out.GHPdet.Data(:,3)/1e3;
    dPgrid=out.GHPdet.Data(:,4)/1e3;
    % Reactive power 
    dQpv=out.GHPdet.Data(:,5)/1e3;
    dQely=out.GHPdet.Data(:,6)/1e3;
    dQsc=out.GHPdet.Data(:,7)/1e3;
    dQgrid=out.GHPdet.Data(:,8)/1e3;
    % Voltage
    dVpv=out.GHPdet.Data(:,9)/(sqrt(2)*230);
    dVely=out.GHPdet.Data(:,10)/(sqrt(2)*230);
    dVsc=out.GHPdet.Data(:,11)/(sqrt(2)*230);
    dVgrid=out.GHPdet.Data(:,12)/(sqrt(2)*230);
    % Frequency 
    dfpv=out.GHPdet.Data(:,13);
    dfely=out.GHPdet.Data(:,14);
    dfsc=out.GHPdet.Data(:,17);
    dfgrid=out.GHPdet.Data(:,16);
    % Current
    dIpv=out.GHPdet.Data(:,18);
    dIely=out.GHPdet.Data(:,19);
    dIsc=out.GHPdet.Data(:,20);
    dIgrid=out.GHPdet.Data(:,21);
    % add dc voltage and current 
    dIdc=out.GHPdet.Data(:,23);
    dVdc=out.GHPdet.Data(:,22)/780;

    % add stack voltage and current 
    dIstack=out.GHPdet.Data(:,25);
    dVstack=out.GHPdet.Data(:,24);

%% Plotting settings

% window size
 textwidth=489;
 conv_pt2cm=0.0351;
 wd=textwidth*conv_pt2cm;
 h=731*conv_pt2cm/3;

% positioning on the screen
 pw=0;%6*wd;   
 ph=0;%5;   

% fontsize
fs=16;
tStart=1;
tUP=exe.tsim; % upper limit of the time for the xaxis in second

timeTicLabels=[tStart:1:tUP];
timeMinorTickLabels=[tStart:0.5:tUP];


upperBoundActivePower=55;
lowerBoundActivePower=-5;

upperBoundReactivePower=1;
lowerBoundReactivePower=-1;

upperBoundVoltage=1.1;
lowerBoundVoltage=0.9;

upperBoundFrequency=50.1;
lowerBoundFrequency=49.9;





%% Plots
% legend('Grid_{ref}','PV_{ref}','ELY_{ref}','ESS_{ref}','Grid_{mod}','PV_{mod}','ELY_{mod}','ESS_{mod}','Location',leg_location,'NumColumns',2)


switch solar_ref

    case 'step_up'

       leg_location='northwest';

    case 'step_down'
        leg_location='northeast';

    case 'flat'
       leg_location='northwest';

end

% ADD tick values

%
switch modes_exe

    case {'Mode_1'} 
         % Define the figure with specific width and height in points
                fig=figure('Units', 'points', 'Position', [-1100, -50, 489+250, 350+250]);
                
                % Define subplot positions manually as fractions of the figure height
                subplot1_position = [0.1, 0.55, 0.8, 0.35];
                subplot2_position = [0.1, 0.35, 0.8, 0.15]; % Reduced height for the second plot
                subplot3_position = [0.1, 0.1, 0.8, 0.2];     

           % plots with detailed values
                tl=tiledlayout(fig,5,1);
                ax1=nexttile;
                plot(dT,dPgrid,':','LineWidth',1.2)      
                grid on
                hold on
                box on
                plot(dT,dPpv,'-','LineWidth',1.2)
                plot(dT,dPely,'--','LineWidth',1.2)
                plot([NaN NaN],[NaN NaN],'LineWidth',1.2)
                plot([NaN NaN],[NaN NaN],'--','LineWidth',1.2)
          
                ylim([lowerBoundActivePower upperBoundActivePower])
                ylabel('P (kW)','LineWidth',1.2)        
                legend('Grid','PV','ELY','Location','northoutside','Orientation','horizontal')
                hold off
                xlim([tStart tUP])
                ax1.FontSize=fs;
                ax1.XAxis.TickValues=timeTicLabels;
                ax1.XAxis.MinorTick = 'on';
                ax1.XAxis.MinorTickValues=timeMinorTickLabels;
                xticklabels(ax1,{})
                ax2=nexttile;
                plot(dT,dQgrid,':','LineWidth',1.2)      
                grid on
                hold on
                box on
                plot(dT,dQpv,'-','LineWidth',1.2)
                plot(dT,dQely,'--','LineWidth',1.2)
                plot([NaN NaN],[NaN NaN],'LineWidth',1.2)
          
                ylim([lowerBoundReactivePower upperBoundReactivePower])
                ylabel('Q (kVAr)','LineWidth',1.2)     
                hold off
                xlim([tStart tUP])
                ax2.FontSize=fs;
                ax2.XAxis.TickValues=timeTicLabels;
                ax2.XAxis.MinorTick = 'on';
                ax2.XAxis.MinorTickValues=timeMinorTickLabels;
                xticklabels(ax2,{})
                ax3=nexttile;
                plot(dT,dVgrid,':','LineWidth',1.2)      
                grid on
                hold on
                box on
                plot(dT,dVpv,'-','LineWidth',1.2)
                plot(dT,dVely,'--','LineWidth',1.2)
                plot([NaN NaN],[NaN NaN],'LineWidth',1.2)
                ylabel('V (p.u.)','LineWidth',1.2)
                ylim([lowerBoundVoltage upperBoundVoltage])
                xlim([tStart tUP])
                 hold off
                 ax3.XAxis.TickValues=timeTicLabels;
                 ax3.XAxis.MinorTick = 'on';
                 ax3.XAxis.MinorTickValues=timeMinorTickLabels;
                xticklabels(ax3,{})
                ax3.FontSize=fs;    
                ax4=nexttile;
                plot(dT,dfgrid,':','LineWidth',1.2)
                grid on
                hold on
                box on
                plot(dT,dfpv,'-','LineWidth',1.2)
                plot(dT,dfely,'--','LineWidth',1.2)
                ylabel('f (Hz)','LineWidth',1.2)
                ylim([lowerBoundFrequency upperBoundFrequency])
                xlim([tStart tUP])
                hold off
                ax4.XAxis.TickValues=timeTicLabels;
                ax4.XAxis.MinorTick = 'on';
                ax4.XAxis.MinorTickValues=timeMinorTickLabels;
                xticklabels(ax4,{})
                ax4.FontSize=fs;
                ax5=nexttile;
                yyaxis left
                plot(dT,dVstack,'LineWidth',1.2)
                ylabel('V_{stack} (V)','LineWidth',1.2)
                grid on
                hold on
                box on
                yyaxis right
                plot(dT,dIstack,'LineWidth',1.2)
                ylabel('I_{stack} (A)','LineWidth',1.2)       
                      
                hold off
                set(gcf,'Units','centimeters', 'Position',  [pw, ph, wd, 2.5*h])
                ax5.FontSize=fs;
                ax5.XAxis.TickValues=timeTicLabels;
                ax5.XAxis.MinorTick = 'on';
               ax5.XAxis.MinorTickValues=timeMinorTickLabels;
                xlim([tStart tUP])
              

               %
               tl.Padding = 'compact';
               tl.TileSpacing = 'compact';
        
               xlabel(tl,'Time (s)','FontSize',fs)
               if strcmp(safePlots,'on')
                filepath=append(pwd,'\figures\',modes_exe,'_',datestr(now,'yyyymmdd'),'.emf');
                print(fig,'-dmeta','-painters','-r300',filepath)
               end
                
    case {'Mode_2'} 
            % Define the figure with specific width and height in points
                fig=figure('Units', 'points', 'Position', [-1100, -50, 489+250, 350+250]);
                
                % Define subplot positions manually as fractions of the figure height
                subplot1_position = [0.1, 0.55, 0.8, 0.35];
                subplot2_position = [0.1, 0.35, 0.8, 0.15]; % Reduced height for the second plot
                subplot3_position = [0.1, 0.1, 0.8, 0.2];     

           % plots with detailed values
                tl=tiledlayout(fig,5,1);
                ax1=nexttile;
                plot(dT,dPgrid,':','LineWidth',1.2)      
                grid on
                hold on
                box on
                plot(dT,dPpv,'-','LineWidth',1.2)
                plot(dT,dPely,'--','LineWidth',1.2)
                plot([NaN NaN],[NaN NaN],'LineWidth',1.2)
                plot([NaN NaN],[NaN NaN],'--','LineWidth',1.2)
          
                ylim([lowerBoundActivePower upperBoundActivePower])
                ylabel('P (kW)','LineWidth',1.2)        
                legend('Grid','PV','ELY','Location','northoutside','Orientation','horizontal')
                hold off
                xlim([tStart tUP])
                ax1.FontSize=fs;
                ax1.XAxis.TickValues=timeTicLabels;
                ax1.XAxis.MinorTick = 'on';
                ax1.XAxis.MinorTickValues=timeMinorTickLabels;
                xticklabels(ax1,{})
                ax2=nexttile;
                plot(dT,dQgrid,':','LineWidth',1.2)      
                grid on
                hold on
                box on
                plot(dT,dQpv,'-','LineWidth',1.2)
                plot(dT,dQely,'--','LineWidth',1.2)
                plot([NaN NaN],[NaN NaN],'LineWidth',1.2)
          
                ylim([lowerBoundReactivePower upperBoundReactivePower])
                ylabel('Q (kVAr)','LineWidth',1.2)     
                hold off
                xlim([tStart tUP])
                ax2.FontSize=fs;
                ax2.XAxis.TickValues=timeTicLabels;
                ax2.XAxis.MinorTick = 'on';
                ax2.XAxis.MinorTickValues=timeMinorTickLabels;
                xticklabels(ax2,{})
                ax3=nexttile;
                plot(dT,dVgrid,':','LineWidth',1.2)      
                grid on
                hold on
                box on
                plot(dT,dVpv,'-','LineWidth',1.2)
                plot(dT,dVely,'--','LineWidth',1.2)
                plot([NaN NaN],[NaN NaN],'LineWidth',1.2)
                ylabel('V (p.u.)','LineWidth',1.2)
                ylim([lowerBoundVoltage upperBoundVoltage])
                xlim([tStart tUP])
                 hold off
               ax3.XAxis.TickValues=timeTicLabels;
                 ax3.XAxis.MinorTick = 'on';
                 ax3.XAxis.MinorTickValues=timeMinorTickLabels;
                xticklabels(ax3,{})
                ax3.FontSize=fs;    
                ax4=nexttile;
                plot(dT,dfgrid,':','LineWidth',1.2)
                grid on
                hold on
                box on
                plot(dT,dfpv,'-','LineWidth',1.2)
                plot(dT,dfely,'--','LineWidth',1.2)
                ylabel('f (Hz)','LineWidth',1.2)
                ylim([lowerBoundFrequency upperBoundFrequency])
                xlim([tStart tUP])
                hold off
                ax4.XAxis.TickValues=timeTicLabels;
                ax4.XAxis.MinorTick = 'on';
                ax4.XAxis.MinorTickValues=timeMinorTickLabels;
                xticklabels(ax4,{})
                ax4.FontSize=fs;
                ax5=nexttile;
                yyaxis left
                plot(dT,dVstack,'LineWidth',1.2)
                ylabel('V_{stack} (V)','LineWidth',1.2)
                grid on
                hold on
                box on
                yyaxis right
                plot(dT,dIstack,'LineWidth',1.2)
                ylabel('I_{stack} (A)','LineWidth',1.2)       
               
                    
                hold off
                set(gcf,'Units','centimeters', 'Position',  [pw, ph, wd, 2.5*h])
                ax5.FontSize=fs;
                ax5.XAxis.TickValues=timeTicLabels;
                ax5.XAxis.MinorTick = 'on';
               ax5.XAxis.MinorTickValues=timeMinorTickLabels;
                xlim([tStart tUP])
               % xticklabels(ax3,{})

               %
               tl.Padding = 'compact';
               tl.TileSpacing = 'compact';
        
               xlabel(tl,'Time (s)','FontSize',fs)
               if strcmp(safePlots,'on')
                filepath=append(pwd,'\figures\',modes_exe,'_SCR',string(SCRsetting)','_',datestr(now,'yyyymmdd'),'.emf');
                print(fig,'-dmeta','-painters','-r300',filepath)
               end

    case 'Mode_3' 

                % Define the figure with specific width and height in points
                fig=figure('Units', 'points', 'Position', [-1100, -50, 489+250, 350+250]);
                
                % Define subplot positions manually as fractions of the figure height
                subplot1_position = [0.1, 0.55, 0.8, 0.35];
                subplot2_position = [0.1, 0.35, 0.8, 0.15]; % Reduced height for the second plot
                subplot3_position = [0.1, 0.1, 0.8, 0.2];     

           % plots with detailed values
                tl=tiledlayout(fig,5,1);
                ax1=nexttile;
                plot(dT,dPgrid,':','LineWidth',1.2)      
                grid on
                hold on
                box on
                plot(dT,dPpv,'-','LineWidth',1.2)
                plot(dT,dPely,'--','LineWidth',1.2)
                plot(dT,dPsc,'-.','LineWidth',1.2)
                plot([NaN NaN],[NaN NaN],'--','LineWidth',1.2)
          
                ylim([lowerBoundActivePower upperBoundActivePower])
                ylabel('P (kW)','LineWidth',1.2)        
                legend('Grid','PV','ELY','SC','Location','northoutside','Orientation','horizontal')
                hold off
                xlim([tStart tUP])
                ax1.FontSize=fs;
                ax1.XAxis.TickValues=timeTicLabels;
                ax1.XAxis.MinorTick = 'on';
                ax1.XAxis.MinorTickValues=timeMinorTickLabels;
                xticklabels(ax1,{})
                ax2=nexttile;
                plot(dT,dQgrid,':','LineWidth',1.2)      
                grid on
                hold on
                box on
                plot(dT,dQpv,'-','LineWidth',1.2)
                plot(dT,dQely,'--','LineWidth',1.2)
                plot(dT,dQsc,'-.','LineWidth',1.2)
          
                ylim([lowerBoundReactivePower upperBoundReactivePower])
                ylabel('Q (kVAr)','LineWidth',1.2)     
                hold off
                xlim([tStart tUP])
                ax2.FontSize=fs;
                ax2.XAxis.TickValues=timeTicLabels;
                ax2.XAxis.MinorTick = 'on';
                ax2.XAxis.MinorTickValues=timeMinorTickLabels;
                xticklabels(ax2,{})
                ax3=nexttile;
                plot(dT,dVgrid,':','LineWidth',1.2)      
                grid on
                hold on
                box on
                plot(dT,dVpv,'-','LineWidth',1.2)
                plot(dT,dVely,'--','LineWidth',1.2)
                plot(dT,dVsc,'-.','LineWidth',1.2)
                ylabel('V (p.u.)','LineWidth',1.2)
                ylim([lowerBoundVoltage upperBoundVoltage])
                xlim([tStart tUP])
                 hold off
                 ax3.XAxis.TickValues=timeTicLabels;
                 ax3.XAxis.MinorTick = 'on';
                 ax3.XAxis.MinorTickValues=timeMinorTickLabels;
                xticklabels(ax3,{})
                ax3.FontSize=fs;    
                ax4=nexttile;
                plot(dT,dfgrid,':','LineWidth',1.2)
                grid on
                hold on
                box on
                plot(dT,dfpv,'-','LineWidth',1.2)
                plot(dT,dfely,'--','LineWidth',1.2)
                plot(dT,dfsc,'-.','LineWidth',1.2)
                ylabel('f (Hz)','LineWidth',1.2)
                ylim([lowerBoundFrequency upperBoundFrequency])
                xlim([tStart tUP])
                hold off
                ax4.XAxis.TickValues=timeTicLabels;
                ax4.XAxis.MinorTick = 'on';
                ax4.XAxis.MinorTickValues=timeMinorTickLabels;
                xticklabels(ax4,{})
                ax4.FontSize=fs;
                ax5=nexttile;
                yyaxis left
                plot(dT,dVstack,'LineWidth',1.2)
                ylabel('V_{stack} (V)','LineWidth',1.2)
                
                grid on
                hold on
                box on
                yyaxis right
                plot(dT,dIstack,'LineWidth',1.2)
                ylabel('I_{stack} (A)','LineWidth',1.2)       
              
                
                     
                hold off
                set(gcf,'Units','centimeters', 'Position',  [pw, ph, wd, 2.5*h])
                ax5.FontSize=fs;
                ax5.XAxis.TickValues=timeTicLabels;
                ax5.XAxis.MinorTick = 'on';
               ax5.XAxis.MinorTickValues=timeMinorTickLabels;
                xlim([tStart tUP])
              

               %
               tl.Padding = 'compact';
               tl.TileSpacing = 'compact';
        
               xlabel(tl,'Time (s)','FontSize',fs)

             if strcmp(safePlots,'on')
                filepath=append(pwd,'\figures\',modes_exe,'_SCR',string(SCRsetting)','_',datestr(now,'yyyymmdd'),'.emf');
                print(fig,'-dmeta','-painters','-r300',filepath)
               end
           


    case 'Mode_4'
                % Define the figure with specific width and height in points
                fig=figure('Units', 'points', 'Position', [-1100, -50, 489+250, 350+250]);
                
                % Define subplot positions manually as fractions of the figure height
                subplot1_position = [0.1, 0.55, 0.8, 0.35];
                subplot2_position = [0.1, 0.35, 0.8, 0.15]; % Reduced height for the second plot
                subplot3_position = [0.1, 0.1, 0.8, 0.2];     

           % plots with detailed values
                tl=tiledlayout(fig,5,1);
                ax1=nexttile;
                plot(dT,dPgrid,':','LineWidth',1.2)      
                grid on
                hold on
                box on
                plot(dT,dPpv,'-','LineWidth',1.2)
                plot(dT,dPely,'--','LineWidth',1.2)
                plot(dT,dPsc,'-.','LineWidth',1.2)
                plot([NaN NaN],[NaN NaN],'--','LineWidth',1.2)
                ylim([lowerBoundActivePower upperBoundActivePower])
                ylabel('P (kW)','LineWidth',1.2)        
                legend('PV','ELY','SC','Location','northoutside','Orientation','horizontal')
                hold off
                xlim([tStart tUP])
                ax1.FontSize=fs;
                ax1.XAxis.TickValues=timeTicLabels;
                ax1.XAxis.MinorTick = 'on';
                ax1.XAxis.MinorTickValues=timeMinorTickLabels;
                xticklabels(ax1,{})
                ax2=nexttile;
                plot(dT,dQgrid,':','LineWidth',1.2)      
                grid on
                hold on
                box on
                plot(dT,dQpv,'-','LineWidth',1.2)
                plot(dT,dQely,'--','LineWidth',1.2)
                plot(dT,dQsc,'-.','LineWidth',1.2)          
                ylim([lowerBoundReactivePower upperBoundReactivePower])
                ylabel('Q (kVAr)','LineWidth',1.2)     
                hold off
                xlim([tStart tUP])
                ax2.FontSize=fs;
                ax2.XAxis.TickValues=timeTicLabels;
                ax2.XAxis.MinorTick = 'on';
                ax2.XAxis.MinorTickValues=timeMinorTickLabels;
                xticklabels(ax2,{})
                ax3=nexttile;
                plot(dT,dVgrid,':','LineWidth',1.2)      
                grid on
                hold on
                box on
                plot(dT,dVpv,'-','LineWidth',1.2)
                plot(dT,dVely,'--','LineWidth',1.2)
                plot(dT,dVsc,'-.','LineWidth',1.2)
                ylabel('V (p.u.)','LineWidth',1.2)
                ylim([lowerBoundVoltage upperBoundVoltage])
                xlim([tStart tUP])
                 hold off
                    ax3.XAxis.TickValues=timeTicLabels;
                 ax3.XAxis.MinorTick = 'on';
                 ax3.XAxis.MinorTickValues=timeMinorTickLabels;
                xticklabels(ax3,{})
                ax3.FontSize=fs;    
                ax4=nexttile;
                plot(dT,dfgrid,':','LineWidth',1.2)
                grid on
                hold on
                box on
                plot(dT,dfpv,'-','LineWidth',1.2)
                plot(dT,dfely,'--','LineWidth',1.2)
                plot(dT,dfsc,'-.','LineWidth',1.2)
                ylabel('f (Hz)','LineWidth',1.2)
                ylim([lowerBoundFrequency upperBoundFrequency])
                xlim([tStart tUP])
                hold off
                ax4.XAxis.TickValues=timeTicLabels;
                ax4.XAxis.MinorTick = 'on';
                ax4.XAxis.MinorTickValues=timeMinorTickLabels;
                xticklabels(ax4,{})
                ax4.FontSize=fs;
                ax5=nexttile;
                yyaxis left
                plot(dT,dVstack,'LineWidth',1.2)
                ylabel('V_{stack} (V)','LineWidth',1.2)
              
                grid on
                hold on
                box on
                yyaxis right
                plot(dT,dIstack,'LineWidth',1.2)
                ylabel('I_{stack} (A)','LineWidth',1.2)       
                %ylim([0 400])
                
               % ylim([-20 200])        
                hold off
                set(gcf,'Units','centimeters', 'Position',  [pw, ph, wd, 2.5*h])
                ax5.FontSize=fs;
                ax5.XAxis.TickValues=timeTicLabels;
                ax5.XAxis.MinorTick = 'on';
               ax5.XAxis.MinorTickValues=timeMinorTickLabels;
                xlim([tStart tUP])
               % xticklabels(ax3,{})

               %
               tl.Padding = 'compact';
               tl.TileSpacing = 'compact';
        
               xlabel(tl,'Time (s)','FontSize',fs)

               if strcmp(safePlots,'on')
                filepath=append(pwd,'\figures\',modes_exe,'_',datestr(now,'yyyymmdd'),'.emf');
                print(fig,'-dmeta','-painters','-r300',filepath)
               end 
    
   
end




