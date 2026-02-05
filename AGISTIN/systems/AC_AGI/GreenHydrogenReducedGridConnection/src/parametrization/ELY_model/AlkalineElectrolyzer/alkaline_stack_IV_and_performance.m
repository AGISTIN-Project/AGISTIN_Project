%calculation of dynamic model parametes

run("alkaline_stack_design.m")

i = 1e-3:0.001:i_nom;

%static: (no C)
%eq (3) from Sanchez-Ruiz et al. 
Rct_a = a.*log10(i./i_0)./(A_cell_design.*i); %is this right???
%eq (4) from Sanchez-Ruiz et al. 
Rct_c = c.*log10(i./i_0)./(A_cell_design.*i); %is this right???
%Rct_c = c./(i.*log(10)); %is this right???

%cell voltage
%eq 1
E_cell_DC_nom_1 = E_e + (a+c)*log10(i./i_0) + i.*R_cell;
% with eq 3,4
E_cell_DC_nom_34 = E_e + (Rct_a+Rct_c).*A_cell_design.*i + i.*R_cell;

figure(3)
plot(i,E_cell_DC_nom_1,LineWidth=1.5)
hold on
%plot(i,E_cell_DC_nom_34,'--')
grid on
ylabel('Cell voltage in V',FontSize=14)
xlabel('Current density in A/cm^2',FontSize=14)
% Change font size of the axes
ax = gca; % Get current axes
set(ax, 'FontSize', 14); % Set font size to 14

matlab2tikz('IV_curve.tex');

Ra = a.*log10(i./i_0)./(A_cell_design.*i);

Ra_tot = Ra*N_cell_design;

%run dynamic simulink model
out = sim('generic_AEL.slx');

figure(4)
yyaxis left; % Activate left y-axis
plot(out.I_ely.Time,out.I_ely.Data(:),LineWidth=1.5)
ylabel('Input current in A')
grid on
yyaxis right; 
plot(out.V_ely.Time,out.V_ely.Data(:),LineWidth=1.5)
ylabel('Output voltage in V')
grid on
xlabel('Time in s')
ax = gca; % Get current axes
set(ax, 'FontSize', 14); % Set font size to 14


