#!/bin/bash

read -p "Is use proxy? input 1 is use: " is_proxy

if [[ $is_proxy == "1" ]]; then
    proxychains4 -q vim +PluginInstall +qall
    proxychains4 -q $HOME/.vim/bundle/YouCompleteMe/install.py --clang-completer
    proxychains4 -q sh -c "$(proxychains4 -q wget -c https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
    proxychains4 -q git clone https://github.com/bhilburn/powerlevel9k.git $HOME/.oh-my-zsh/themes/powerlevel9k
else
    vim +PluginInstall +qall
    $HOME/.vim/bundle/YouCompleteMe/install.py --clang-completer
    sh -c "$(wget -c https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
    git clone https://github.com/bhilburn/powerlevel9k.git $HOME/.oh-my-zsh/themes/powerlevel9k
fi

xrdb -merge $HOME/.Xresources
cp -rf $HOME/.zshrc.bak $HOME/.zshrc

echo -e "\033[32m######################################################\033[0m"
echo
echo "Installed. Good luck!"
echo
echo -e "\033[32m######################################################\033[0m"

rm -rf $HOME/install.sh
rm -rf $HOME/after_reboot.sh