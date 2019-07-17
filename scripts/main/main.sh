#!/bin/bash
. scripts/public/public_function.sh
. scripts/public/public_vars.sh

# 关闭 Pcspkr
function remove_pcspkr() {
  #statements
  echo "blacklist pcspkr" >> /etc/modprobe.d/blacklist.conf
  modprobe -r pcspkr
}

remove_pcspkr

# TODO
# 分别为debian和archlinux做处理
which sudo && usermod -a -G sudo $username || { apt install sudo -y; /sbin/usermod -a -G sudo $username; }
cmd_success $? "add username: $username to sudo group."
. $work_path/scripts/main/install/debian/install.sh