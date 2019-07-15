function [devices,macro_cells,small_cells,rb_bandwidth,macro_cell_radiation,small_cell_radiation,ue_radiation,subcarrier_spacing,white_noise,carrier_frequency,dl_bandwidth,ul_bandwidth,devices_macro_dist,devices_small_dist,path_loss_macro_cells,path_loss_small_cells,channel_gain_macro_cells,channel_gain_small_cells,sinr_macro_cells,sinr_small_cells,device_dl_throughput_demands,device_ul_throughput_demands,downlink_subcarriers,uplink_subcarriers,dl_resource_blocks,ul_resource_blocks,device_dl_rb_demands,device_ul_rb_demands,devices_dl_rb_demands_eNB_index,devices_ul_rb_demands_eNB_index,dl_data_rates,ul_data_rates,available_dl_RBs_macro_cells,available_dl_RBs_small_cells,available_ul_RBs_macro_cells,available_ul_RBs_small_cells] = initVariables()
    devices = 50;                                               % Devices in network = 50 (default)
    macro_cells = 19;                                           % Macro cells = 19 (default)
    small_cells = 21;                                           % Small cells = 21 (default)
    dl_resource_blocks = 100*3;                                 % Downlink Resource Blocks = 300 (default)
    ul_resource_blocks = 100*2;                                 % Uplink Resource Blocks = 200 (default)
    rb_bandwidth = 180*10^3;                                    % RB Bandwidth : 180KHz (default)
    macro_cell_radiation = 10^(46/10)/1000;                     % Convert MC radiation from 46 dBm to Watts (default) 
    small_cell_radiation = 10^(30/10)/1000;                     % Convert SC radiation from 30 dBm to Watts (default)
    ue_radiation = 10^(23/10)/1000;                             % Convert UE radiation from 23 dBm to Watts (default)
    subcarrier_spacing = 15*10^3;                               % Subcarrier Spacing : 15KHz (default)
    white_noise = 10^(-174/10)/1000;                            % Convert white noise power density from -174dBm/Hz to Watts/Hz (default)
    carrier_frequency = 2*10^9;                                 % Carrier frequency : 2GHz (default)
    dl_bandwidth = 60*10^6;                                     % Downlink Bandwidth : 60Mhz (default)
    ul_bandwidth = 40*10^6;                                     % Uplink Bandwidth : 40MHz (default)
    downlink_subcarriers = 1201*3;                              % Calculate subcarriers for the Downlink network = 1201*3 (default)
    uplink_subcarriers = 1200*2;                                % Calculate subcarriers for the Uplink network = 1200*2 (default)
    devices_macro_dist = zeros(devices,macro_cells);            % Distance of UE from each macro cell
    devices_small_dist = zeros(devices,small_cells);            % Distance of UE from each small cell
    path_loss_macro_cells = zeros(devices,macro_cells);         % Path Loss of UE from each macro cell
    path_loss_small_cells = zeros(devices,small_cells);         % Path Loss of UE from each small cell
    channel_gain_macro_cells = zeros(devices,macro_cells);      % Channel gain of UE from each macro cell
    channel_gain_small_cells = zeros(devices,small_cells);      % Channel gain of UE from each small cell
    sinr_macro_cells = zeros(devices,macro_cells);              % SINR of UE from each macro cell
    sinr_small_cells = zeros(devices,small_cells);              % SINR of UE from each small cell
    device_dl_throughput_demands = zeros(1,devices);            % Downlink Throughput demands of each UE
    device_ul_throughput_demands = zeros(1,devices);            % Uplink Throughput demands of each UE
    device_dl_rb_demands = zeros(1,devices);                    % Downlink Resource Block Demand value of each UE
    device_ul_rb_demands = zeros(1,devices);                    % Uplink Resource Block Demand value of each UE
    devices_dl_rb_demands_eNB_index = zeros(1,devices);         % Downlink eNB index of the RB demands of each UE
    devices_ul_rb_demands_eNB_index = zeros(1,devices);         % Uplink eNB index of the RB demands of each UE
    dl_data_rates = zeros(1,devices);                           % Downlink Data rates for each UE
    ul_data_rates = zeros(1,devices);                           % Uplink Data rates for each UE
    available_dl_RBs_macro_cells(1,1:macro_cells) = round(dl_resource_blocks/macro_cells);  % Available downlink RBs for every macro cell (default = 43)
    available_dl_RBs_small_cells(1,1:small_cells) = round(dl_resource_blocks/small_cells);  % Available downlink RBs for every small cell (default = 14)
    available_ul_RBs_macro_cells(1,1:macro_cells) = round(ul_resource_blocks/macro_cells);  % Available uplink RBs for every macro cell (default = 29)
    available_ul_RBs_small_cells(1,1:small_cells) = round(ul_resource_blocks/small_cells);  % Available uplink RBs for every small cell (default = 10)
end

