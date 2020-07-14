#!/bin/bash
#=============================================================
# https://github.com/roshanconnor123/fclone_shell_bot
# File Name: fcleanup.sh
# Author: cgking
# Created Time : 2020.7.8
# Description:定向比对
# System Required: Debian/Ubuntu
# Version: final
#=============================================================

source ~/fclone_shell_bot/myfc_config.ini
clear
read -p "Please Enter DriveID_1==>" link1
if [ -z "$link1" ] ; then
    echo "No input is allowed" && exit
else
link1=${link1#*id=};link1=${link1#*folders/};link1=${link1#*d/};link1=${link1%?usp*}
fi
read -p "Please Enter DriveID_2==>" link2
if [ -z "$link2" ] ; then
    echo "No input is allowed" && exit
else
link2=${link2#*id=};link2=${link2#*folders/};link2=${link2#*d/};link2=${link2%?usp*}
fi
echo -e "▣▣▣▣▣▣正在执行比对▣▣▣▣▣▣"
fclone check "$fclone_name":{$link1} "$fclone_name":{$link2} --fast-list --size-only --checkers=64
echo "|▉▉▉▉▉▉▉▉▉▉▉▉|100%  Completed"
