#!/usr/bin/env bash

while getopts "c:n:d:D:" opt; do
  case $opt in
    c) command=$OPTARG;;  
    n) name=$OPTARG;;
    d) dir=$OPTARG;;
    D) subdir=$OPTARG;;
    *) echo 'error' >&2
       exit 1
  esac
done

case $command  in 
  "create")
    mkdir $dir/$name
    mkdir $dir/$name/binary
    mkdir $dir/$name/build 
    mkdir $dir/$name/dump 
    mkdir $dir/$name/include 
    mkdir $dir/$name/source 
    cp main.cpp $dir/$name/
    cp CMakeLists.txt $dir/$name/
    cp -r cmake/ $dir/$name/cmake/
    cp -r test/ $dir/$name/test
    cp -r .vscode/ $dir/$name

    sed -i "s/@project_name/$name/g" $dir/$name/cmake/CMakeConfigBasic.cmake
  ;;

   *)

esac