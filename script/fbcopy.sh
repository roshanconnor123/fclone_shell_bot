#!/bin/bash
#=============================================================
# https://github.com/roshanconnor123/fclone_shell_bot
# File Name: fbcopy.sh
# Author: cgking
# Created Time : 2020.7.8
# Description:Full drive backup-copy
# System Required: Debian/Ubuntu
# Version: final
#=============================================================

echo "Wait for ini configuration variable update"
sleep 30s
source ~/fclone_shell_bot/myfc_config.ini
clear
echo -e "▣▣▣▣▣▣Perform copy▣▣▣▣▣▣"
fclone copy "$fclone_name":{$fb_link1} "$fclone_name":{$fb_link2} --drive-server-side-across-configs --stats=1s --stats-one-line -vP --checkers="$fb_chercker" --transfers="$fb_transfer" --drive-pacer-min-sleep="$fb_min_sleep"ms --drive-pacer-burst="$fb_BURST" --min-size "$fb_min_size"M --check-first
echo "|▉▉▉▉▉▉▉▉▉▉▉▉|100%  Completed/n"
echo -e "▣▣▣▣▣▣Perform Sync▣▣▣▣▣▣"
fclone sync "$fclone_name":{$fb_link1} "$fclone_name":{$fb_link2} --drive-server-side-across-configs --drive-use-trash=false --stats=1s --stats-one-line -vP --checkers="$fb_chercker" --transfers="$fb_transfer" --drive-pacer-min-sleep="$fb_min_sleep"ms --drive-pacer-burst="$fb_BURST" --min-size "$fb_min_size"M --check-first
echo "|▉▉▉▉▉▉▉▉▉▉▉▉|100%  Completed/n"
exit
