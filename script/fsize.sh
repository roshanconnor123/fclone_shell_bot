#!/bin/bash
#=============================================================
# https://github.com/cgkings/fclone_shell_bot
# File Name: fsize.sh
# Author: cgking
# Created Time : 2020.7.8
# Description:size Calculation
# System Required: Debian/Ubuntu
# Version: final
#=============================================================

source ~/fclone_shell_bot/myfc_config.ini
clear
read -p "Please enter the query link==>" link
if [ -z "$link" ] ; then
    echo "No input is allowed" && exit
else
link=${link#*id=};link=${link#*folders/};link=${link#*d/};link=${link%?usp*}
fi
rootname=$(fclone lsd "$fclone_name":{$link} --dump bodies -vv 2>&1 | awk 'BEGIN{FS="\""}/^{"id/{print $8}')
size_info=`fclone size "$fclone_name":{$link} --checkers=200`
file_num=$(echo "$size_info" | awk 'BEGIN{FS=" "}/^Total objects/{print $3}')
file_size=$(echo "$size_info" | awk 'BEGIN{FS=" "}/^Total size/{print $3,$4}')
echo -e "▣▣▣▣▣▣任务信息▣▣▣▣▣▣\n"
echo -e "┋Folder Name┋:"$rootname"\n"
echo -e "┋Number of Files┋:"$file_num"\n"
echo -e "┋Size of Files┋:"$file_size"\n"
