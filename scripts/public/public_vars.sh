#!/bin/bash
. public_function.sh
# 普通用户名
read -p "username: " username
# 普通用户密码
read -p "password: " password
# 普通用户家目录
user_home_path=$(awk -F ':' '{if($1=="'$username'"){print $6; exit}}' /etc/passwd)
isEmpty "$user_home_path" "user: $username Home path"
