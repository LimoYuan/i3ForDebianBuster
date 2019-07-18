#!/bin/bash

# 清除代理
git config --global --unset http.proxy
git config --global --unset https.proxy
unset http_proxy
unset https_proxy

if [[ -f scripts/install.lock ]]; then
  echo -e "\033[31mAlready installed, reinstall please delete scripts/install.lock .\033[0m"
  exit
fi

touch scripts/install.lock

. scripts/public/public_function.sh
. scripts/public/public_vars.sh

# TODO
# 分别为debian和archlinux做处理
which sudo && usermod -a -G sudo $username || { apt install sudo -y; /sbin/usermod -a -G sudo $username; }
cmd_success $? "add username $username to sudo group"

# 关闭蜂鸣音
  remove_pcspkr
# 安装所需要的软件
. $work_path/scripts/main/install/debian/install_software.sh

# 设置代理
  set_proxy "$socks5_host" "$socks5_port"
# 调试, 到这里总有问题
  Echo_color "purple" "Socks5 proxy: $socks5_ip"
  
# 安装i3-gaps
. $work_path/scripts/main/install/debian/ins_i3gaps.sh
# 安装polybar
. $work_path/scripts/main/install/debian/ins_polybar.sh
# 配置项
. $work_path/scripts/main/install/debian/config.sh

print_dash
Echo_color "green" "Successful, Please check has error. then exec command: systemctl reboot"
print_dash

rm -rf /tmp/i3ForDebianBuster