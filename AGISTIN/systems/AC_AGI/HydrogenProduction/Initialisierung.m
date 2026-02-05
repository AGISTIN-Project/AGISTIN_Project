%% Howt To Initialisierung

% Initialisierung kann funktionieren ABER mit Schwierigkeiten

%% neues Simscape

% Load Flow mit load flow Bus und load Flow Analyzer durchlaufen lassen
% Winkel und Amplituden der Spannungen sind exportierbar
% Anfangsströme sind ablesbar, ABER nicht einfach exportierbar!!! ->
% müssten einzeln gemessen werden und dann übertragen werden

% Initial states mittels operating point
% https://de.mathworks.com/help/releases/R2020b/physmod/simscape/ref/simscape.op.operatingpoint.simscape.op.create.html?s_tid=doc_ta#responsive_offcanvas

% Gesamtmodell
op2 = simscape.op.create(gcs, 'Start')

% Auswahl
op2 = simscape.op.create(gcb, 'Start')

% Abändern mit set (URL)

% simscape -> enable operating point init -> op point from workspace

% spezifisch auslesen
i = get(opRI,'RL_grid/IL')
i.Value

% Anscheinend können auch nicht benutzte Blöcke im op ohne Probleme
% übergeben werden


% Load Flow
% mittels App und abspeichern in mat ODER:
% simlog ab anfang an
flow = get(simlog,'Load Flow Source')
flow_v = get(flow,'V')
b = flow_v.phase;
% ab hier series object
c = b.series
% Werte aus series (ohne Zeit)
d = values(c)


% finaler Model operating point lässt sich als inital state nehmen


%% altes Simscape (geht nicht mit simscape)

% steady inital state computation
sps = power_initstates(bdroot)

%get states
states = Simulink.BlockDiagram.getInitialState(bdroot)

% load flow
LF = power_loadflow('-v2',sys,'solve','report',fname) computes the load flow and then saves detailed information in fname file.

