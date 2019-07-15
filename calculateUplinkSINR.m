function [sinr_macro_cells,sinr_small_cells,devices_small_dist,devices_macro_dist] = calculateUplinkSINR(devices,white_noise,small_cells_x_pos,small_cells_y_pos,subcarrier_spacing,devices_x_pos,devices_y_pos,ue_radiation,macro_cells_x_pos,macro_cells_y_pos,devices_macro_dist,path_loss_macro_cells,channel_gain_macro_cells,sinr_macro_cells,devices_small_dist,path_loss_small_cells,channel_gain_small_cells,sinr_small_cells,device_throughput_demands,device_rb_demands,macro_cells,small_cells,uplink_subcarriers)
    
    for j = 1:devices   
        % loop through all macro cells 
        for i = 1:macro_cells    
            x_dist_macro = abs(devices_x_pos(j) - macro_cells_x_pos(i));
            y_dist_macro = abs(devices_y_pos(j) - macro_cells_y_pos(i));
            devices_macro_dist(j,i) = sqrt(double(x_dist_macro^2 + y_dist_macro^2));         % calculate distance from macro cell (in meters)
            path_loss_macro_cells(j,i) = 128.1 + 37.6*log10(devices_macro_dist(j,i)/1000);   % calculate path loss from macro cell (in kilometers)
            channel_gain_macro_cells(j,i) = 10^(-path_loss_macro_cells(j,i)/10);             % calculate channel gain from macro cell
        end
        for i = 1:small_cells  
             x_dist_small = abs(devices_x_pos(j) - small_cells_x_pos(i));
             y_dist_small = abs(devices_y_pos(j) - small_cells_y_pos(i));
             devices_small_dist(j,i) = sqrt(double(x_dist_small^2 + y_dist_small^2));         % calculate distance from small cell (in meters)
             path_loss_small_cells(j,i) = 140.7 + 36.7*log10(devices_small_dist(j,i)/1000);   % calculate path loss from small cell (in kilometers)
             channel_gain_small_cells(j,i) = 10^(-path_loss_small_cells(j,i)/10);             % calculate channel gain from small cell
        end
    end
    
    for j = 1:devices
        % loop through all macro cells 
        for i=1:macro_cells
            sinr_numerator = ue_radiation*channel_gain_macro_cells(j,i);
            all_other_macro_channel_gains_and_powers = 0;
            for temp = 1:macro_cells
                if temp ~= i 
                    all_other_macro_channel_gains_and_powers = all_other_macro_channel_gains_and_powers + ue_radiation*channel_gain_macro_cells(j,temp);
                end
            end
            for temp = 1:small_cells
                    all_other_macro_channel_gains_and_powers = all_other_macro_channel_gains_and_powers + ue_radiation*channel_gain_small_cells(j,temp);
            end
            sinr_denominator = white_noise*subcarrier_spacing + all_other_macro_channel_gains_and_powers;
            sinr_macro_cells(j,i) = 12 * (sinr_numerator/sinr_denominator);                   
        end
        for i=1:small_cells
             sinr_numerator = ue_radiation*channel_gain_small_cells(j,i);
             all_other_small_channel_gains_and_powers = 0;
             for temp = 1:small_cells
                 if temp ~= i 
                     all_other_small_channel_gains_and_powers = all_other_small_channel_gains_and_powers + ue_radiation*channel_gain_small_cells(j,temp);
                 end
             end
             for temp = 1:macro_cells
                    all_other_small_channel_gains_and_powers = all_other_small_channel_gains_and_powers + ue_radiation*channel_gain_macro_cells(j,temp);
             end
             sinr_denominator = white_noise*subcarrier_spacing + all_other_small_channel_gains_and_powers;
             sinr_small_cells(j,i) = 12 * (sinr_numerator/sinr_denominator);
        end
    end
    
end
