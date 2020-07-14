#!/bin/bash
#=============================================================
# https://github.com/cgkings/fclone_shell_bot
# File Name: fptask.sh
# Author: cgking
# Created Time : 2020.7.8
# Description:Point-to-point-task
# System Required: Debian/Ubuntu
# Version: final
#=============================================================

source ~/fclone_shell_bot/myfc_config.ini
clear
read -p "Please enter the source FolderID==>" link1
if [ -z "$link1" ] ; then
    echo "No input is allowed" && exit
else
link1=${link1#*id=};link1=${link1#*folders/};link1=${link1#*d/};link1=${link1%?usp*}
fi
read -p "Please enter the destination FolderID==>" link2
if [ -z "$link2" ] ; then
    echo "No input is allowed" && exit
else
link2=${link2#*id=};link2=${link2#*folders/};link2=${link2#*d/};link2=${link2%?usp*}
sed -i "s/${fp_link1}/${link1}/g" /root/fclone_shell_bot/myfc_config.ini
sed -i "s/${fp_link2}/${link2}/g" /root/fclone_shell_bot/myfc_config.ini
fi
echo -e "/nThis mode does not support queue tasks, only background tasks"
tmux new -s fptask -d
tmux send -t "fptask" '~/gclone_shell_bot/script/fpcopy.sh' Enter
echo -e "/nBackground task has started"
exit
