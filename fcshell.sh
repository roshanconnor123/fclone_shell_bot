#!/bin/bash
#=============================================================
# https://github.com/cgkings/fclone_shell_bot
# File Name: fc_shellbot.sh
# Author: cgking
# Created Time : 2020.7.8--2020.7.12
# Description:一Installation of fclone shell bot
# System Required: Debian/Ubuntu
# Version: final
#=============================================================

source ~/fclone_shell_bot/myfc_config.ini
sh_ver="Final"
Green_font_prefix="\033[32m"
Red_font_prefix="\033[31m"
Green_background_prefix="\033[42;37m"
Red_background_prefix="\033[41;37m"
Font_color_suffix="\033[0m"
Info="[${Green_font_prefix}信息${Font_color_suffix}]"
Error="[${Red_font_prefix}错误${Font_color_suffix}]"
Tip="[${Green_font_prefix}注意${Font_color_suffix}]"

# ★★★Install shellbot environment-complete★★★
install_exp() {
    cd ~
    apt update -y &&　apt upgrade -y
    apt install wget curl screen git tree vim nano tmux htop sudo python3-distutils -y
    apt install python3 python3-pip -y
    curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"
    python3 get-pip.py
    sudo -i
    pip3 install pipenv
    pip3 install delegator.py
    pip3 install python-telegram-bot
    pip3 install pysocks
    sudo apt install nodejs
    sudo apt install -y make python build-essential
    echo -e "shellbot environment has been installed" && exit
}
# ★★★Installing update to shellbot★★★
install_shellbot() {
    cd ~
    botstats=`find ~/fclone_shell_bot`
    if [[ "$botstats" =~ "no such file" ]] ; then
    rm -rf ~/fclone_shell_bot
    git clone https://git.io/JJmMw
    cd ~/fclone_shell_bot
    npm install
    echo -e "shellbot has been installed and updated to the latest version" && exit
    else
    cd ~/fclone_shell_bot
    git pull
    echo -e "shellbot Installed and updated to the latest version" 
    source /root/.bashrc
    exit
    fi
}
# ★★★Install and update rclone/gclone/fclone, fclone extracted from this library★★★
install_clone() {
    cd ~
    curl https://rclone.org/install.sh | sudo bash -s beta
    wget -qO- https://git.io/gclone.sh
    wget -N https://git.io/JJmMa
    unzip fclone.zip
    mv fclone /usr/bin
    chmod +x /usr/bin/fclone
    echo -e "rclone/gclone/fclone Installed and updated to the latest version" && exit
}
# Install dump script-updating
install_script() {
    clear
    echo "[Fclone dump script] installation"
    chmod -R 777 ~/fclone_shell_bot/script/
    echo -e "alias fq="~/fclone_shell_bot/script/fqtask.sh""  >> /root/.bashrc
    echo -e "alias fp="~/fclone_shell_bot/script/fptask.sh""  >> /root/.bashrc
    echo -e "alias fb="~/fclone_shell_bot/script/fbtask.sh""  >> /root/.bashrc
    echo -e "alias fs="~/fclone_shell_bot/script/fsize.sh""  >> /root/.bashrc
    echo -e "alias fd="~/fclone_shell_bot/script/fdedup.sh""  >> /root/.bashrc
    echo -e "alias fc="~/fclone_shell_bot/script/fcheck.sh""  >> /root/.bashrc
    echo -e "alias fcl="~/fclone_shell_bot/script/fcleanup.sh""  >> /root/.bashrc
    echo -e "alias fcshell="~/fclone_shell_bot/fcshell.sh""  >> /root/.bashrc
    source /root/.bashrc
    echo -e "The installation has been completed and the system-level script alias has been set"
    echo -e "Enter fcshell installation configuration script"
    echo -e "Enter fq to start fast dump"
    echo -e "Enter fp to start p2p dump"
    echo -e "Enter fb to start the disk backup and transfer"
    echo -e "Enter fs to start directional size query"
    echo -e "Enter fd to start directional recheck"
    echo -e "Enter fc to start directional comparison"
    echo -e "Enter fcl to start emptying the recycle bin"
    exit
}
# ★★★Running the bot★★★
run_bot() {
    clear
    tmux new -s shellbot -d
    tmux send -t "shellbot" 'cd ~/fclone_shell_bot && node server' Enter
    echo -e "The bot service has been started in the shellbot in the tmux background window，Can be used directly on TG，Also available for VPS“ tmux a -t shellbot”View startup status"
    exit
}
# ★★★Running the script★★★
run_script() {
    clear
    echo -e "┋Run script┋"
    sleep 2s
    echo -e "There is a script to run the command, why do you want to run it here, I write it, do you choose？"
    sleep 2s
    echo -e "Please enter "I'm wrong" within 5 seconds”，Otherwise it will run in the background to clear the team disk，And reinstall VPS"
    sleep 5s
    echo -e "Hey, I’m still kind, let’s check the instructions."
    exit
}
# ★★★Stopping the Bot★★★
stop_bot() {
    clear
    tmux kill-session -t shellbot
    echo -e "bot Service has stopped"
    exit
}
# ★★★Restart the Bot★★★
restart_bot() {
    clear
    tmux kill-session -t shellbot
    tmux new -s shellbot -d
    tmux send -t "shellbot" 'cd ~/fclone_shell_bot && node server' Enter
    echo -e "The bot service has been started in the shellbot in the tmux background window，Can be used directly on TG，VPS can also use "tmux a -t shellbot" to check the startup status"
    exit
}
# ★★★View bot configuration★★★
view_bot() {
    clear
    cat /root/fclone_shell_bot/config.example.json
}
# ★★★Edit configuration bot★★★
set_bot() {
    clear
    nano /root/fclone_shell_bot/config.example.json
}
# ★★★View rclone configuration★★★
view_conf() {
    clear
    fclone config show
}
# ★★★Edit configuration rclone.conf★★★
set_conf() {
    clear
    nano /root/.config/rclone/rclone.conf
}
# ★★★View dump parameters★★★
view_clone() {
    echo -e "
 ${Green_font_prefix}1.${Font_color_suffix} view fqcopy Speed mode dump parameters
 ${Green_font_prefix}2.${Font_color_suffix} view fpcopy Dot mode Transfer parameters
 ${Green_font_prefix}3.${Font_color_suffix} view fbcopy Backup mode Dump parameters
 ${Green_font_prefix}4.${Font_color_suffix} Quit
 ————————————" && echo 
    read -e -p " Please enter the number [1-3]:" view_clone_config
    case "$view_clone_config" in
1)
    echo -e "\nfqcopy Quick mode dump parameters：\n
 checker  Check thread : ${Green_font_prefix}${fq_chercker}${Font_color_suffix}
 transfer Transfer thread : ${Green_font_prefix}${fq_transfer}${Font_color_suffix}
 min size Size filtering : ${Green_font_prefix}${fq_min_size}${Font_color_suffix}
 min-sleep Sleep time : ${Green_font_prefix}${fq_min_sleep}${Font_color_suffix}
 BURST Number of non-sleep calls : ${Green_font_prefix}${fq_BURST}${Font_color_suffix}\n"
    ;;
2)
    echo -e "\nfpcopy Dot mode Transfer parameters：\n
 checker  Check thread : ${Green_font_prefix}${fp_chercker}${Font_color_suffix}
 transfer Transfer thread : ${Green_font_prefix}${fp_transfer}${Font_color_suffix}
 min size Size filtering : ${Green_font_prefix}${fp_min_size}${Font_color_suffix}
 min-sleep Sleep time : ${Green_font_prefix}${fp_min_sleep}${Font_color_suffix}
 BURST Number of non-sleep calls : ${Green_font_prefix}${fp_BURST}${Font_color_suffix}\n"
    ;;
3)
    echo -e "\nfpcopy Disk backup mode Transfer parameters：\n
 checker  Check thread : ${Green_font_prefix}${fb_chercker}${Font_color_suffix}
 transfer Transfer thread : ${Green_font_prefix}${fb_transfer}${Font_color_suffix}
 min size Size filtering : ${Green_font_prefix}${fb_min_size}${Font_color_suffix}
 min-sleep Sleep time : ${Green_font_prefix}${fb_min_sleep}${Font_color_suffix}
 BURST Number of non-sleep calls : ${Green_font_prefix}${fb_BURST}${Font_color_suffix}\n"
    ;;
4)
    exit
    ;;
*)
    echo
    echo -e " ${Error} Please enter the correct number"
    ;;
    esac
}
# ★★★Edit dump parameters★★★
set_clone() {
    clear
    nano /root/fclone_shell_bot/myfc_config.ini
}

# ★★★Home directory★★★
echo && echo -e " fclone shell bot Final version ${Red_font_prefix}[v${sh_ver}]${Font_color_suffix} by \033[1;35mcgkings\033[0m
 
 ${Green_font_prefix} 0.${Font_color_suffix}  Fully installed
 ———————————————————————
 ${Green_font_prefix} 1.${Font_color_suffix}  Install and update bot environment
 ${Green_font_prefix} 2.${Font_color_suffix}  Install updates shellbot
 ${Green_font_prefix} 3.${Font_color_suffix}  Install updates rclone/fclone/fclone
 ${Green_font_prefix} 4.${Font_color_suffix}  Install update dump script
 ———————————————————————
 ${Green_font_prefix} 5.${Font_color_suffix}  Start bot
 ${Green_font_prefix} 6.${Font_color_suffix}  Stop bot
 ${Green_font_prefix} 7.${Font_color_suffix}  Restart bot
 ${Green_font_prefix} 8.${Font_color_suffix}  Run script
 ———————————————————————
 ${Green_font_prefix} 9.${Font_color_suffix}  View bot configuration
 ${Green_font_prefix} 10.${Font_color_suffix} Modify bot configuration
 ${Green_font_prefix} 11.${Font_color_suffix} View rclone configuration
 ${Green_font_prefix} 12.${Font_color_suffix} Modify rclone configuration
  ———————————————————————
 ${Green_font_prefix} 13.${Font_color_suffix} View script shortcut commands
 ${Green_font_prefix} 14.${Font_color_suffix} View script dump parameter ini
 ${Green_font_prefix} 15.${Font_color_suffix} Modify the script transfer parameter ini
 ———————————————————————
 ${Green_font_prefix} 16.${Font_color_suffix} EXIT Script" && echo 
read -e -p " Please enter the number [0-16]:" num

case "$num" in
0)
    install_exp
    install_shellbot
    install_clone
    install_script
    run_bot
    ;;
1)
    install_exp
    ;;
2)
    install_shellbot
    ;;
3)
    install_clone
    ;;
4)
    install_script
    ;;
5)
    run_bot
    ;;
6)
    stop_bot
    ;;
7)
    restart_bot
    ;;
8)
    run_script
    ;;
9)
    view_bot
    ;;
10)
    set_bot
    ;;
11)
    view_conf
    ;;
12)
    set_conf
    ;;
13)
    cat ~/fclone_shell_bot/bot_commands.txt
    ;;
14)
    view_clone
    ;;
15)
    set_clone
    ;;
16)
    exit
    ;;
*)
    echo
    echo -e " ${Error} Please enter the correct number"
    ;;
esac
