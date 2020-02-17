#!/usr/bin/env bash

if [ "$1" == "check" ]; then
    for dir in ../*/;
    do 
        echo -e "\e[32m----------# Checking directory $dir #----------\e[39m";
        git -C $dir status;
        echo ""
    done
fi