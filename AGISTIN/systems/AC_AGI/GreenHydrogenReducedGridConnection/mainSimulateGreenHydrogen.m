%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AGISTIN WP5 - Green hydrogen production
%
% Operation of a Alkaline Electrolyzer in a Weak Grid with a Grid-forming 
%        Energy Storage Systems
%
% Author of the script and the models: Christoph Kaufmann, Aline Luxa both from Fraunhofer IWES  
% Date:30.01.2026
% 
% Summary: This model shows the operation of a alkaline electrolyzer
% powered by a photovoltaic plant under different weak grid scenarios as
% well as with and without a grid-forming converter to assess its impact. 
%
% This work closely related to the publication 
%     Christoph Kaufmann, Saran Ganesh, Aline Luxa, Georg Pangalos, 
%     «Grid Integration Study of a 50 kW Alkaline Electrolyser into a Weak Grid
%      with a Grid-forming Energy Storage System" 24th Wind & Solar Integration Workshop
%     (WIW 2025), Berlin, Germany 2025.
%  
% This work is part of the Horizon Europe Project AGISTIN, visit https://agistin.eu/
% for further information
%
% The grid-forming model "L-Filter GFM" for the supercapacitor is based on
%       L-Filter GFM, © 2020 Frédéric Colas  
%
%       Licensed under the MIT License.  
%       Original project: https://github.com/l2ep-epmlab/VSC_Lib/tree/master
%
%       The MIT license for this third-party component is provided in  
%       [`THIRD_PARTY_LICENSE_MIT`](./THIRD_PARTY_LICENSE_MIT.txt). 
% 
% For further information see for example:
%   C. Cardozo et al., "Promises and challenges of grid forming: Transmission 
%   system operator, manufacturer and academic view points," Electric Power
%   Systems Research, Volume 235, 2024, doi: 10.1016/j.epsr.2024.110855
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; clc;
addpath(genpath(pwd))

%% Setting up simulation scenario

% Modes of operation 
% Mode_1: PV plant and electrolyzer are connected to the strong grid
% Mode_2: PV plant and electrolyzer are connected through the short-circuit
%         limiting reactor (SCLR) to the grid, where the SCLR has different
%         settings to reduce short circuit ratio (SCR)
% Mode_3: A grid-forming converter is conected in parallel to the PV plant
%         and electrolyzer, which are connect to the grid through the SCLR
% Mode_4: The green hydrrogen plant operates in island-mode

 modes_exe='Mode_3'; % change here for different modes

% Setting short circuit ratio
SCRsetting=0.5; % change here for different SCR
% You can choose between {5, 2, 1.5, 1, 0.5} 

   
%% Load data for model parametrization
run parametrization;

%% Run simulation
out=sim("modelGreenHydrogenPlant.slx");
% Note that in Mode_4 the GFM converter should have no inertia and the user
% needs to change the setting in the model

%% Plotting
safePlots='no'; % choose between 'on', or 'off'
run plotting;