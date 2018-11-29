#!/bin/bash

echo -n "Enter login name: "

read name
if [ "$name" = "$USER" ];
then
        echo "Username Confirmed, $name. Access granted . . ."
else
        echo "Access denied $USER, invalid username."
fi

