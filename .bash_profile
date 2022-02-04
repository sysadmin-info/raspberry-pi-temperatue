clear
cpu=$(</sys/class/thermal/thermal_zone0/temp)
echo "$(tput bold)$(tput setaf 2)"
echo "    .~~.   .~~.  "
echo "   '. \ ' ' / .' "
echo "$(tput setaf 1)"
echo "    .~ .~~~..~.   "
echo "   : .~.'~'.~. :  "  
echo "  ~ (   ) (   ) ~ "  
echo " ( : '~'.~.'~' : )"    
echo "  ~ .~ (   ) ~. ~ "  
echo "   (  : '~' :  )  "  
echo "    '~ .~~~. ~'   "
echo "        '~'      "
let upSeconds="$(/usr/bin/cut -d. -f1 /proc/uptime)"
let secs=$((${upSeconds}%60))
let mins=$((${upSeconds}/60%60))
let hours=$((${upSeconds}/3600%24))
let days=$((${upSeconds}/86400))
UPTIME=`printf "%d days, %02dh%02dm%02ds" "$days" "$hours" "$mins" "$secs"`

# get the load averages
read one five fifteen rest < /proc/loadavg

echo "$(tput setaf 2)
`date +"%A, %e %B %Y, %r"`
`uname -srmo`
$(tput sgr0)- Uptime.............: ${UPTIME}
$(tput sgr0)- Memory.............: `free | grep Mem | awk '{print $3/1024}'` MB (Used) / `cat /proc/meminfo | grep MemTotal | awk {'print $2/1024'}` MB (Total)
$(tput sgr0)- Load Averages......: ${one}, ${five}, ${fifteen} (1, 5, 15 min)
$(tput sgr0)- Running Processes..: `ps ax | wc -l | tr -d " "`
$(tput sgr0)- IP Addresses.......: `hostname -I | /usr/bin/cut -d " " -f 1`
$(tput sgr0)- GPU temperature....: `echo "GPU => $(/usr/bin/vcgencmd measure_temp)" | sed 's/temp=//'`
$(tput sgr0)- CPU temperature....: `echo "CPU => $((cpu/1000))'C"`

$(tput sgr0)"
