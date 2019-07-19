#!/bin/bash
######################
#   Author： IITII
#   Date： Fri Jul 19 12:33:57 CST 2019
######################
cmd_intface() {
    echo -e "请输入 Slack App 的 IncomeWebhook： \n"
    read i
    if ! command -v git >/dev/null 2>&1; then
        sudo apt-get update
        sudo apt-get install git -y
    fi
    git clone https://github.com/GoogleCloudPlatform/slack-samples.git
    cd slack-samples/notify
    echo "$i" >slack-hook
}
get_help() {
    echo "Usage: ./ssh_login_notify.sh -u URL"
    echo "使用本脚本来创建一个基于 slack app 的 ssh 登录通知服务"
    echo "-h: get help. Show This message"
    echo "-e: Show some examples"
    echo "-u: Add webhooks"
}
get_example() {
    echo "Some examples:"
    echo "./ssh_login_notify.sh -h"
    echo "./ssh_login_notify.sh -e"
    echo "./ssh_login_notify.sh -u https://api.google.com"
}
common() {
    echo "Test Configure..."
    if (! PAM_USER=$USER PAM_RHOST=testhost ./login-notify.sh); then
        echo "Configure Error !"
        exit 1
    fi
    echo "UsePAM yes" >>/etc/ssh/sshd_config
    systemctl restart ssh && systemctl restart sshd
    ./install.sh
}
#若使用命令行传参直接跳过交互过程
if [ ! -n "$1" ]; then
    cmd_intface
    common
fi
while getopts "m:he" arg; do
    case $arg in
    u)
        shift
        if ! command -v git >/dev/null 2>&1; then
            sudo apt-get update
            sudo apt-get install git -y
        fi
        git clone https://github.com/GoogleCloudPlatform/slack-samples.git
        cd slack-samples/notify
        echo "$OPTARG" >slack-hook
        common
        ;;
    h)
        get_help
        ;;
    e)
        get_example
        ;;
    ?) #当有不认识的选项的时候arg为?
        echo "unkonw argument"
        exit 1
        ;;
    esac
done
