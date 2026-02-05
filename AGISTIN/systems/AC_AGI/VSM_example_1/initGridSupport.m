function [DFDT, IPF, IQU] = initGridSupport()
<<<<<<< .mine
DFDT.tauRI=0.5; % Time Constant df/dt
DFDT.TAUHF = 0.001;
DFDT.Tai=10;  % Acceleration Time Constant df/dt 
IPF.k = 20; % Droop of Active-Current / Frequency 
IPF.T = 1; % Time Constant Frequency
IPF.didmax = Inf;
IQU.k = -5; % Droop of Reactive-Current / Voltage
IQU.T = 0.1; % Time Constant Voltage
IPF.didmax
end
||||||| .r558
DFDT.tauRI=1; % Time Constant df/dt
DFDT.Tai=10;  % Acceleration Time Constant df/dt 
IPF.k = 10; % Droop of Active-Current / Frequency 
IPF.T = 1; % Time Constant Frequency
IQU.k = -5; % Droop of Reactive-Current / Voltage
IQU.T = 1; % Time Constant Voltage
end
=======
DFDT.tauRI = 0.11;  % Time Constant df/dt
DFDT.Tai   = 10;    % Acceleration Time Constant df/dt 
IPF.k      = 20;    % Droop of Active-Current / Frequency 
IPF.T      = 0.6;   % Time Constant Frequency
IQU.k      = -5;    % Droop of Reactive-Current / Voltage
IQU.T      = 10e-3; % Time Constant Voltage
>>>>>>> .r595
