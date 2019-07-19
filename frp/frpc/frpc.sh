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
workC=./web.ini
#workS=./server.ini
workDir=./

start_frpc() {
    if pgrep -f frpc >/dev/null 2>&1; then
        echo "frpc 服务已停止"
        ./frpc -c $workC &
    else
        echo "frpc 服务正在运行"
    fi
}
#检查 frpc 状态
check_frpc(){
    if  pgrep -f frpc >/dev/null 2>&1; then
            echo "frpc 开启失败"
        else
            echo "frpc 开启成功"
        fi
}
stop_frpc() {
    if pgrep -f frpc >/dev/null 2>&1; then
        echo -e "frpc 未关闭，正在关闭....."
        kill  $pidc
    else
        echo -e "frpc 未开启，无需关闭"
    fi
}
echo "====================="
echo "["$(date +%Y-%m-%d--%H:%M:%S)"]开始执行"

if [ $1 ];then
 workDir=$1
fi
if [ $1 ];then
 workC=$2
fi
if [ $1 -z "stop"] > /dev/null 2>&1;then 
stop_frpc
exit 0;
fi

cd $workDir
start_frpc
check_frpc

echo "============================================="
