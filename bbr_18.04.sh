#!/usr/bin/env bash

# Warning: Only for Ubuntu18.04
# User: root
# require: Ubuntu18.04
# If not, please do as following
# git clone https://github.com/iitii/useless ~/useless && cd ~/useless && bash doubi/bbr.sh

if ! command -v virt-what >/dev/null 2>&1; then
    apt install virt-what -y >/dev/null 2>&1
fi
declare RELEASE_NAME="Ubuntu"
declare VERSION_ID="18"
declare VT="kvm"
declare _name=$(cat /usr/lib/os-release | grep ^NAME | sed 's/"/ /g' | awk '{print $2}')
declare _version=$(cat /usr/lib/os-release | grep VERSION_ID | sed 's/"/ /g' | sed 's/\./ /g' | awk '{print $2}')
declare _vt=$(virt-what)
check() {
    if ! [ $1 = $2 ]; then
        if [ -z $3 ]; then
            echo "[$(date)]: require $3 , exit"
        else
            echo "[$(date)]: require $1 , exit"
        fi
    fi
}
add() {
    echo "net.core.default_qdisc=fq" >>/etc/sysctl.conf
    echo "net.ipv4.tcp_congestion_control=bbr" >>/etc/sysctl.conf
    sysctl -p
}
del() {
    sed -i '/net\.core\.default_qdisc=fq/d' /etc/sysctl.conf
    sed -i '/net\.ipv4\.tcp_congestion_control=bbr/d' /etc/sysctl.conf
    sysctl -p
}
cat /etc/*rel*
check $VT $_vt
check $RELEASE_NAME $_name
check $VERSION_ID $_version "18.04 or later"
del && add
echo "[`date`]: lsmod | grep bbr -> `lsmod | grep bbr`"