#!/bin/bash

# 移动配置文件到 $HOME
function copy_config_files() {
  #statements
  export LANG='en_US.UTF-8'
  command_for_user $username "xdg-user-dirs-update"
  rm -rf $user_home_path/.vim*
  command_for_user $username "cp -rf $work_path/Config/. $user_home_path/"
  # 重启后执行
  # xrdb -merge $HOME/.Xresources
}

# 安装字体
function install_fonts() {
  #statements
  command_for_user $username "echo $password | sudo -S fc-cache --force --verbose"
  cmd_success $? "Fonts install"
  dpkg-reconfigure locales
  command_for_user $username "echo $password | sudo -S sed -i 's/LANGUAGE="en_US:en"/LANGUAGE="zh_CN"/g' /etc/default/locale"
}

# 安装 vim 插件
function install_vim_plugins() {
  #statements
  command_for_user $username "ln -sf $user_home_path/.vim/.vimrc $user_home_path"
  command_for_user $username "ln -sf $user_home_path/.vim/.vimrc.local $user_home_path"
  command_for_user $username "ln -sf $user_home_path/.vim/.ycm_extra_conf.py $user_home_path"
  if [[ -n $socks5_ip ]]; then
    Echo_color "purple" "Socks5 proxy: $socks5_ip"
    command_for_user $username "mkdir -p $user_home_path/.vim/bundle"
    command_for_user $username "proxychains4 -q git clone https://github.com/VundleVim/Vundle.vim.git $user_home_path/.vim/bundle/Vundle.vim"
    # command_for_user $username "proxychains4 -q vim +PluginInstall +qall"
  else
    Echo_color "purple" "No use socks5 proxy"
    command_for_user $username "git clone https://github.com/VundleVim/Vundle.vim.git $user_home_path/.vim/bundle/Vundle.vim"
    # command_for_user $username "vim +PluginInstall +qall"
  fi
  cmd_success $? "Vim Plugins installed "
  # command_for_user $username "echo $password | sudo -S $user_home_path/.vim/bundle/YouCompleteMe/install.py --clang-completer"
  # cmd_success $? "YCM installed "
}

# 安装 OhMyZsh
function install_ohMyZsh() {
  #statements
  # 重启后需要执行 proxychains4 -q install.sh -O -
  command_for_user $username "cd $user_home_path && wget -c https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh"
  # 重启后需要执行 cp -rf $HOME/.zshrc.bak $HOME/.zshrc
}
# MPD && NCMPCPP
function install_mpd_ncmpcpp() {
  #statements
  rm -rf /etc/mpd.conf
  command_for_user $username "mkdir -p $user_home_path/.mpd"
  command_for_user $username "touch $user_home_path/.mpd/{mpd.db,mpd.log,mpd.pid,mpdstate}"
  command_for_user $username "mkdir -p $user_home_path/.mpd/playlists"
  sudo usermod -aG pulse,pulse-access mpd
  command_for_user $username "mv $user_home_path/stay.mp3 $user_home_path/Music/"
}
# 启动服务
function setting_services() {
  #statements
  systemctl stop mpd
  systemctl disable mpd
}
# 删除有冲突的软件
function remove_software() {
  sudo apt -y remove --purge dunst notification-daemon
}
# 删除有冲突的软件
function move_after_reboot_script() {
  cp -rf $work_path/scripts/main/install/debian/after_reboot.sh $user_home_path/
  chown $username:$username $user_home_path/after_reboot.sh
}

copy_config_files
install_fonts
install_vim_plugins
setting_services
install_mpd_ncmpcpp
remove_software
# install_ohMyZsh
move_after_reboot_script
