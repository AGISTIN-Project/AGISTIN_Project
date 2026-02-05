%calculations for alkaline electrolyzer stack design 
clear
close all

%% 

P_nom_target = 1.5e6; %nominal power in W
steps = 25; %
A_cell_min = 3000; %Minimum active cell area in cm^2
A_cell_max = 20000; %Maximum active cell area in cm^2
A_cell = linspace(A_cell_min,A_cell_max,steps); %Active cell area in cm^2

N_cell_min = 100;
N_cell_max = 650;
N_cell = linspace(N_cell_min,N_cell_max,steps); %number of cells 

%Lurgi electrolyzer
N_cell_Lurgi = 278; %number of cells 
i_nom = 0.165; %nominal current desnity in A/cm^2
E_e = 1.26; %in V
i_0 = 1.2e-4; %in A/cm^2
c = 0.12; %in V/dec
a = 0.04; %in V/dec
R_cell = 0.89; %in Ohm*cm^2
A_cell_Lurgi = 20000; %Active cell area in cm^2

%eq (1) from Sanchez-Ruiz et al. 
E_cell_DC_nom = E_e + (a+c)*log10(i_nom/i_0) + i_nom*R_cell;

I_nom = i_nom.*A_cell; %nominal current in A
V_nom = N_cell.*E_cell_DC_nom;
P_nom = I_nom'.*V_nom;

P_nom_Lurgi = N_cell_Lurgi*E_cell_DC_nom*i_nom*A_cell_Lurgi;

clf
figure(1)
mesh(I_nom,V_nom,P_nom.*1e-6)
xlabel('Current in A')
ylabel('Voltage in V')
zlabel('Power in MW')

matlab2tikz('mesh_plot_PIV.tex');

[I_nom_index,V_nom_index] = find(P_nom>=P_nom_target-0.001e6 & P_nom<=P_nom_target+0.001e6);

I_nom_1500kW = I_nom(I_nom_index);
V_nom_1500kW = V_nom(V_nom_index);
N_cell_1500kW = N_cell(V_nom_index);

%set cell size to get other parameters
A_cell_design = 10000; %in cm^2 
I_nom_1500kW_design_index = min(find((I_nom_1500kW./i_nom)<=A_cell_design));
I_nom_design = I_nom_1500kW(I_nom_1500kW_design_index);
V_nom_design = V_nom_1500kW(I_nom_1500kW_design_index);
N_cell_design = ceil(N_cell_1500kW(I_nom_1500kW_design_index));

%plot for 1.5 MW nominal power
figure(2)
yyaxis left; % Activate left y-axis
plot(I_nom_1500kW./i_nom.*1e-4,V_nom_1500kW)
ylabel('voltage in V')
hold on
%plot([min(I_nom_1500kW)./i_nom.*1e-4 max(I_nom_1500kW)./i_nom.*1e-4],[700 700],'k--')
%plot([min(I_nom_1500kW)./i_nom.*1e-4 max(I_nom_1500kW)./i_nom.*1e-4],[1200 1200],'k--')
plot([A_cell_design*1e-4 A_cell_design*1e-4],[400 1300],'k--')
plot(A_cell_design*1e-4,V_nom_design,'b-+')

grid on
yyaxis right; % Activate left y-axis
plot(I_nom_1500kW./i_nom.*1e-4,N_cell(V_nom_index))
ylabel('Number of cells')
xlabel('Cell surface in m^2')
axis([min(I_nom_1500kW)./i_nom.*1e-4 max(I_nom_1500kW)./i_nom.*1e-4 -inf inf])
hold on
plot(A_cell_design*1e-4,N_cell_design,'r-+')

%matlab2tikz('PIV_1500kW.tex');

% A_cell_calc = I_nom_1500kW./i_nom;
% 
% number_xaxis_2_lines = 11;
% % Adding a second x-axis with a different scale
% ax = gca; % Get current axes
% ax2 = axes('Position', ax.Position, 'Color', 'none', 'XAxisLocation', 'top', 'YAxisLocation', 'right');
% ax2.XColor = 'k'; % Color of the second x-axis
% ax2.YColor = 'none'; % Hide the second y-axis
% ax2.XLim = [min(A_cell_calc) max(A_cell_calc)]; % Set limits for the second x-axis
% ax2.XTick = round(linspace(min(A_cell_calc) ,max(A_cell_calc), number_xaxis_2_lines),2); % Set ticks for the second x-axis
% ax2.XTickLabel = round(linspace(min(A_cell_calc) ,max(A_cell_calc), number_xaxis_2_lines),2); % Custom labels corresponding to the first x-axis
% xlabel(ax2, 'Cell size in cm^2'); % Label for the second x-axis

