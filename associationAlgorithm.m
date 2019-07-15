function [dl_data_rates,ul_data_rates] = associationAlgorithm(devices,device_dl_rb_demands,device_ul_rb_demands,device_dl_throughput_demands,device_ul_throughput_demands,rb_bandwidth,sinr_dl_macro_cells,sinr_dl_small_cells,sinr_ul_macro_cells,sinr_ul_small_cells,dl_resource_blocks,ul_resource_blocks,devices_dl_rb_demands_eNB_index,devices_ul_rb_demands_eNB_index,downlink_subcarriers,uplink_subcarriers,dl_data_rates,ul_data_rates,available_dl_RBs_macro_cells,available_dl_RBs_small_cells,available_ul_RBs_macro_cells,available_ul_RBs_small_cells,macro_cells,small_cells)

     % Calculate Downlink Resource Block demands for the UE-eNB completed
     [device_dl_rb_demands,devices_dl_rb_demands_eNB_index,dl_data_rates] = calculateDownlinkRBDemands(devices,device_dl_rb_demands,device_dl_throughput_demands,rb_bandwidth,sinr_dl_macro_cells,sinr_dl_small_cells,devices_dl_rb_demands_eNB_index,dl_data_rates);

     % Calculate Uplink Resource Block demands for the UE-eNB completed
     [device_ul_rb_demands,devices_ul_rb_demands_eNB_index,ul_data_rates] = calculateUplinkRBDemands(devices,device_ul_rb_demands,device_ul_throughput_demands,rb_bandwidth,sinr_ul_macro_cells,sinr_ul_small_cells,devices_ul_rb_demands_eNB_index,ul_data_rates);
     temp_dl_rb_device_demands = device_dl_rb_demands;
     temp_ul_rb_device_demands = device_ul_rb_demands; 
     temp_sinr_dl_macro_cells = sinr_dl_macro_cells;
     temp_sinr_dl_small_cells = sinr_dl_small_cells;
     temp_sinr_ul_macro_cells = sinr_ul_macro_cells;
     temp_sinr_ul_small_cells = sinr_ul_small_cells;
     dl_small_cell_connections = 0;
     dl_macro_cell_connections = 0;
     ul_small_cell_connections = 0;
     ul_macro_cell_connections = 0;
     dl_unsupported_UEs = 0;
     ul_unsupported_UEs = 0;
     dl_preserved_QoS = 0;
     ul_preserved_QoS = 0;
     dl_optimal_failures = strings([1,devices]);
     ul_optimal_failures = strings([1,devices]);
     fprintf("\n----------------- Running association algorithm -----------------\n\n");
     
     
     % UE-eNB association in the downlink network
     for j=1:devices
         completed = false;
         inner_loops = 1;
         [demand, device_index] = min(temp_dl_rb_device_demands);           
         eNB_index = devices_dl_rb_demands_eNB_index(device_index);  
         [max_sinr, new_eNB] = max([temp_sinr_dl_macro_cells(device_index,:),temp_sinr_dl_small_cells(device_index,:)]);
         while (completed==false)
             temp_dl_rb_device_demands(device_index) = 10^10;
             if (inner_loops >= 2)
                 if (eNB_index <= macro_cells)
                     temp_sinr_dl_macro_cells(device_index,eNB_index) = 0;
                 else
                     temp_sinr_dl_small_cells(device_index,eNB_index-macro_cells) = 0;
                 end
                 [max_sinr, new_eNB] = max([temp_sinr_dl_macro_cells(device_index,:),temp_sinr_dl_small_cells(device_index,:)]);
                 device_dl_rb_demands(1,device_index) = ceil( (device_dl_throughput_demands(1,device_index))/(rb_bandwidth*log2(1+max_sinr)) );
                 devices_dl_rb_demands_eNB_index(1,device_index) = new_eNB;
                 dl_data_rates(1,device_index) = (device_dl_rb_demands(1,device_index)*rb_bandwidth*log2(1+max_sinr))/10^6;
                 eNB_index = new_eNB;
             end
             if (eNB_index <= macro_cells)
                 eNB_available_RBs = available_dl_RBs_macro_cells(eNB_index);
             else
                 eNB_available_RBs = available_dl_RBs_small_cells(eNB_index-macro_cells);
             end
            
             if (eNB_available_RBs - demand) >= 0 
                 if (eNB_index <= macro_cells)
                         fprintf("[DOWNLINK] Device %d will connect with macro cell %d | data rates = %.2f(Mbps) | sinr = %.2f(dB)\n",device_index,eNB_index,dl_data_rates(1,device_index),10*log10(max_sinr));
                         available_dl_RBs_macro_cells(eNB_index) = available_dl_RBs_macro_cells(eNB_index) - demand;
                         dl_macro_cell_connections = dl_macro_cell_connections + 1;
                 else
                         fprintf("[DOWNLINK] Device %d will connect with small cell %d | data rates = %.2f(Mbps) | sinr = %.2f (dB)\n",device_index,eNB_index-macro_cells,dl_data_rates(1,device_index),10*log10(max_sinr));
                         available_dl_RBs_small_cells(eNB_index-macro_cells) = available_dl_RBs_small_cells(eNB_index-macro_cells) - demand;
                         dl_small_cell_connections = dl_small_cell_connections + 1;
                 end
                 if (dl_data_rates(1,device_index) >= (device_dl_throughput_demands(1,device_index)/10^6))
                    %fprintf("[DOWNLINK] Device %d has equal or higher QoS than requested\n",device_index);
                    dl_preserved_QoS = dl_preserved_QoS + 1;
                 else
                    %fprintf("[DOWNLINK] Device %d has lower QoS than requested\n",device_index);
                 end
                 dl_resource_blocks = dl_resource_blocks - demand;
                 downlink_subcarriers = downlink_subcarriers - demand*12;
                 completed = true;
             else
                 dl_optimal_failures(1,device_index) = "yes";
                 if (inner_loops == macro_cells+small_cells)
                     fprintf(2,"[DOWNLINK] Unable to serve device %d from the network !!!\n",device_index)
                     dl_unsupported_UEs = dl_unsupported_UEs + 1;
                     completed=true;
                 end
                 inner_loops = inner_loops + 1;
             end        
         end
     end
     
     
     
     fprintf("\n--------------------------------------------------------------------\n\n");
     
     
     
     % UE-eNB association in the uplink network
     for j=1:devices
         completed = false;
         inner_loops = 1;
         [demand, device_index] = min(temp_ul_rb_device_demands);           
         eNB_index = devices_ul_rb_demands_eNB_index(device_index);
         [max_sinr, new_eNB] = max([temp_sinr_ul_macro_cells(device_index,:),temp_sinr_ul_small_cells(device_index,:)]);
         while (completed==false)
             temp_ul_rb_device_demands(device_index) = 10^10;
             if (inner_loops >= 2)
                 if eNB_index <= 19 
                     temp_sinr_ul_macro_cells(device_index,eNB_index) = 0;
                 else
                     temp_sinr_ul_small_cells(device_index,eNB_index-macro_cells) = 0;
                 end
                 [max_sinr, new_eNB] = max([temp_sinr_ul_macro_cells(device_index,:),temp_sinr_ul_small_cells(device_index,:)]);
                 device_ul_rb_demands(1,device_index) = ceil( (device_ul_throughput_demands(1,device_index))/(rb_bandwidth*log2(1+max_sinr)) );
                 devices_ul_rb_demands_eNB_index(1,device_index) = new_eNB;
                 ul_data_rates(1,device_index) = (device_ul_rb_demands(1,device_index)*rb_bandwidth*log2(1+max_sinr))/10^6;
                 eNB_index = new_eNB;
             end
             if (eNB_index <= macro_cells)
                 eNB_available_RBs = available_ul_RBs_macro_cells(eNB_index);
             else
                 eNB_available_RBs = available_ul_RBs_small_cells(eNB_index-macro_cells);
             end
             if (eNB_available_RBs - demand) >= 0 
                 if eNB_index <= macro_cells
                         fprintf("[UPLINK] Device %d will connect with macro cell %d | data rates = %.2f(Mbps) | sinr = %.2f(dB)\n",device_index,eNB_index,ul_data_rates(1,device_index),10*log10(max_sinr));
                         available_ul_RBs_macro_cells(eNB_index) = available_ul_RBs_macro_cells(eNB_index) - demand;
                         ul_macro_cell_connections = ul_macro_cell_connections + 1;
                 else
                         fprintf("[UPLINK] Device %d will connect with small cell %d | data rates = %.2f(Mbps) | sinr = %.2f(dB)\n",device_index,eNB_index-macro_cells,ul_data_rates(1,device_index),10*log10(max_sinr));
                         available_ul_RBs_small_cells(eNB_index-macro_cells) = available_ul_RBs_small_cells(eNB_index-macro_cells) - demand;
                         ul_small_cell_connections = ul_small_cell_connections + 1;
                 end
                 if (ul_data_rates(1,device_index) >= (device_ul_throughput_demands(1,device_index)/10^6))
                    %fprintf("[UPLINK] Device %d has equal or higher QoS than requested\n",device_index);
                    ul_preserved_QoS = ul_preserved_QoS + 1;
                 else
                    %fprintf("[UPLINK] Device %d has lower QoS than requested\n",device_index);
                 end
                 ul_resource_blocks = ul_resource_blocks - demand;
                 uplink_subcarriers = uplink_subcarriers - demand*12;
                 completed = true;
             else
                 ul_optimal_failures(1,device_index) = "yes";
                 if (inner_loops == macro_cells+small_cells)
                     fprintf(2,"[UPLINK] Unable to serve device %d from the network !!!\n",device_index)
                     ul_unsupported_UEs = ul_unsupported_UEs + 1;
                     completed=true;
                 end
                 inner_loops = inner_loops + 1;
             end        
         end
     end
     

     
     
     fprintf("\n------------ UE-eNB Association results ------------\n\n");
     fprintf("Network Devices : %d\n",devices)
     fprintf("[DOWNLINK] Macro cell Connections :  %d\n",dl_macro_cell_connections);
     fprintf("[DOWNLINK] Small cell Connections : %d\n",dl_small_cell_connections);
     fprintf("[DOWNLINK] Unsupported devices : %d\n",dl_unsupported_UEs);
     fprintf("[DOWNLINK] Successful Connections : %d\n",dl_macro_cell_connections+dl_small_cell_connections);
     fprintf("[DOWNLINK] Successful Connection rate : %.2f %%\n",100*(dl_macro_cell_connections+dl_small_cell_connections)/(devices));
     fprintf("[DOWNLINK] Devices that preserved QoS : %d\n",dl_preserved_QoS);
     fprintf("[DOWNLINK] Preserved QoS rate: %.2f %%\n",100*(dl_preserved_QoS/(dl_macro_cell_connections+dl_small_cell_connections)));
     fprintf("[DOWNLINK] Failures at completing optimal UE-eNB association : %d\n",sum(count(dl_optimal_failures,"yes")));
     fprintf("[DOWNLINK] Optimal association failure rate : %.2f %%\n",100*(sum(count(dl_optimal_failures,"yes")))/(devices));
     fprintf("[UPLINK] Macro cell Connections :  %d\n",ul_macro_cell_connections);
     fprintf("[UPLINK] Small cell Connections : %d\n",ul_small_cell_connections);
     fprintf("[UPLINK] Unsupported devices : %d\n",ul_unsupported_UEs);
     fprintf("[UPLINK] Successful Connections : %d\n",ul_macro_cell_connections+ul_small_cell_connections);
     fprintf("[UPLINK] Successful Connection rate : %.2f %%\n",100*(ul_macro_cell_connections+ul_small_cell_connections)/(devices));
     fprintf("[UPLINK] Devices that preserved QoS : %d\n",ul_preserved_QoS);
     fprintf("[UPLINK] Preserved QoS rate: %.2f %%\n",100*(ul_preserved_QoS/(ul_macro_cell_connections+ul_small_cell_connections)));
     fprintf("[UPLINK] Failures at completing optimal UE-eNB association : %d\n",sum(count(ul_optimal_failures,"yes")));
     fprintf("[UPLINK] Optimal association failure rate : %.2f %%\n",100*(sum(count(ul_optimal_failures,"yes")))/(devices));
end

