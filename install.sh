#!/bin/bash

if [[ $(id -u) == 0 ]]; then
    . scripts/auto_install.sh
else
    echo "Please use root user login debian, then exec install.sh."
    exit
fi