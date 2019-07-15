function [device_ul_throughput_demands] = calculateUplinkThroughputDemands(devices)
    for j=1:devices
        possibility = rand;
        if possibility <= 0.6
            device_ul_throughput_demands(1,j) = 1024*10^3;
        elseif possibility <= 0.9
            device_ul_throughput_demands(1,j) = 2048*10^3;
        else
            device_ul_throughput_demands(1,j) = 4096*10^3;      
        end
    end
end

