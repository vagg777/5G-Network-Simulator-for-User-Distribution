function [device_ul_rb_demands,devices_ul_rb_demands_eNB_index,ul_data_rates] = calculateUplinkRBDemands(devices,device_ul_rb_demands,device_ul_throughput_demands,rb_bandwidth,sinr_ul_macro_cells,sinr_ul_small_cells,devices_ul_rb_demands_eNB_index,ul_data_rates)
    for j=1:devices
        [max_sinr, enb_index] = max([sinr_ul_macro_cells(j,:),sinr_ul_small_cells(j,:)]);                
        device_ul_rb_demands(1,j) = ceil( (device_ul_throughput_demands(1,j))/(rb_bandwidth*log2(1+max_sinr)) );
        devices_ul_rb_demands_eNB_index(1,j) = enb_index;
        ul_data_rates(j) = (device_ul_rb_demands(1,j)*rb_bandwidth*log2(1+max_sinr))/10^6;
    end
    
end

