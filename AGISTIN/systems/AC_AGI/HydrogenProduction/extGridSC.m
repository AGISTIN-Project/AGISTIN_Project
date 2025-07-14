function [extGrid] = extGridSC(VSMCTRL, XR, SCR, U_sc)
% calculates R & L of external grid and fault impedance

extGrid = initGrid(VSMCTRL.PU, SCR, XR);

T = (1/U_sc)^2 - 1;

R1 = extGrid.SI.R/T + sqrt((extGrid.SI.R/T)^2 + extGrid.SI.R^2*(1 + XR^2)/T);

%R2 = extGrid.SI.R/T - sqrt((extGrid.SI.R/T)^2 + extGrid.SI.R^2*(1 + XR^2)/T)

extGrid.R_f = R1;

end

