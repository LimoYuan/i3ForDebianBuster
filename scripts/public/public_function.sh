#!/bin/bash
# print color echo
function Echo_color() {
  case $1 in
    "red")
    echo -e "\033[31m$2\033[0m"
    ;;
    "green")
    echo -e "\033[32m$2\033[0m"
    ;;
    "yellow")
    echo -e "\033[33m$2\033[0m"
    ;;
    "blue")
    echo -e "\033[34m$2\033[0m"
    ;;
    "purple")
    echo -e "\033[35m$2\033[0m"
    ;;
    "azure")
    echo -e "\033[36m$2\033[0m"
    ;;
    "white")
    echo -e "\033[37m$2\033[0m"
    ;;
    *)
    echo -e "\033[31mParameter is Error! \033[0m"
    # exit
    ;;
  esac
}
# 打印字符*
function print_dot() {
  #statements
  echo
  for (( i = 0; i < 80; i++ )); do
    #statements
    echo -en "\033[33m*\033[0m"
  done
  echo
  echo
}
# 打印横线
function print_dash() {
    echo
    for (( i = 0; i < 80; i++ )); do
        echo -en "\033[33m-\033[0m"
    done
    echo
    echo
}
# 打印输出信息
function print_info() {
    print_dot
    echo "$1"
    print_dot
}
# 命令是否执行成功
function isEmpty() {
    if [ -z $1 ] ;then
        echo -e "\033[31mError ==> \n    $2 is Empty !\033[0m"
        exit
    fi
}
# 命令是否执行成功
function cmd_success() {
    if [ $1 -eq 0 ] ;then
        print_dash
        echo -e "\033[32m $2  Successful !  \033[0m"
        print_dash
    else
        print_dash
        echo -e "\033[31m $2  Failed !!!  \033[0m"
        print_dash
        exit
    fi
}
# 检查文件或文件夹是否存在
function is_exist() {
  case $1 in
    "dir")
    [ -d "$2" ] && return 0 || return 1
    ;;
    "file")
    [ -f "$2" ] && return 0 || return 1
    ;;
    *)
    Echo_color "false"
    exit
    ;;
  esac
}
# 普通用户权限执行命令
# $1 username
# $2 password
# $3 command
function command_for_sudo() {
  echo $2 | sudo -S -u $1 $3
  [ $? == 0 ] && { Echo_color "green" "Command exec successful ==>\n  $3"; return 0; } || { Echo_color "red" "Command exec failed ==>\n  $3"; exit; }
}

# welcome
function script_description() {
    echo -e "\033[32m######################################################\033[0m"
    echo -e "\033[32m#                                                    #\033[0m"
    echo -e "\033[32m#\033[0m     AENO I3 config for debian buster               \033[32m#\033[0m"     
    echo -e "\033[32m#                                                    #\033[0m"
    echo -e "\033[32m#\033[0m     Date: 2019-06-16 Author: AENO Version: v1.0    \033[32m#\033[0m"
    echo -e "\033[32m#                                                    #\033[0m"
    echo -e "\033[32m######################################################\033[0m"
}