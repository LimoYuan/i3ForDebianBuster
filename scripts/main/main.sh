#!/bin/bash
. scripts/public/public_function.sh
. scripts/public/public_vars.sh

set_proxy $socks5_host $socks5_port
remove_pcspkr

# TODO
# 分别为debian和archlinux做处理
which sudo && usermod -a -G sudo $username || { apt install sudo -y; /sbin/usermod -a -G sudo $username; }
cmd_success $? "add username: $username to sudo group."
# 安装所需要的软件
. $work_path/scripts/main/install/debian/install.sh
# 安装i3-gaps
. $work_path/scripts/main/install/debian/ins_i3gaps.sh
# 安装polybar
. $work_path/scripts/main/install/debian/ins_polybar.sh