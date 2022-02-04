#!/bin/bash
# Script: pi-temp.sh
# Purpose: Display the ARM CPU and GPU  temperature of Raspberry Pi 2/3/4
# Author: Adrian Ambroziak <sysadmin.info.pl> under GPL v3.x+
# -------------------------------------------------------
homedir="$(getent passwd $( /usr/bin/id -u ) | cut -d: -f6)"
OutputFile="TemperatureReport-$(date +%d-%m-%Y).csv"
cpu=$(</sys/class/thermal/thermal_zone0/temp)
while true; do
        echo "$(date) @ $(hostname)" >> /$homedir/$OutputFile
        echo "GPU => $(/usr/bin/vcgencmd measure_temp)" | sed 's/temp=//' >> /$homedir/$OutputFile
        echo "CPU => $((cpu/1000))'C" >> /$homedir/$OutputFile
        sleep 2;
done
