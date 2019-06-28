#!/bin/bash
. scripts/public/public_function.sh
. scripts/public/public_vars.sh

# 关闭 Pcspkr
function remove_pcspkr() {
  #statements
  echo "blacklist pcspkr" >> /etc/modprobe.d/blacklist.conf
  modprobe -r pcspkr
}

function sources_list() {
  print_info "Replace apt sources list to << USTC mirrors >> for china. And update upgrade your system."
  mv /etc/apt/{sources.list,sources.list.bak}
  wget -O /etc/apt/sources.list -c https://mirrors.ustc.edu.cn/repogen/conf/debian-https-4-buster
  # 添加 Debiancn 源
  echo "deb https://mirrors.ustc.edu.cn/debiancn/ buster main" | tee /etc/apt/sources.list.d/debiancn.list
  wget -c https://mirrors.ustc.edu.cn/debiancn/debiancn-keyring_0~20161212_all.deb -O /tmp/debiancn-keyring.deb
  command_for_sudo $username $password "apt install -y /tmp/debiancn-keyring.deb"
  apt update && apt upgrade -y
}

# 安装基础包
function base_software() {
  #statements
  apt install -y linux-headers-$(uname -r|sed 's/[^-]*-[^-]*-//') linux-headers-$(uname -r|sed 's,[^-]*-[^-]*-,,') linux-image-$(uname -r|sed 's,[^-]*-[^-]*-,,')
  install_software "base"
}

# 安装常用软件
function install_software() {
  #statements
  grep -v "#" $work_path/scripts/packages/$1 | xargs apt install -y
  cmd_success $? "<< function: base_software -- $1 >>"
}

which sudo && usermod -a -G sudo $username || { apt install sudo -y; usermod -a -G sudo $username; }
cmd_success $? "add username: $username to sudo group."
remove_pcspkr
sources_list
base_software
install_software "inputMethod"
install_software "software"