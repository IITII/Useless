#!/usr/bin/env bash
###########################
# A simple script to rsync data from https://downloads.openwrt.org
# For personal use, I only sync OpenWrt 18.06.3 x86 (targets &  packages-18.06/x86)
# This is the rsync link: https://downloads.openwrt.org/releases/18.06.3/targets/x86/
# For other user, pick one rsync link by your mind
###########################

RSYNC="rsync"
RSYNC_ABS="/usr/bin/$RSYNC"
# rsync repo
RSYNC_Targets="rsync://downloads.openwrt.org/downloads/releases/18.06.3/targets/x86/"
RSYNC_Packages="rsync://downloads.openwrt.org/downloads/releases/packages-18.06/x86_64/"
# save dir
SAVE_DIR="/var/www/mirror/"
SAVE_Targets="releases/18.06.3/targets/x86/"
SAVE_Packages="releases/packages-18.06/x86_64/"

# Check if user is root
[ $(id -u) != "0" ] && {
    echo "${CFAILURE}Error: You must be root to run this script${CEND}"
    exit 1
}

declare release="ubuntu"
# Check release
if [ -f /etc/redhat-release ]; then
    release="centos"
elif cat /etc/issue | grep -Eqi "debian"; then
    release="debian"
elif cat /etc/issue | grep -Eqi "ubuntu"; then
    release="ubuntu"
elif cat /etc/issue | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
elif cat /proc/version | grep -Eqi "debian"; then
    release="debian"
elif cat /proc/version | grep -Eqi "ubuntu"; then
    release="ubuntu"
elif cat /proc/version | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
fi

# check rsync command
# If don't have it, print some infomation & auto install it from release repo
# else do nothing
if ! command -v $RSYNC >/dev/null 2>&1; then
    echo "Installing $RSYNC from $release repo"
    if [ "${release}" == "centos" ]; then
        sudo yum update
        sudo yum -y install $RSYNC >/dev/null 2>&1
    else
        sudo apt-get update >/dev/null 2>&1
        sudo apt-get install $RSYNC -y >/dev/null 2>&1
    fi
fi

# sync mirror data
# $1 for data URL
# $2 for save dir
sync_data() {
    $RSYNC_ABS -avz --delete --partial --progress $1 $2
}

# check path is exist
# if not, create it

if ! [ -d $SAVE_DIR ]; then
    mkdir -p $SAVE_DIR
fi
if ! [ -d $SAVE_DIR$SAVE_Targets ]; then
    mkdir -p $SAVE_DIR$SAVE_Targets
fi
if ! [ -d $SAVE_DIR$SAVE_Packages ]; then
    mkdir -p $SAVE_DIR$SAVE_Packages
fi

echo "Rsyncing"
# sync

# Targerts
sync_data $RSYNC_Targets $SAVE_DIR$SAVE_Targets

# Packages
sync_data $RSYNC_Packages $SAVE_DIR$SAVE_Packages