function [device_dl_throughput_demands] = calculateDownlinkThroughputDemands(devices)
    for j=1:devices
        possibility = rand;
        if possibility <= 0.4
            device_dl_throughput_demands(1,j) = 2048*10^3;
        elseif possibility <= 0.7
            device_dl_throughput_demands(1,j) = 4096*10^3;
        else
            device_dl_throughput_demands(1,j) = 8192*10^3;      
        end
    end
end

