#!/bin/bash
. scripts/public/public_function.sh
. scripts/public/public_vars.sh

which sudo && usermod -a -G sudo $username || { apt install sudo -y; usermod -a -G sudo $username; }


