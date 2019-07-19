#!/bin/bash
# welcome
script_description
# 工作路径
work_path=$(pwd)
# 临时目录
tmp_path=$work_path/.cache
is_exist "dir" "$tmp_path" && { Echo_color "yellow" "The dir is existed: $tmp_path, recreate the dir."; rm -rf $tmp_path; mkdir -p $tmp_path; } || mkdir -p $tmp_path
# 普通用户名
read -p "username: " username
# 普通用户密码
read -p "password: " password
# 普通用户家目录
user_home_path=$(awk -F ':' '{if($1=="'$username'"){print $6; exit}}' /etc/passwd)
# 设置代理, 拉取 i3Gaps, polybar, vim 插件, 可以不设置
Echo_color "green" "Set socks5 proxy, Quick download i3Gaps, polybar... source code. Do not use proxy, please enter."
read -p "Socks5_Host: " socks5_host
read -p "Socks5_Port: " socks5_port

isEmpty "$username" "username"
isEmpty "$password" "password"
isEmpty "$user_home_path" "user: $username Home path"
# isEmpty "$socks5_host" "Socks5 proxy: $socks5_host:$socks5_port"

echo
Echo_color "green" "username: $username"
Echo_color "green" "password: $password"
Echo_color "green" "Socks5 proxy: $socks5_host:$socks5_port"
echo
