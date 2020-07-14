#!/bin/bash
#=============================================================
# https://github.com/roshanconnor123/fclone_shell_bot
# File Name: fbtask.sh
# Author: cgking
# Created Time : 2020.7.8
# Description:Full Drive Backup-task
# System Required: Debian/Ubuntu
# Version: final
#=============================================================

source ~/fclone_shell_bot/myfc_config.ini
clear
echo -e " Choose the disk you want to backup
[1]. ADV Drive
[2]. MDV Drive
[3]. BOOK Drive
[4]. Customize
[5]. Quit"
read -n1 -p "Please enter the number [1-5]:" num
case "$num" in
1)
    echo -e " \n "
    echo -e "★★★ 1#ADV Drive ★★★"
    myid="$jav_id"
    ;;
2)
    echo -e " \n "
    echo -e "★★★ 2#MDV Drive ★★★"
    myid="$mdv_id"
    ;;
3)
    echo -e " \n "
    echo -e "★★★ 3#BOOK Drive ★★★"
    myid="$book_id"
    ;;
4)
    read -p "Please enter the drive ID to be backed up==>" myid
    if [ -z "$myid" ] ; then
    echo "No input is allowed" && exit
    else
    myid=${myid#*id=};myid=${myid#*folders/};myid=${myid#*d/};myid=${myid%?usp*}
    fi
    ;;
5)
    exit
    ;;
*)
    echo -e " \n "
    echo -e "Please enter the correct number"
    ;;
esac
read -p "Please enter the specified backup driveID==>" link
if [ -z "$link" ] ; then
    echo "No input is allowed" && exit
else
link=${link#*id=};link=${link#*folders/};link=${link#*d/};link=${link%?usp*}
fi
sed -i "s/${fb_link1}/${myid}/g" /root/fclone_shell_bot/myfc_config.ini
sed -i "s/${fb_link2}/${link}/g" /root/fclone_shell_bot/myfc_config.ini
echo -e "/nThis mode does not support queue tasks, only background tasks"
tmux new -s fbtask -d
tmux send -t "fbtask" '~/gclone_shell_bot/script/fbcopy.sh' Enter
echo -e "/nBackground task has started"
exit
