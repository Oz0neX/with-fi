#!/bin/bash

# Argument -o outputs the log of the last session.
if [ $1 == "-o" ] ; then
        cat /etc/raspap/misc/logs
        exit 0
fi

if [ `id -u` -eq 0 ] ; then
        $(test -f /etc/raspap/misc/complete)
        if [ $? -eq 0 ] ; then
                rm /etc/raspap/misc/complete
        fi
        echo "Turning off RaspAp..."
        $(sleep 3m && [ -f /etc/raspap/misc/complete ]; if [ ! $? -eq 0 ] ; then printf "Long running command... rebooting." >> logs; sudo bash /etc/raspap/apconfig.sh ON --on-boot; sleep 10s; sudo reboot; fi) &
        printf "" &
        bash /etc/raspap/misc/apconfig.sh OFF > logs
        sleep 15s
else
        echo "Please run the command with sudo privileges"
        exit 1
fi

x=""
cmd=""
for i in "$@"; do
        var="$i"
        x="${cmd}${var} "
        cmd="${x}"
done

echo "Executing command: ${cmd}" >> logs
echo "Executing command: ${cmd}"
$($cmd >> logs)
if [ $? -eq 0 ] ; then
        echo "Success!" >> logs
else
        echo "Failed." >> logs
fi

echo "Turning on RaspAp..."
touch /etc/raspap/misc/complete
bash /etc/raspap/misc/apconfig.sh ON
sleep 10s
echo "RaspAp has successfully restarted!"
exit 0
