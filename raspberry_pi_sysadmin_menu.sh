#!/bin/bash
################################################
# Script        : menu.sh                       #
# Author        : Tyler Billings                #
# Date          : 27 Jul 2018                   #
# Objective     : raspberry pi admin menu       #
#################################################
##### Bash Script #####//////////////////////////
#######################\\\\\\\\\\\\\\\\\\\\\\\\\\

#echo "Tyler's Raspberry Pi Web Server Sys Admin Menu...."
#echo -en "\n\n\t\t\tHit any key to continue"

# Disk space
diskspace() {
        clear
        df -k
}

# Users logged on
whoseon() {
        clear
        who --all && finger -lmps
}

# Memory Usage
memusage() {
        clear
        cat /proc/meminfo
}

netinfo() {
        clear
        ifconfig | grep inet | awk ' { print $2 } '
}

distro() {
        clear
        uname -a
        lsblk
}

patchupdate() {
        clear
        echo "Enter user name: "
        read USERNAME
        if [ $USERNAME = $USER ] ; then
                echo "Access Granted $USER"
                echo "Running system update..."
                sudo apt-get update
                sudo apt-get upgrade -y
                sudo apt-get dist-upgrade -y
                sudo apt-get autoremove -y
                sudo apt-get autoclean -y
                sudo rpi-update
                echo "Patching complete..."
        else
                echo "*** Access Denied. Run with root privilege. ***"
        fi
}

menu() {
        clear
        echo -e "\t\t\tSys Admin Menu\n"
        echo -e "\t1. Display disk space"
        echo -e "\t2. Display logged on users"
        echo -e "\t3. Display memory usage"
        echo -e "\t4. Display net info"
        echo -e "\t5. Display distro/kernal"
        echo -e "\t6. Update Server"
        echo -e "\t0. Exit program\n\n"
        echo -en "\t\tEnter option: "
        read -n 1 option
}

while [ 1 ] ; do
        menu
        case $option in
                0) break ;;
                1) diskspace ;;
                2) whoseon ;;
                3) memusage ;;
                4) netinfo ;;
                5) distro ;;
                6) patchupdate ;;
                *) clear
                        echo "*** invalid entry ***" ;;
        esac
        echo -en "\n\n\t\t\tHit any key to continue"
        read -n 1 line
done
