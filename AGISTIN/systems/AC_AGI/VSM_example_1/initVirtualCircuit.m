function VC = initVirtualCircuit(R1,L1,R1t,L1t,tauR,tauL)
% Initializes struct for virtual circuit.
% R1  and L1  are the resistance and reactance of the virtual circuit
% R1t and L1t are the delayed resistance and reactance of the virtual
% circuit. They kick in with the PT1 delay times specified by tauR and tauL.
if nargin < 1;
    R1 = 0;
end
if nargin < 2;
    L1 = 0;
end
if nargin < 3;
    R1t = 0;
end
if nargin < 4;
    L1t = 0;
end
if nargin < 5;
    tauR = 0.01;
end
if nargin < 6;
    tauL = 0.01;
end

% Virtual Circuit
VC.R1 = R1;      %  U_d =  R1 * I_d; U_q = R1 * I_q
VC.L1 = L1;      %  U_d = -L1 * I_q; U_q = L1 * I_d

% Virtual Circuit
VC.R1t = R1t;    %  U_d =  R1t * PT1(I_d); U_q = R1t * PT1(I_q)
VC.L1t = L1t;    %  U_d = -L1t * PT1(I_q); U_q = L1t * PT1(I_d)
VC.tauR = tauR;
VC.tauL = tauL;
VC.tauSlow = 1e6;