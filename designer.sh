#!/usr/bin/env bash

mkdir ../$1
mkdir ../$1/binary
mkdir ../$1/build 
mkdir ../$1/dump 
mkdir ../$1/include 
mkdir ../$1/source 
cp main.cpp ../$1/

cp CMakeLists.txt ../$1/
cp -r cmake/ ../$1/cmake/

cp -r test/ ../$1/test

cp -r doxygen/ ../$1/doxygen/

cp -r .vscode/ ../$1

cp readme.md ../$1/
cp .gitignore ../$1/

sed -i "s/@project_name/$1/g" ../$1/cmake/CMakeConfigBasic.cmake

sed -i "s/@project_name/$1/g" ../$1/doxygen/DoxygenConfigBasic
