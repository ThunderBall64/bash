#!/bin/bash

form_regex(){
returnVar=""
        case $1 in
                U)
                        #valid
                        case $2 in
                                "")
                                        returnVar='(,3,|,4,)'
                                        echo $returnVar
                                        return 0
                                        ;;

                                *)
                                        echo "*** Invalid number of arguments. ***">&2
                                        echo "USAGE: $0 <data file> <<Criterion> | Criterion > <Parameter>>">&2
                                        return 1
                                        ;;
                        esac
                        ;;
                L)
                        #valid"
                        case $2 in
                                "")
                                        returnVar='(,1,|,2,)'
                                        echo $returnVar
                                        return 0
                                        ;;
                                *)
                                        echo "*** Invalid number of arguments. ***">&2
                                        echo "USAGE: $0 <data file> <<Criterion> | Criterion > <Parameter>>">&2
                                        return 1
                                        ;;
                        esac
                        ;;
                Y)
                        #valid
                        case $2 in
                                1)
                                        returnVar=,1,
                                        echo $returnVar
                                        return 0
                                        ;;
                                2)
                                        returnVar=,2,
                                        echo $returnVar
                                        return 0
                                        ;;
                                                                                                                                         2)
                                        returnVar=,2,
                                        echo $returnVar
                                        return 0
                                        ;;
                                3)
                                        returnVar=,3,
                                        echo $returnVar
                                        return 0
                                        ;;
                                4)

                                        returnVar=,4,
                                        echo $returnVar
                                        return 0
                                        ;;
                                "")
                                        echo "Requires additional parameter">&2
                                        return 1
                                        ;;
                                *)
                                        echo "**Invalid parameter passed with this criterion">&2
                                        return 1
                                        ;;
                        esac
                        ;;
                D)
                        #valid
                        case $2 in
                                AS)
                                        returnVar=,AS,
                                        echo $returnVar
                                        return 0
                                        ;;
                                BT)
                                        returnVar=,BT,
                                        echo $returnVar
                                        return 0
                                        ;;
                                "")
                                        echo "Requires additional parameter">&2
                                        return 1
                                        ;;
                                *)
                                        echo "**Invalid parameter passed with this criterion">&2
                                        return 1
                                        ;;
                        esac
                        ;;
                "")
                        echo "Requires additional paramters">&2
                        return 1
                        ;;
                *)
                        echo "Invalid Criterion">&2
                        return 1
                        ;;
        esac



}

get_email(){
        list=$(echo $1 | tr " " "^" | tr "," " ")

        let x=0
        for i in $list;do
                array[$x]="$i"
                #echo "$x=$i"
                let "x=$x + 1"
        done

        echo ${array[6]}
        return 0

}



if [ $# -eq 0 -o $# -ge 4 ]; then
        echo "*** Invalid number of arguments. ***">&2
        echo "USAGE: $0 <data file> <<Criterion> | Criterion > <Parameter>>">&2
        exit 1
else
        fileName=$1

        form_regex $2 $3 >> /dev/null
        if [ $? = 0 ]; then
        regex=$(form_regex $2 $3)

        else
                exit 2
        fi

        if [ -f $fileName -a -r $fileName ]; then
                egrep "$regex" $1 | while read -r line; do
                echo $(get_email "$line")
                done
        else
                echo "*** File is not readable ***">&2
                echo "USAGE: $0 <data file> <<Criterion> | Criterion > <Parameter>>">&2
                exit 3
        fi
fi

                                                                                                      