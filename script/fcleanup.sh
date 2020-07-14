#!/bin/bash
#=============================================================
# https://github.com/roshanconnor123/fclone_shell_bot
# File Name: fcleanup.sh
# Author: cgking
# Created Time : 2020.7.8
# Description:Empty the recycle bin
# System Required: Debian/Ubuntu
# Version: final
#=============================================================

source ~/fclone_shell_bot/myfc_config.ini
clear
read -p "Please enter the TeamDrive ID==>" link
if [ -z "$link" ] ; then
    echo "No input is allowed" && exit
else
    link=${link#*id=};link=${link#*folders/};link=${link#*d/};link=${link%?usp*}
fi
echo -e "▣▣▣▣▣▣▣▣Empty the recycle bin▣▣▣▣▣▣▣▣\n"
fclone delete "$fclone_name":{$link} --fast-list --drive-trashed-only --drive-use-trash=false --verbose=2 --checkers=64 --transfers=128 -q
fclone rmdirs "$fclone_name":{$link} --fast-list --drive-trashed-only --drive-use-trash=false --verbose=2 --checkers=64 --transfers=128 -q
echo -e "|▉▉▉▉▉▉▉▉▉▉▉▉|100%  The recycle bin is emptied"
