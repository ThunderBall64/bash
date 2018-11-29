#!/bin/bash

banner_welcome(){
banner "Welcome "
banner "To The "
banner "Friendly "
banner "Shell"

read -p "Press ENTER key to continue..."

}

Directory(){
        clear

        echo "-------------------------------------------"
        echo "$PWD"
        echo "-------------------------------------------"



        dirListing="$(ls)"

        let x=0
        localDirList=()
        for i in $dirListing; do
                if [ -d $i ]; then
                        localDirList[$x]=$i
                        #echo $x=$i
                        let x=$x+1
                fi
        done

        dirOptions=('BACK')
        dirOptions+=(${localDirList[@]})
        dirOptions+=('EXIT')

        PS3="Select a Directory to Browse: "

        select dirOpt in ${dirOptions[@]};do
                case $dirOpt in
                        EXIT)
                                return
                                ;;
                        BACK)
                                cd ..
                                result=$?
                                if [ $result -eq 1 ]; then
                                        echo "You do not have permission to change to that directory"
                                else
                                        return
                                fi
                                ;;
                        [a-zA-z]*)
                                cd $dirOpt 2> /dev/null
                                result=$?
                                if [ $result -eq 1 ]; then
                                        echo "You do not have permission to change to that directory"
                                else
                                        return

                                fi
                                ;;
                        *)
                                echo "**Invalid selection **"
                esac
        done
}


menu_header(){
        clear

        echo "-------------------------------------------"
        echo "Friendly Shell 1.0 $PWD"
        echo "-------------------------------------------"
}

menu_options(){
        echo "1: Word Processor"
        echo "2: Spreadsheet"
        echo "3: Text Editor"
        echo "-----------------"
        echo "4: Change Directory"
        echo "-----------------"
        echo "5: Calender"
        echo "-----------------"
        echo "X: Exit"
}


read_options(){
        local selection
        read -p "Enter Choice [1-5|X] " selection
        case $selection in
                1) wordgrinder
                        #break
                         ;;
                2)sc
                        #break
                        ;;
                3)vi
                        #break
                        ;;
                4)Directory
                        #break
                        ;;
                5)cal
                        #break
                        read -p "Press ENTER key to continue..."
                        ;;
                X|x)
                        exit
                        ;;

                *)echo "***INVALID MENU SELECTION***"
                        read -p "Press Enter key to continue..."
                        ;;
        esac
}

trapSIGINT(){
        echo -e \\n**THIS ACTION IS NOT ALLOWED***;read -p "Press ENTER key to continue..."
}


trapSIGTERM(){
        trap 'banner; banner EXTERNAL KILL ATTEMPT'
        #read -p "Press ENTER key to continue..." fackEnterkey

}
trap 'trapSIGTERM' SIGTERM
trap 'clear; banner Thank You' EXIT
trap 'trapSIGINT;' SIGINT
banner_welcome
while true; do
        menu_header
        menu_options
        read_options
        #read -p "Press ENTER key to continue..."
done


