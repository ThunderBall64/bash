File(){
        clear

        echo "-------------------------------------------"
        echo "$PWD"
        echo "-------------------------------------------"

        fileListing="$(ls)"

        let x=0
        localFileList=()
        for i in $fileListing; do
                if [ -f $i ]; then
                        localFileList[$x]=$i
                        #echo $x=$i
                        let x=$x+1
                fi
        done

        fileOptions=(${localFileList[@]})
        fileOptions+=('EXIT')

        PS3="Select a File To View: "

        select fileOpt in ${fileOptions[@]};do
                case $fileOpt in
                        EXIT)
                                return
                                ;;
                        [a-zA-Z0-9]*)
                                cat $fileOpt | less
                                ;;
                        *)
                                echo "**Invalid selection **"
                esac

        done

        localFileList=()
        for i in $fileListing; do
                if [ -f $i ]; then
                        localFileList[$x]=$i
                        #echo $x=$i
                        let x=$x+1
                fi
        done

        fileOptions=(${localFileList[@]})
        fileOptions+=('EXIT')

        PS3="Select a File To View: "

        select fileOpt in ${fileOptions[@]};do
                case $fileOpt in
                        EXIT)
                                return
                                ;;
                        [a-zA-Z0-9]*)
                                cat $fileOpt | less
                                ;;
                        *)
                                echo "**Invalid selection **"
                esac

        done
}

main_menu(){
        clear

        echo "-------------------------------------------"
        echo "$PWD"
        echo "-------------------------------------------"

        options=("Directory" "File" "Processes" "EXIT")

        PS3="Select an Option: "

        select option in ${options[@]};do
                case $option in
                        "Directory")
                                Directory
                                break
                                ;;
                        "File")
                                File
                                break
                                 ;;
                        "Processes")
                                top
                                break
                                ;;
                        "EXIT")
                                exit 0
                                ;;
                        *)
                                echo "**Invalid selection ** Select: (1, 2, 3 or 4)"
                                ;;
                esac

        done
}

while [ 0 -lt 1 ]
do
        main_menu
done



