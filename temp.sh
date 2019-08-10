#!/bin/bash

while getopts "m:h" arg #选项后面的冒号表示该选项需要参数
do
        case $arg in
             m)
                #echo "a's arg:$OPTARG" #参数存在$OPTARG中
                shift
                case $OPTARG in
                1)
                echo $1;;
                2) 
                echo 2;;
                *)
                echo error
                ;;
                esac
                ;;
             h)
                echo "help"
                ;;
             ?)  #当有不认识的选项的时候arg为?
            echo "unkonw argument"
        exit 1
        ;;
        esac
done