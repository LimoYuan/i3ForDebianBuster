#!/bin/bash
# welcome
script_description
# 工作路径
work_path=$(pwd)
# 临时目录
tmp_path=$work_path/.cache
is_exist "dir" "$tmp_path" && { Echo_color "yellow" "The dir is existed: $tmp_path, rebuild the dir."; rm -rf $tmp_path; mkdir -p $tmp_path; } || mkdir -p $tmp_path
# 普通用户名
read -p "username: " username
# 普通用户密码
read -p "password: " password
# 普通用户家目录
user_home_path=$(awk -F ':' '{if($1=="'$username'"){print $6; exit}}' /etc/passwd)
isEmpty "$username" "username"
isEmpty "$password" "password"
isEmpty "$user_home_path" "user: $username Home path"
