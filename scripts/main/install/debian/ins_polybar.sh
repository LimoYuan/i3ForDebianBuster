#!/bin/bash

# clone polybar
if [[ -n $socks5_ip ]]; then
    Echo_color "purple" "Socks5 proxy: $socks5_ip:$socks5_port"
    cd $tmp_path && proxychains4 -q git clone --recursive https://github.com/polybar/polybar polybar && cd polybar
else
    Echo_color "purple" "No use socks5 proxy"
    cd $tmp_path && proxychains4 -q git clone --recursive https://github.com/polybar/polybar polybar && cd polybar
fi

rm -rf build && mkdir build && cd build
cmake ..
make -j$(nproc)
cmd_success $? "polybar build"
make install
cmd_success $? "polybar install"
cd $work_path