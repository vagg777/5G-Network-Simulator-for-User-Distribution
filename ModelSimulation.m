function ModelSimulation()

    clc;
    close all;
    format short g;
    
    % 1. Initialise simulation variables
    [devices,macro_cells,small_cells,rb_bandwidth,macro_cell_radiation,small_cell_radiation,ue_radiation,subcarrier_spacing,white_noise,carrier_frequency,dl_bandwidth,ul_bandwidth,devices_macro_dist,devices_small_dist,path_loss_macro_cells,path_loss_small_cells,channel_gain_macro_cells,channel_gain_small_cells,sinr_macro_cells,sinr_small_cells,device_dl_throughput_demands,device_ul_throughput_demands,downlink_subcarriers,uplink_subcarriers,dl_resource_blocks,ul_resource_blocks,device_dl_rb_demands,device_ul_rb_demands,devices_dl_rb_demands_eNB_index,devices_ul_rb_demands_eNB_index,dl_data_rates,ul_data_rates,available_dl_RBs_macro_cells,available_dl_RBs_small_cells,available_ul_RBs_macro_cells,available_ul_RBs_small_cells] = initVariables();
    
    % 2. Populate grid by adding devices, small cells and macro cells
    [macro_cells_x_pos,macro_cells_y_pos,small_cells_x_pos,small_cells_y_pos,devices_x_pos,devices_y_pos] = populateGrid(devices);

    % 3. Calculate Downlink device throughput demands in kbps
    [device_dl_throughput_demands] = calculateDownlinkThroughputDemands(devices);
    
    % 3. Calculate Uplink device throughput demands in kbps
    [device_ul_throughput_demands] = calculateUplinkThroughputDemands(devices);
    
    % 4. Calculate Downlink SINR for every possible downlink connection and find the optimal for each device
    [sinr_dl_macro_cells,sinr_dl_small_cells,devices_small_dist,devices_macro_dist] = calculateDownlinkSINR(devices,white_noise,small_cells_x_pos,small_cells_y_pos,subcarrier_spacing,devices_x_pos,devices_y_pos,macro_cell_radiation,small_cell_radiation,macro_cells_x_pos,macro_cells_y_pos,devices_macro_dist,path_loss_macro_cells,channel_gain_macro_cells,sinr_macro_cells,devices_small_dist,path_loss_small_cells,channel_gain_small_cells,sinr_small_cells,device_dl_throughput_demands,device_ul_rb_demands,macro_cells,small_cells,downlink_subcarriers);
    
    % 4. Calculate Uplink SINR for every possible downlink connection and find the optimal for each device
    [sinr_ul_macro_cells,sinr_ul_small_cells,devices_small_dist,devices_macro_dist] = calculateUplinkSINR(devices,white_noise,small_cells_x_pos,small_cells_y_pos,subcarrier_spacing,devices_x_pos,devices_y_pos,ue_radiation,macro_cells_x_pos,macro_cells_y_pos,devices_macro_dist,path_loss_macro_cells,channel_gain_macro_cells,sinr_macro_cells,devices_small_dist,path_loss_small_cells,channel_gain_small_cells,sinr_small_cells,device_ul_throughput_demands,device_ul_rb_demands,macro_cells,small_cells,uplink_subcarriers);

    % 5. Run the UE-eNB Association algorithm
    [dl_data_rates,ul_data_rates] = associationAlgorithm(devices,device_dl_rb_demands,device_ul_rb_demands,device_dl_throughput_demands,device_ul_throughput_demands,rb_bandwidth,sinr_dl_macro_cells,sinr_dl_small_cells,sinr_ul_macro_cells,sinr_ul_small_cells,dl_resource_blocks,ul_resource_blocks,devices_dl_rb_demands_eNB_index,devices_ul_rb_demands_eNB_index,downlink_subcarriers,uplink_subcarriers,dl_data_rates,ul_data_rates,available_dl_RBs_macro_cells,available_dl_RBs_small_cells,available_ul_RBs_macro_cells,available_ul_RBs_small_cells,macro_cells,small_cells);
    
    % 6. Present key metrics from the simulations
    fprintf("\n------------ Device Data Rate Results ------------\n\n");
    fprintf("[DOWNLINK] Average data rate : %.2f (Mbps)\n",mean2(dl_data_rates(dl_data_rates>0)));
    fprintf("[UPLINK] Average data rate : %.2f (Mbps)\n",mean2(ul_data_rates(ul_data_rates>0)));
    fprintf("\n------------ Network Results ------------\n\n");
    fprintf("[DOWNLINK] Network Throughput : %.2f (Mbps)\n",sum(dl_data_rates));
    fprintf("[UPLINK] Network Throughput : %.2f (Mbps)\n",sum(ul_data_rates));
    fprintf("\n------------ SINR Results ------------\n\n");
    fprintf("[DOWNLINK] Average macro cell SINR : %.2f\n",10*log10(mean2(sinr_dl_macro_cells)));
    fprintf("[DOWNLINK] Average small cell SINR : %.2f\n",10*log10(mean2(sinr_dl_small_cells)));
    fprintf("[UPLINK] Average macro cell SINR : %.2f\n",10*log10(mean2(sinr_ul_macro_cells)));
    fprintf("[UPLINK] Average small cell SINR : %.2f\n",10*log10(mean2(sinr_ul_small_cells)));
    
    
end