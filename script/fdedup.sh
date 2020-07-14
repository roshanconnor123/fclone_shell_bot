#!/bin/bash
#=============================================================
# https://github.com/roshanconnor123/fclone_shell_bot
# File Name: fdedup.sh
# Author: cgking
# Created Time : 2020.7.8
# Description:Remove Duplicates
# System Required: Debian/Ubuntu
# Version: final
#=============================================================

source ~/fclone_shell_bot/myfc_config.ini
clear
read -p "Please enter the FolderID to check==>" link
if [ -z "$link" ] ; then
    echo "No input is allowed" && exit
else
link=${link#*id=};link=${link#*folders/};link=${link#*d/};link=${link%?usp*}
fi
echo -e "▣▣▣▣▣▣Checking is being performed▣▣▣▣▣▣"
fclone dedupe largest "$fclone_name":{$link} --fast-list --size-only --drive-use-trash=true --no-traverse --checkers=64 --transfers=128 -q
echo "|▉▉▉▉▉▉▉▉▉▉▉▉|100%  Removed Dupes"
