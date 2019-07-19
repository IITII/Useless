#!/bin/bash
#Date: Thu Feb  7 14:43:55 DST 2019
#Just for test

#Doubi scripts
# bbr
wget -N --no-check-certificate https://raw.githubusercontent.com/ToyoDAdoubiBackup/doubi/master/bbr.sh && chmod +x bbr.sh
#wget -N --no-check-certificate https://raw.githubusercontent.com/ToyoDAdoubiBackup/doubi/master/bbr.sh && chmod +x bbr.sh && bash bbr.sh
# aria2
wget -N --no-check-certificate https://raw.githubusercontent.com/ToyoDAdoubiBackup/doubi/master/aria2.sh && chmod +x aria2.sh 
#wget -N --no-check-certificate https://raw.githubusercontent.com/ToyoDAdoubiBackup/doubi/master/aria2.sh && chmod +x aria2.sh && bash aria2.sh
# Mtproxy
    #normal
    #wget -N --no-check-certificate https://raw.githubusercontent.com/ToyoDAdoubiBackup/doubi/master/mtproxy.sh && chmod +x mtproxy.sh 
    #wget -N --no-check-certificate https://raw.githubusercontent.com/ToyoDAdoubiBackup/doubi/master/mtproxy.sh && chmod +x mtproxy.sh && bash mtproxy.sh
    # base on GO
    #wget -N --no-check-certificate https://raw.githubusercontent.com/ToyoDAdoubiBackup/doubi/master/mtproxy_go.sh && chmod +x mtproxy_go.sh 
    #wget -N --no-check-certificate https://raw.githubusercontent.com/ToyoDAdoubiBackup/doubi/master/mtproxy_go.sh && chmod +x mtproxy_go.sh && bash mtproxy_go.sh
#server status
#wget -N --no-check-certificate https://raw.githubusercontent.com/ToyoDAdoubiBackup/doubi/master/status.sh && chmod +x status.sh
#wget -N --no-check-certificate https://raw.githubusercontent.com/ToyoDAdoubiBackup/doubi/master/status.sh && chmod +x status.sh && bash status.sh

#bt panle
wget -O install.sh http://download.bt.cn/install/install-ubuntu_6.0.sh 

#wget -O install.sh http://download.bt.cn/install/install-ubuntu_6.0.sh && sudo bash install.sh
# V2ray(MTproxy supported)

#offical
bash <(curl -L -s https://install.direct/go.sh)

#Jrohy/multi-v2ray
# via pip install
#pip install v2ray-util
# via curl rawgithub
    #install
    #source <(curl -sL https://git.io/fNgqx)
    #upgrade(keep your config files)
    #source <(curl -sL https://git.io/fNgqx) -k
    #uninstall 
    #source <(curl -sL https://git.io/fNgqx) --remove

# Zench
# Chinese Version
wget -N --no-check-certificate https://raw.githubusercontent.com/FunctionClub/ZBench/master/ZBench-CN.sh
#wget -N --no-check-certificate https://raw.githubusercontent.com/FunctionClub/ZBench/master/ZBench-CN.sh && bash ZBench-CN.sh

# English Version
#wget -N --no-check-certificate https://raw.githubusercontent.com/FunctionClub/ZBench/master/ZBench.sh 
#wget -N --no-check-certificate https://raw.githubusercontent.com/FunctionClub/ZBench/master/ZBench.sh && bash ZBench.sh

# gotop
git clone --depth 1 https://github.com/cjbassi/gotop /tmp/gotop
. /tmp/gotop/scripts/download.sh
mv ./gotop /usr/local/bin

