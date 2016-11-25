#!/bin/bash
#title          :glog.sh
#description    :This script will make tar archieve for a git commit
#author         :Susruthan Seran
#date           :2016-11-25
#version        :0.1
#usage          :sh glog.sh

if [ $1 ]
then
    echo -e "\n\e[39mProvided commit id \e[42m\e[97m $1 \e[49m\e[39m"
    array=()

    #git diff-tree --name-only -r $1 > .glog
    git diff-tree --name-only --diff-filter=ACMR* -r $1 > .glog
    while IFS=  read -r line; 
    do
        array+=("$line")
    done < .glog
    
    rm -f .glog
    
    fl=""
    for i in ${!array[*]}
    do
        if [ $i != 0 ] && [ ${array[$i]} != '.gitignore' ]
        then
            if [ -f ${array[$i]} ]
            then
                fl+=" ${array[$i]}"
            else
                echo -e "\n\t\e[91mFile not exists:\t ${array[$i]}\e[39m\n"
            fi
        fi
    done

    if [ ${#fl} != 0 ]
    then
        tar -cf $1.tar $fl
        echo -e "\e[32mSuccessfully \e[34m$1.tar\e[32m created.\e[39m"
    else
        echo "Failed!"
    fi
else
    echo -e "\e[33mPlease provide a git commit id.\e[39m"
fi
