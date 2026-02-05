function [GridL, R] = initGrid(PU,SCR,XtoR)
% Grid   = initGrid(...): Struct mit .PU.(R/L) und .SI.(R/L)
% [l, r] = initGrid(...): l, r in pu
%% Labor
if ischar(SCR)
    if strcmpi(SCR,'labor')
        Grid.SI.L = 0.25e-3; % [H]
        Grid.SI.R = 0.015;   % [Ohm] Eigentich 0.05. dann aber XzuR = 1.5, so XzuR = 5
        Grid.PU.L = Grid.SI.L / PU.Lb;
        Grid.PU.R = Grid.SI.R / PU.Zb;
    else
        warning('Wrong Argument for SCR')
    end
else
    Grid.PU.L = 1/SCR;
    Grid.PU.R = Grid.PU.L / XtoR;
    Grid.SI.L = Grid.PU.L * PU.Lb;
    Grid.SI.R = Grid.PU.R * PU.Zb;
end

Grid.Ulow = 1;

if nargout == 1
    GridL = Grid;
elseif nargout == 2
    GridL = Grid.PU.L;
    R     = Grid.PU.R;
end
