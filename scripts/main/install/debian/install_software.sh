#!/bin/bash

# 更换镜像源
function sources_list() {
  print_info "Replace apt sources list to << USTC mirrors >> for china. And update upgrade your system."
  mv /etc/apt/{sources.list,sources.list.bak}
  wget -O /etc/apt/sources.list -c https://mirrors.ustc.edu.cn/repogen/conf/debian-https-4-buster
  # 添加 Debiancn 源
  echo "deb https://mirrors.ustc.edu.cn/debiancn/ buster main" | tee /etc/apt/sources.list.d/debiancn.list
  wget -c https://mirrors.ustc.edu.cn/debiancn/debiancn-keyring_0~20161212_all.deb -O /tmp/debiancn-keyring.deb
  apt install -y /tmp/debiancn-keyring.deb
  apt update && apt upgrade -y
}

# 安装基础包
function base_software() {
  #statements
  apt install -y linux-headers-$(uname -r|sed 's/[^-]*-[^-]*-//') linux-headers-$(uname -r|sed 's,[^-]*-[^-]*-,,') linux-image-$(uname -r|sed 's,[^-]*-[^-]*-,,')
}

# 安装常用软件
function install_software() {
  #statements
  grep -v "#" $work_path/scripts/pkg/debian/$1 | xargs apt install -y
  cmd_success $? "<< function: base_software -- $1 >>"
}

apt update && apt upgrade -y
sources_list
base_software
install_software "software"