#!/usr/bin/env bash
#=================================================
#	Recommend OS: Debian/Ubuntu
#   Update：2019年 08月 27日 08:10:48 CST
#   Create：2019年 08月 27日 08:10:48 CST
#	Version: 1.0.2
#	Author: IITII
#	Blog: https://IITII.github.io
#=================================================
# 0 */6 * * * curl https://raw.githubusercontent.com/IITII/Useless/master/autossh.sh | bash
mv /etc/ssh/sshd_config /etc/ssh/sshd_config.bk
mv /root/.ssh/authorized_keys /root/.ssh/authorized_keys.bk
wget -O /etc/ssh/sshd_config https://raw.githubusercontent.com/IITII/Useless/master/ssh/sshd_config
wget -O /root/.ssh/authorized_keys https://raw.githubusercontent.com/IITII/Useless/master/ssh/authorized_keys
service ssh restart && service sshd restart