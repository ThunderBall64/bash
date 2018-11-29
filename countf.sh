#!/bin/bash

# Right, okay so.


#Counting function here, with a recursion and a base case


#Starting area. Reads the CLI parameters.
#Params:

ZWAN="$PWD"
OPTRIG="-n"

helpo()
{
	echo "%%%% WELCOME TO THE COUNT FILE PROGRAM %%%%"
	echo "<<<<<<<<WRITTEN BY NICHOLAS CASTEEN>>>>>>>>"
	echo " "
	echo "Usage:"
	echo "./countf.sh [HELP] [OPTIONS] [DIRECTORY] [OPTIONS] [DIRECTORY] ... [OPTIONS] [DIRECTORY]"
	echo "Doing -h will ensure you ONLY get this help text."
	echo "Directories can be listed one after another, but each one must be supplied with its own options (If any), which always come before the directory"
	echo "*** NOTE *** : THIS PROGRAM COUNTS FILES BEGINNING WITH A PERIOD ( . )"
	echo " "
	echo "*** OPTIONS ***"
	echo "-di >> DIRECTORIES ONLY"
	echo "-fi >> FILES ONLY"
	echo "-a >> BOTH FILES AND DIRECTORIES"
	echo "<< FILES ONLY IS THE DEFAULT >>"
	echo " "
	echo "Each directory listed will only use one option; subsiquent options will be ignored."
	echo "(ie: ./countf.sh -di -a -fi /home/user/Documents will only read the -di as the option, ignoring the -a and -fi )"
	echo "EXAMPLE USAGE:"
	echo "./countf.sh -a /home/user/Music -di ./ -di ../ -fi /home/user/Downloads"
	echo " "
	echo "No Copyright on my part is legal, as I basically use other people's programs like ls and find"
	echo "+++2016+++"
}

							#COUNT FUNCTION
#&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
#&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
count()
{
	if [ "$1" = 1 ]; then #DEFAULT, FILES ONLY...wait.
		echo $( find "$2" -type f | wc -l )
	elif [ "$1" = 2 ]; then #DIRECTORIES ONLY
                echo $( find "$2" -type d | wc -l )
	elif [ "$1" = 3 ]; then #FILES ONLY...wait wait...
		echo $( find "$2" -type f | wc -l )
	elif [ "$1" = 4 ]; then #ALL OF THEM
		echo $( expr $( find "$2" -type f | wc -l ) + $( find "$2" -type d | wc -l ))
	else
		echo "Invalid"
	fi
}
#&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
#&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

if [ "$#" = 0 ]; then
	ATEMP="$PWD"
	count 1 "$ATEMP"
fi
#Right, so here's how this will work:
#-h MUST preceed everything and will BREAK the loop.
#Options MUST preceed directory, each one.
#Options include -di for "Directories only", -fi for "Files only" and -a for "all"
#Default is files only. This resets after a directory search is initiated.
#SO: First option will be used, others ignored until directory is searched.
#-h will be IGNORED if any other funtion has been called.
if [ "$1" = "-h" ]; then
	helpo

#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#HERE'S THE MAIN PART OF THE PROGRAM
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
elif [ "$1" != "-h" ]; then
#BGIN
   if [ "$#" != 0 ]; then

	until [ "$#" = 0 ]
	do
		#echo "$#"
		#echo "loop error"
		ATEMP="$1" #OUR FIRST PARAM <3 This changes with each iteration.
		#echo "$ATEMP"


#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



		if [ -d "$ATEMP" ]; then #If ATEMP is a directory, we go default.
			count 1 "$ATEMP"
			shift



#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



		elif [ "$ATEMP" = "-di" ]; then #If ATEMP is directory only, immediately look for a directory next. If none, use current.
			
			#GO TO DIRECTORY
			for checker in "$@" #GO DOWN THE WHOLE ARGUMENT LIST AS IT IS NOW
			do
				ATEMP="$checker"
				if [ -d "$ATEMP" ]; then #IF IT'S A DIRECTORY
					break #WE'RE DONE AND GOOD. No shift here, we'll do that after the counting.
				else
					shift #Shift over, we got to find a directory. Failing that, we need to empty the list.
				fi
			done
			#GO TO DIRECTORY

			if [ ! -d "$ATEMP" ]; then #If it's not a directory by now, make it one. The working directory, to be specific.
				ATEMP="$PWD"
			fi

			count 2 "$ATEMP" #GO TO FUNCTION count WITH RUN CODE 2 (Meaning Directories only) and $ATEMP PASSED IN
			shift #With all that said and done, we move the parameter list over, checking the next set of stuff.



#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



		elif [ "$ATEMP" = "-fi" ]; then #If ATEMP is file only, do the same as above. Look immediately for directory. If none, use current.

                        #GO TO DIRECTORY
                        for checker in "$@" #GO DOWN THE WHOLE ARGUMENT LIST AS IT IS NOW
                        do
                                ATEMP="$checker"
                                if [ -d "$ATEMP" ]; then #IF IT'S A DIRECTORY
                                        break #WE'RE DONE AND GOOD. No shift here, we'll do that after the counting.
                                else
                                        shift #Shift over, we got to find a directory. Failing that, we need to empty the list.
                                fi
                        done
                        #GO TO DIRECTORY

                        if [ ! -d "$ATEMP" ]; then #If it's not a directory by now, make it one. The working directory, to be specific.
                                ATEMP="$PWD"
                        fi

			count 3 "$ATEMP"
			shift



#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



		elif [ "$ATEMP" = "-a" ]; then #Again, immediately look for a directory. If none, use current.

                        #GO TO DIRECTORY
                        for checker in "$@" #GO DOWN THE WHOLE ARGUMENT LIST AS IT IS NOW
                        do
                                ATEMP="$checker"
                                if [ -d "$ATEMP" ]; then #IF IT'S A DIRECTORY
                                        break #WE'RE DONE AND GOOD. No shift here, we'll do that after the counting.
                                else
                                        shift #Shift over, we got to find a directory. Failing that, we need to empty the list.
                                fi
                        done
                        #GO TO DIRECTORY

                        if [ ! -d "$ATEMP" ]; then #If it's not a directory by now, make it one. The working directory, to be specific.
                                ATEMP="$PWD"
                        fi

			count 4 "$ATEMP"
			shift



#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



		else
			shift
			continue

		fi



#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


	#echo "$ATEMP"
	done #Where the While loop ends.
#END OF MAIN PROGRAM
   fi
fi #Also, this was all nested in an if statement check if the first arg was -h. 8P

exit 0 
