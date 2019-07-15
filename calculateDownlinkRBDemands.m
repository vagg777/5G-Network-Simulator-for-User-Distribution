function [device_dl_rb_demands,devices_dl_rb_demands_eNB_index,dl_data_rates] = calculateDownlinkRBDemands(devices,device_dl_rb_demands,device_dl_throughput_demands,rb_bandwidth,sinr_dl_macro_cells,sinr_dl_small_cells,devices_dl_rb_demands_eNB_index,dl_data_rates)
    for j=1:devices
        [max_sinr, enb_index] = max([sinr_dl_macro_cells(j,:),sinr_dl_small_cells(j,:)]);
        device_dl_rb_demands(1,j) = ceil( (device_dl_throughput_demands(1,j))/(rb_bandwidth*log2(1+max_sinr)) );
        devices_dl_rb_demands_eNB_index(1,j) = enb_index;
        dl_data_rates(j) = (device_dl_rb_demands(1,j)*rb_bandwidth*log2(1+max_sinr))/10^6;
    end
end

