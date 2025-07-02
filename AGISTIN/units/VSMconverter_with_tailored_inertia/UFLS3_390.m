%% Zuteilung der Lasten und Last_VSMs auf 10 möglichst gleichgroße UFLS-Stufen
% Da bei der aktuellen Version nur 2 Last VSMs zu Einsatz kommen werden
% diese dem Array der Lasten an den Stellen an den sonst Nullen (0) sind
% hinzugefügt

const = prm_load(5,1:2);
const(1,3) = {(abs(prm_vsm{1,2})-min(prm_vsm{5,4},abs(prm_vsm{1,2})*prm_vsm{57,2}*0.6/50+prm_vsm{49,2}*1/General.fn))*(pu_vsm(2).Sb/(pu_vsm(1).Sb))}; %variable verwenden - pu system beachten
const(1,4) = {(abs(prm_vsm{1,4})-min(prm_vsm{5,4},abs(prm_vsm{1,4})*prm_vsm{57,4}*0.6/50+prm_vsm{49,4}*1/General.fn))*(pu_vsm(4).Sb/(pu_vsm(1).Sb))}; %variable verwenden - pu system beachten
for k = 2:length(const)
    values(k-1,1) = const{k};
    values(k-1,2) = k;
end

UFLS_p = values(:, 1);
num_bus = values(:, 2);

%Werte werden nach den geschalteden Leistungen von groß nach klein sortiert
[~, order] = sort(UFLS_p, 'descend');
bus_sorted = values(order, :);

UFLS_steps_ges = 3;                                                         %Hälfte der UFLS-Stufen
UFLS_sort = cell(1, UFLS_steps_ges);                                        %Erstellen des Arrays, dass später die "Bussnummer" (7 = VSM3 und 8 = VSM4) aufgeteilt nach Stufen enthält
UFLS_loadsteps = zeros(1, UFLS_steps_ges);                                  %Erstellen des Arrays, dass später die Leistungen Anzeigt die bei einer Stufe geschaltet werden

for k = 1:length(bus_sorted)                                                %Iteration beginnt mit dem größten Wert aus 
    [~, minUFLS_step_Index] = min(UFLS_loadsteps);                          %finden des Index des kleinsten Wertes in "UFLS_loadsteps" sind zwei Werte identisch wird mit dem kleinsten angefangen
    UFLS_sort{minUFLS_step_Index} = [UFLS_sort{minUFLS_step_Index}; bus_sorted(k, 2)]; %weißt die "Bussnummer" (7 = VSM3 und 8 = VSM4) der UFLS-Stufe zu
    UFLS_loadsteps(minUFLS_step_Index) = UFLS_loadsteps(minUFLS_step_Index) + bus_sorted(k, 1); %addiert die Leistung zu der UFLS-Stufe mit der geringsten Leistung
end

UFLS.area1 = [49, 48.85 48.7];                                     %[Hz]
UFLS.area2 = [48.55, 48.4 48.25];                                   %[Hz]


for k = 1:length(UFLS_sort)
    for j = 1:length(UFLS_sort{k})
        UFLS_freq = UFLS.area1(k);
        UFLS.Load(1,UFLS_sort{k}(j)) = {UFLS_freq};
    end
end

for k = 1:length(UFLS_sort)
    for j = 1:length(UFLS_sort{k})
        UFLS_freq = UFLS.area2(k);
        UFLS.Load(2,UFLS_sort{k}(j)) = {UFLS_freq};
    end
end
%UFLS.Load(2,:) = UFLS.Load(1,:);
UFLS.Load(1,1) = {'freq_UFLS_1'};
UFLS.Load(2,1) = {'freq_UFLS_2'};
UFLS.VSM(1,:) = {'freq_UFLS_1' UFLS.Load{1,3} 0 UFLS.Load{1,4} 0 0};
UFLS.VSM(2,:) = {'freq_UFLS_2' UFLS.Load{2,3} 0 UFLS.Load{2,4} 0 0};
UFLS.Load(1,3) = {0};
UFLS.Load(1,4) = {0}; 
UFLS.Load(2,3) = {0};
UFLS.Load(2,4) = {0};

clear j k minUFLS_step_Index pu_con_factor UFLS_steps_ges UFLS_freq