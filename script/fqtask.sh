#!/bin/bash
#=============================================================
# https://github.com/cgkings/fclone_shell_bot
# File Name: fqtask.sh
# Author: cgking
# Created Time : 2020.7.8
# Description:Extreme Edition-task
# System Required: Debian/Ubuntu
# Version: final
#=============================================================

source ~/fclone_shell_bot/myfc_config.ini
clear
read -p "Please enter shared link==>" link
link=${link#*id=};link=${link#*folders/};link=${link#*d/};link=${link%?usp*}
rootname=$(fclone lsd "$fclone_name":{$link} --dump bodies -vv 2>&1 | awk 'BEGIN{FS="\""}/^{"id/{print $8}')
if [ -z "$link" ] ; then
echo "No input is allowed" && exit ; 
elif [ -z "$rootname" ] ; then
echo "Error reading folder name, please give feedback to author" && exit ; else
echo -e "$link" >> ~/fclone_shell_bot/log/fqtask.log
fi
read -t 5 -n1 -p "Whether to continue to add queue tasks: [0. Yes/1. No]" task_stats
task_stats=${task_stats:-1}
while [[ $task_stats -eq 0 ]];do
    echo -e "/nContinue to add queue tasks"
    read -p "Please enter shared link==>" link
    link=${link#*id=};link=${link#*folders/};link=${link#*d/};link=${link%?usp*}
    rootname=$(fclone lsd "$fclone_name":{$link} --dump bodies -vv 2>&1 | awk 'BEGIN{FS="\""}/^{"id/{print $8}')
    if [ -z "$link" ] ; then
    echo "No input is allowed" && exit ; 
    elif [ -z "$rootname" ] ; then
    echo "Error reading folder name, please give feedback to author" && exit ; else
    echo -e "$link" >> ~/fclone_shell_bot/log/fqtask.log
    fi
    read -t 5 -n1 -p "Whether to continue to add queue tasks: [0. yes/1. no] (default 1)" task_stats
    task_stats=${task_stats:-1}
done
echo -e "/nStarting queue task"
tmux new -s fqtask -d
tmux send -t "fqtask" '~/fclone_shell_bot/script/fqcopy.sh' Enter
echo -e "/nQueue task has started"
exit
