#!/bin/bash

# Script        : bkup
# Author        : billint
# Date          : 7th March 2018
# Objective     : Implement automation for script to back up a directory

#############################
####### Bash Script #########
#############################

# If variable = 0 then directory = working directory. If it = 1 then state invalid arg.
if [ $# -eq 0 ]; then
        DIR=$(pwd)
elif [ $# -eq 1 ]; then
        DIR=$1
else
        echo "Invalid number of arguments">&2
        echo "USAGE: $0 [directory]"
        exit 1
fi

# Iterate backup to determine if specified dir. If user entered the name of an existing item, whether it be a file or python script, echo error stating it is not a directory and can't back up.
if [ ! -d $DIR ]; then
        echo "*** $DIR is not a directory. Can't back up.">&2
        exit 2
fi

# If subject exists, iterate input to determine if subject is a directory. If it is then copy over into bkup directory. If it does not exist then echo argument stating it's not there & stderr & exit 3
if [ -e $HOME/.bkup ]; then
        if [ -d $HOME/.bkup ]; then
                rm -rv $HOME/.bkup
        else
                echo "This directory does not exist.">&2
                exit 3
        fi
fi

# Creating backup directory copying contents to designation
mkdir $HOME/.bkup

cp -rv $DIR $HOME/.bkup

~                                                                                                        
~                                                                                                        
~                                                                                                        
"bkup" 43L, 1207C                                                                      1,1           All
