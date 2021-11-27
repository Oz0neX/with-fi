#! /bin/bash
arg1=$1
arg2=$2
welcomeMessage="This script enables/disables raspap's hotspot and allows the user to use Wi-Fi.\nTo use, pass the 'ON' or 'OFF' options when running the script.\nExample (with root): bash apconfig.sh ON"

if [[ ! -z "$arg2" ]] && [[ "$arg2" != "--on-boot" ]]; then
        printf "Unkown Command-Line Option: ${arg2}\n\n$welcomeMessage\n"
        exit 1
fi

if [ "$arg1" == "ON" ] ; then
        cp /etc/dhcpcd.apc /etc/dhcpcd.conf
        systemctl daemon-reload
        service dhcpcd restart
        if [ "$arg2" == "--on-boot" ] ; then
                printf "\nEnabling on boot...\n"
                systemctl enable dnsmasq
                systemctl enable hostapd
                systemctl enable lighttpd
                systemctl enable raspapd
        fi
        systemctl start dnsmasq
        systemctl start hostapd
        systemctl start lighttpd
        systemctl start raspapd
        systemctl restart dhcpcd
elif [ "$arg1" == "OFF" ] ; then
        mv /etc/dhcpcd.conf /etc/dhcpcd.apc
        touch /etc/dhcpcd.conf
        systemctl stop lighttpd
        systemctl stop dnsmasq
        systemctl stop hostapd
        systemctl stop raspapd
        if [ "$arg2" == "--on-boot" ] ; then
                printf "\nDisabling on boot...\n"
                systemctl disable dnsmasq
                systemctl disable hostapd
                systemctl disable lighttpd
                systemctl disable raspapd
        fi
        systemctl daemon-reload
        service dhcpcd restart
        systemctl restart dhcpcd
elif [ "$arg1" == "install" ] ; then
        printf "Installing Raspap"
        curl -sL https://install.raspap.com/ | bash -s -- --yes
else
        printf "Unkown Command-Line Option: ${arg1}\n\n$welcomeMessage\n"
        exit 1
fi

printf "\n"
exit
