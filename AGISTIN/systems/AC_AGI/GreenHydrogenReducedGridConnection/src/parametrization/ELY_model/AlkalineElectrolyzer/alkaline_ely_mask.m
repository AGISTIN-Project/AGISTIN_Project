classdef alkaline_ely_mask

    methods(Static)

        % Use the code browser on the left to add the callbacks.

        function PIV_calc(~,~)
            A_cell = str2double(get_param(gcb, 'A_cell')); %gbc = Get Current Block.
            N_cell = str2double(get_param(gcb, 'N_cell')); 
            P_min_share = str2double(get_param(gcb, 'P_min_share')); 
            P_max_share = str2double(get_param(gcb, 'P_max_share')); 
            i_nom = str2double(get_param(gcb, 'i_nom')); 
            V_rev = str2double(get_param(gcb, 'V_rev')); 
            i0 = str2double(get_param(gcb, 'i0')); 
            c = str2double(get_param(gcb, 'c')); 
            a = str2double(get_param(gcb, 'a')); 
            R_cell_ohm = str2double(get_param(gcb, 'R_cell_ohm')); 

            %eq (1) from Sanchez-Ruiz et al. 
            E_cell_DC_nom = V_rev + (a+c)*log10(i_nom/i0) + i_nom*R_cell_ohm;
            I_nom = i_nom*A_cell; %nominal current in A
            V_nom = N_cell*E_cell_DC_nom;
            P_nom = I_nom*V_nom;

            P_min = P_min_share/100*P_nom;
            P_max = P_max_share/100*P_nom;

            % Display the result in the static text field
            set_param(gcb, 'ResultPIV', sprintf(['Nominal power in kW: %.2f\n', ...
                                        'Operating power range in kW: %.2f - %.2f\n\n', ...
                                        'Nominal voltage in V: %.2f\n', ...
                                        'Nominal current in A: %.2f'], ...
                                        P_nom * 1e-3, P_min * 1e-3, P_max * 1e-3, V_nom, I_nom)); % Update the static text field
        end
        
       
    end
end