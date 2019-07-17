#!/bin/bash

# clone i3gaps
if [[ -n $socks5_ip ]]; then
    Echo_color "purple" "Socks5 proxy: $socks5_ip"
    cd $tmp_path && proxychains4 -q git clone https://www.github.com/Airblader/i3 i3-gaps && cd i3-gaps
else
    Echo_color "purple" "No use socks5 proxy"
    cd $tmp_path && git clone https://www.github.com/Airblader/i3 i3-gaps && cd i3-gaps
fi

autoreconf --force --install
rm -rf build
mkdir -p build && cd build/
../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
make -j$(nproc)
cmd_success $? "i3Gaps build"
make install
cmd_success $? "i3Gaps install"
cd $work_path