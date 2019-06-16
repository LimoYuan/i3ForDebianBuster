#!/bin/bash
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
        echo -e "\033[31mError ==> \n    $2\033[0m is Empty !"
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
# 创建脚本工作时的临时目录
function install_cache() {
  #statements
  if [[ -d "$workPath/.cache" ]]; then
    #statements
    rm -rf $workPath/.cache
  fi
  mkdir -p $workPath/.cache
  cd $workPath/.cache
}
# 初始化
function init_script() {
  #statements
  print_dash
  echo -en "\033[32m Please input you create username: \033[0m"
  read user_name
  echo "/home/$user_name/i3ForDebianTesting" > /tmp/temp
  workPath=$(grep "i3For" /tmp/temp)
}
function script_description() {
    echo -e "\033[32m######################################################\033[0m"
    echo -e "\033[32m#                                                    #\033[0m"
    echo -e "\033[32m#\033[0m     AENO I3 config for debian buster               \033[32m#\033[0m"     
    echo -e "\033[32m#                                                    #\033[0m"
    echo -e "\033[32m#\033[0m     Date: 2019-06-16 Author: AENO Version: v1.0    \033[32m#\033[0m"
    echo -e "\033[32m#                                                    #\033[0m"
    echo -e "\033[32m######################################################\033[0m"
}