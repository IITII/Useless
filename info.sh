#!/bin/bash
############################################
#  Author: IITII
#  Github: github.com/iitii
#  create: Fri Aug  9 11:45:30 CST 2019
#  Version: 1.0.0
#  @Todo
#   1. 自动获取网卡接口信息，打印出所有网卡的流量信息
############################################

# Check if user is root
[ $(id -u) != "0" ] && {
    echo "${CFAILURE}Error: You must be root to run this script${CEND}"
    exit 1
}

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

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
SKYBLUE='\033[0;36m'
PLAIN='\033[0m'

rm -rf /tmp/report && mkdir /tmp/report

#echo "正在安装必要的依赖，请耐心等待..."

# Install Virt-what
if [ ! -e '/usr/sbin/virt-what' ]; then
    #    echo "Installing Virt-What......"
    if [ "${release}" == "centos" ]; then
        yum -y install virt-what >/dev/null 2>&1
    else
        apt-get update >/dev/null 2>&1
        apt-get -y install virt-what >/dev/null 2>&1
    fi
fi

# Install uuid
#echo "Installing uuid......"
if [ "${release}" == "centos" ]; then
    yum -y install uuid >/dev/null 2>&1
else
    apt-get -y install uuid >/dev/null 2>&1
fi

# Install curl
#echo "Installing curl......"
if [ "${release}" == "centos" ]; then
    yum -y install curl >/dev/null 2>&1
else
    apt-get -y install curl >/dev/null 2>&1
fi

get_opsy() {
    [ -f /etc/redhat-release ] && awk '{print ($1,$3~/^[0-9]/?$3:$4)}' /etc/redhat-release && return
    [ -f /etc/os-release ] && awk -F'[= "]' '/PRETTY_NAME/{print $3,$4,$5}' /etc/os-release && return
    [ -f /etc/lsb-release ] && awk -F'[="]+' '/DESCRIPTION/{print $2}' /etc/lsb-release && return
}

next() {
    printf "%-74s\n" "-" | sed 's/\s/-/g'
}

calc_disk() {
    local total_size=0
    local array=$@
    for size in ${array[@]}; do
        [ "${size}" == "0" ] && size_t=0 || size_t=$(echo ${size:0:${#size}-1})
        [ "$(echo ${size:(-1)})" == "K" ] && size=0
        [ "$(echo ${size:(-1)})" == "M" ] && size=$(awk 'BEGIN{printf "%.1f", '$size_t' / 1024}')
        [ "$(echo ${size:(-1)})" == "T" ] && size=$(awk 'BEGIN{printf "%.1f", '$size_t' * 1024}')
        [ "$(echo ${size:(-1)})" == "G" ] && size=${size_t}
        total_size=$(awk 'BEGIN{printf "%.1f", '$total_size' + '$size'}')
    done
    echo ${total_size}
}

cname=$(awk -F: '/model name/ {name=$2} END {print name}' /proc/cpuinfo | sed 's/^[ \t]*//;s/[ \t]*$//')
cores=$(awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo)
freq=$(awk -F: '/cpu MHz/ {freq=$2} END {print freq}' /proc/cpuinfo | sed 's/^[ \t]*//;s/[ \t]*$//')
tram=$(free -m | awk '/Mem/ {print $2}')
uram=$(free -m | awk '/Mem/ {print $3}')
swap=$(free -m | awk '/Swap/ {print $2}')
uswap=$(free -m | awk '/Swap/ {print $3}')
up=$(awk '{a=$1/86400;b=($1%86400)/3600;c=($1%3600)/60} {printf("%d days, %d hour %d min\n",a,b,c)}' /proc/uptime)
load=$(w | head -1 | awk -F'load average:' '{print $2}' | sed 's/^[ \t]*//;s/[ \t]*$//')
opsy=$(get_opsy)
arch=$(uname -m)
lbit=$(getconf LONG_BIT)
kern=$(uname -r)
ipv6=$(wget -qO- -t1 -T2 ipv6.icanhazip.com)
disk_size1=($(LANG=C df -hPl | grep -wvE '\-|none|tmpfs|devtmpfs|by-uuid|chroot|Filesystem' | awk '{print $2}'))
disk_size2=($(LANG=C df -hPl | grep -wvE '\-|none|tmpfs|devtmpfs|by-uuid|chroot|Filesystem' | awk '{print $3}'))
disk_total_size=$(calc_disk ${disk_size1[@]})
disk_used_size=$(calc_disk ${disk_size2[@]})
#RX_eth=`ifconfig | grep packets | sed -n '1,1p' | sed 's/(//g' | sed 's/)//g' | awk '{printf $1 " " $(NF-1) $NF " "}' | sed 's/RX/下行流量(RX)/g' |  sed 's/TX/上行流量(TX)/g'`
#TX_eth=`ifconfig | grep packets | sed -n '2,2p' | sed 's/(//g' | sed 's/)//g' | awk '{printf $1 " " $(NF-1) $NF " "}' | sed 's/RX/下行流量(RX)/g' |  sed 's/TX/上行流量(TX)/g'`
RX_eth=$(ifconfig | grep packets | sed -n '1,1p' | sed 's/(//g' | sed 's/)//g' | awk '{printf $(NF-1) $NF}' | sed 's/RX/下行流量(RX)/g')
TX_eth=$(ifconfig | grep packets | sed -n '2,2p' | sed 's/(//g' | sed 's/)//g' | awk '{printf $(NF-1) $NF}' | sed 's/TX/上行流量(TX)/g')
#服务器型号
server_type=$(dmidecode -s system-product-name)
#内存插条数，已使用插槽数，及每条内存大小
#mem_detail=`dmidecode|grep -P -A5 "Memory\s+Device" | grep Size |grep -v Range | cat -n`
#内存的频率
#mem_speed=`dmidecode|grep -A16 "Memory Device"|grep 'Speed' | cat -n`
crontab_l=$(crontab -l)
#clear
echo -e "当前时间            :$(date)"
curl myip.ipip.net
echo -e "上行流量             : ${SKYBLUE}$TX_eth${PLAIN}"
echo -e "下行流量             : ${SKYBLUE}$RX_eth${PLAIN}"
echo -e "当前开放的服务端口: ${SKYBLUE}$(netstat -ntlp)${PLAIN}"
echo -e "当前用户的计划任务:\n${SKYBLUE}$crontab_l${PLAIN}"
echo -e "总硬盘大小           : ${SKYBLUE}$disk_total_size GB ($disk_used_size GB Used)${PLAIN}"
echo -e "服务器型号           : ${SKYBLUE}$server_type${PLAIN}"
#echo -e "内存插条数，已使用插槽数，及每条内存大小: ${SKYBLUE}$mem_detail${PLAIN}"
#echo -e "内存频率               : ${SKYBLUE}$mem_speed${PLAIN}"
echo -e "CPU 型号             : ${SKYBLUE}$cname${PLAIN}"
echo -e "CPU 核心数           : ${SKYBLUE}$cores${PLAIN}"
echo -e "CPU 频率             : ${SKYBLUE}$freq MHz${PLAIN}"
echo -e "总内存大小           : ${SKYBLUE}$tram MB ($uram MB Used)${PLAIN}"
#echo -e ""
echo -e "SWAP大小             : ${SKYBLUE}$swap MB ($uswap MB Used)${PLAIN}"
echo -e "开机时长             : ${SKYBLUE}$up${PLAIN}"
echo -e "系统负载             : ${SKYBLUE}$load${PLAIN}"
echo -e "系统                 : ${SKYBLUE}$opsy${PLAIN}"
echo -e "架构                 : ${SKYBLUE}$arch ($lbit Bit)${PLAIN}"
echo -e "内核                 : ${SKYBLUE}$kern${PLAIN}"
echo -ne "虚拟化平台           : "
virtua=$(virt-what) 2>/dev/null
if [[ ${virtua} ]]; then
    echo -e "${SKYBLUE}$virtua${PLAIN}"
else
    echo -e "${SKYBLUE}No Virt${PLAIN}"
fi
