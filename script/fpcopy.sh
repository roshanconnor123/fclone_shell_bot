#!/bin/bash
#=============================================================
# https://github.com/roshanconnor123/fclone_shell_bot
# File Name: fpcopy.sh
# Author: cgking
# Created Time : 2020.7.8
# Description:Point-to-point-copy
# System Required: Debian/Ubuntu
# Version: final
#=============================================================

echo "Wait for ini configuration variable update"
sleep 30s
source ~/fclone_shell_bot/myfc_config.ini
clear
echo -e "▣▣▣▣▣▣Perform Copy▣▣▣▣▣▣"
fclone copy "$fclone_name":{$fp_link1} "$fclone_name":{$fp_link2} --drive-server-side-across-configs --stats=1s --stats-one-line -vP --checkers="$fp_chercker" --transfers="$fp_transfer" --drive-pacer-min-sleep="$fp_min_sleep"ms --drive-pacer-burst="$fp_BURST" --min-size "$fp_min_size"M --check-first
echo "|▉▉▉▉▉▉▉▉▉▉▉▉|100%  Copy Done/n"
echo -e "▣▣▣▣▣▣Perform Copy▣▣▣▣▣▣"
fclone copy "$fclone_name":{$fp_link1} "$fclone_name":{$fp_link2} --drive-server-side-across-configs --stats=1s --stats-one-line -vP --checkers="$fp_chercker" --transfers="$fp_transfer" --drive-pacer-min-sleep="$fp_min_sleep"ms --drive-pacer-burst="$fp_BURST" --min-size "$fp_min_size"M --check-first
echo "|▉▉▉▉▉▉▉▉▉▉▉▉|100%  Copy Done/n"
exit
