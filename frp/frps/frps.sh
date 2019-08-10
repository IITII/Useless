#!/usr/bin/env bash

#=================================================
#	System Required: Ubuntu/Windows
#	Description: frp客户端守护进程
#	Version: 1.0.0
#	Author: IITII
#	Blog: https://iitii.github.io
#=================================================

#ps -ef | grep "name" | grep -v grep | awk '{print $2}'
#ps -ef | awk '/[n]ame/{print $2}'
#如果只使用 x 参数的话则 pid 应该位于第一位：ps x | awk '/[n]ame/{print $1}'
#最简单的方法是使用 pgrep：pgrep -f name

pidc=`pgrep -f frpc`
pids=`pgrep -f frps`
#workC=./web.ini
workS=./server.ini
workDir=./

start_frps() {
     if pgrep -f frps >/dev/null 2>&1; then
        echo "frps 服务已停止"
        ./frps -c $workS &
    else
        echo "frps 服务正在运行"
    fi
}
check_frps(){
     if  pgrep -f frps >/dev/null 2>&1; then
            echo "frps 开启失败"
        else
            echo "frps 开启成功"
        fi
}
stop_frps() {
    if  pgrep -f frps >/dev/null 2>&1; then
        echo -e "frps 未关闭，正在关闭.....";
        kill  $pids;
        else
        echo -e "frps 未开启，无需关闭"
    fi
}
echo "====================="
echo "["$(date +%Y-%m-%d--%H:%M:%S)"]开始执行"

if [ $1 ];then
 workDir=$1
fi
if [ $1 ];then
 workS=$2
fi
if [ $1 -z "stop"] > /dev/null 2>&1;then 
stop_frps
exit 0;
fi

cd $workDir
start_frps
check_frps


echo "============================================="
