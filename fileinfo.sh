#!/bin/bash
# Lab 5 Script
# Write script to prompt user for 
# name of file 

echo -n  "Enter a file name: "

read FILENAME

if [ ! -e $FILENAME ] ; then
        echo "*** File $FILENAME does not exist."
        exit 2
elif [ -d $FILENAME ] ; then
        ls -lh $FILENAME | more
        exit 0
elif [ -f $FILENAME ]; then
        echo -n "Access level: "; stat --format=%A $FILENAME
        echo -n "Access level: "; stat --format=%b $FILENAME
        echo -n "Access level: "; stat --format=%B $FILENAME
        echo -n "Access level: "; stat --format=%g $FILENAME
        echo -n "Access level: "; stat --format=%U $FILENAME
        echo -n "Access level: "; stat --format=%z $FILENAME
else
        echo "file is not valid."
fi



