#!/bin/bash
#=============================================================
# https://github.com/roshanconnor123/fclone_shell_bot
# File Name: fqcopy.sh
# Author: cgking
# Created Time : 2020.7.8
# Description:Extreme Edition-copy
# System Required: Debian/Ubuntu
# Version: final
#=============================================================

source ~/fclone_shell_bot/myfc_config.ini
clear
IFS=$'\n' 
for input_id in $(cat ~/fclone_shell_bot/log/fqtask.log)
do
    rootname=$(fclone lsd "$fclone_name":{$input_id} --dump bodies -vv 2>&1 | awk 'BEGIN{FS="\""}/^{"id/{print $8}')
    echo -e "┋New Folder Name┋:"$rootname"\n"
    echo -e "┋Folder ID┋:"$input_id"\n"
    echo -e "▣▣▣▣▣▣Perform Copy▣▣▣▣▣▣"
    fclone copy "$fclone_name":{$input_id} "$fclone_name":{$gd_id}/"$rootname" --drive-server-side-across-configs --stats=1s --stats-one-line -vP --checkers="$fq_chercker" --transfers="$fq_transfer" --drive-pacer-min-sleep="$fq_min_sleep"ms --drive-pacer-burst="$fq_BURST" --min-size "$fq_min_size"M --check-first
    echo "|▉▉▉▉▉▉▉▉▉▉▉▉|100%  Copy Done"
    echo -e "▣▣▣▣▣▣Filling in the gaps▣▣▣▣▣▣"
    fclone copy "$fclone_name":{$input_id} "$fclone_name":{$gd_id}/"$rootname" --drive-server-side-across-configs --stats=1s --stats-one-line -vP --checkers="$fq_chercker" --transfers="$fq_transfer" --drive-pacer-min-sleep="$fq_min_sleep"ms --drive-pacer-burst="$fq_BURST" --min-size "$fq_min_size"M --check-first
    echo "|▉▉▉▉▉▉▉▉▉▉▉▉|100%  Copy Done"
    clear
done
: > ~/fclone_shell_bot/log/fqtask.log
exit
