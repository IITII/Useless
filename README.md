# Some  Script
> This repo is create for storing some useful script  
>> `(￣▽￣)～■干杯□～(￣▽￣)`
----
**Contents**
----
* [***Shell脚本***](#shell脚本)

  * [quick-set.sh](#quick-setsh)
  
  * [AutoFormat.sh](#AutoFormatsh)
  
  * [clean.sh](#cleansh)

  * [update-ssr.sh](#update-ssrsh)
  
  * [Format.sh](#Formatsh)

  * [FFmpeg.sh](#FFmpegsh)
  * [psi4_Simple.sh](#psi4Simplesh)
  * [Ssh-Login-Notify](#sshloginnotifysh)
  * [info.sh](#infosh)
  * [sysInfo_notify.sh](#sysinfonotifysh)
  * [diamond.sh](#diamondsh)
  * [autossh.sh](#autosshsh)
  
* [***配置文件***](#配置文件)

  * [V2ray配置文件](#V2ray-configconf)
  
  * [Aria2配置文件](#aria2conf)
* [others](./doubi/README.md)
----
## shell脚本
----
### quick-set.sh
> 为了我在删库后快速重建环境, 默认注释掉了一些配置文件，可根据需要启用
* 食用方法：
  ```bash
  wget -N --no-check-certificate https://raw.githubusercontent.com/IITII/Useless/master/quick-set.sh && chmod +x quick-set.sh && bash quick-set.sh
  ```

### AutoFormat.sh
> Aria2自动转码脚本（开发ing）
> 重定向至[Format.sh](#Formatsh)
* 食用方法：
  ```bash
  wget -N --no-check-certificate https://raw.githubusercontent.com/IITII/Useless/master/AutoFormat.sh && chmod +x AutoFormat.sh && bash AutoFormat.sh
  ```

### clean.sh
> 简单释放一下系统空间
* 食用方法：
  ```bash
  wget -N --no-check-certificate https://raw.githubusercontent.com/IITII/Useless/master/clean.sh && chmod +x clean.sh && bash clean.sh
  ```

### update-ssr.sh
> 自动检测并更新electron-ssr版本
* 食用方法：
  ```bash
  wget -N --no-check-certificate https://raw.githubusercontent.com/IITII/Useless/master/update-ssr.sh && chmod +x update-ssr.sh && bash update-ssr.sh
  ```

### Format.sh
> Aria2下载的视频文件自动转码脚本，默认转成**MP4**格式（v1.0.0）  
> 注意事项：目前只能同时处理一个下载文件，也就是说每次只能同时下载一个文件，否则就会混掉  
> aria2需要进行配置才能食用本脚本  
> 如果不清楚的话，请不要修改脚本名称，后果自负
> 也可以直接下载我的配置文件：[aria2.conf](#aria2conf)
* 配置过程: 
  ```bash
    wget -N --no-check-certificate https://raw.githubusercontent.com/IITII/Useless/master/Format.sh
    echo "on-download-complete=bash ~/Format.sh" >> ~/.aria2/aria2.conf
    echo "#force-save=true" >> ~/.aria2/aria2.conf
  ```
### FFmpeg.sh
> 一个基于FFmpeg可以进行媒体文件转码的简易工具  
> 支持命令行选项  
* 获取方法：
  ```bash
  wget -N --no-check-certificate https://raw.githubusercontent.com/IITII/Useless/master/ffmpeg.sh
  ```
* 食用方法：
  ```bash
  $ ./ffmpeg.sh -h
  -h: To show this menu
  -e: Show Some Useful Templates
  -m [1-9]: To switch mode
                -m 1: 获取aac音频文件
                -m 2: 获取mp3文件
                -m 3: 获取H.264视频流文件(.mp4文件)
                -m 4: 整合mp4文件和mp4文件
                -m 5: .整合mp4和mp3文件
                -m 6: 整合mp4和aac文件
                -m 7: 添加srt字幕
                -m 8: srt字幕转ass
                -m 9: 添加ass字幕
  $ ./ffmpeg.sh -e
  ./ffmpeg.sh -m 1 input.mp4 output.aac
  ./ffmpeg.sh -m 2 input.mp4 output.mp3
  ./ffmpeg.sh -m 3 input.mp4 output.mp4
  ./ffmpeg.sh -m 4 input_audio.mp4 input_video.mp4 output.mp4
  ./ffmpeg.sh -m 5 input.mp3 input.mp4 output.mp4
  ./ffmpeg.sh -m 6 input.aac input.mp4 output.mp4
  ./ffmpeg.sh -m 7 input.mp4 input.srt output.mp4
  ./ffmpeg.sh -m 8 input.srt output.ass
  ./ffmpeg.sh -m 9 input.mp4 input.ass output.mp4
  $ ./ffmpeg.sh
  请选择你要选择的操作的序号：

  * 所有文件名请完整输入文件名称，包括后缀名！

  1.获取aac音频文件
  2.获取mp3文件
  3.获取H.264视频流文件(.mp4文件)
  4.整合mp4文件和mp4文件
  5.整合mp4和mp3文件
  6.整合mp4和aac文件
  7.添加srt字幕
  8.srt字幕转ass
  9.添加ass字幕
  ```
### psi4_Simple.sh
> 一个简单安装 `psi4` 的脚本

```
wget -N --no-check-certificate https://raw.githubusercontent.com/IITII/Useless/master/psi4_Simple.sh && chmod +x psi4_Simple.sh
```

### ssh_login_notify.sh
> 基于 **slack api** 的一个 **ssh** 登录通知服务  
- 先决条件: 已创建 ***slack app*** 并且开启了 WebHook
* 使用：  

  ```bash 
  wget -N --no-check-certificate https://raw.githubusercontent.com/IITII/Useless/master/ssh_login_notify.sh && chmod +x ssh_login_notify.sh
  ```
* 说明：

  ```
  root# ./ssh_login_notify.sh -h
  Usage: ./ssh_login_notify.sh -u URL
  使用本脚本来创建一个基于 slack app 的 ssh 登录通知服务
  -h: get help. Show This message
  -e: Show some examples
  -u: Add webhooks

  root# ./ssh_login_notify.sh -e
  Some examples:
  ./ssh_login_notify.sh -h
  ./ssh_login_notify.sh -e
  ./ssh_login_notify.sh -u https://api.google.com
  ```

### info.sh
* 使用：  

  ```bash 
  wget -N --no-check-certificate https://raw.githubusercontent.com/IITII/Useless/master/info.sh && chmod +x info.sh
  ```
> ***Help***
```
root@server1804$: ./info.sh -h
Usage:
      -h: To show this menu
      -s: Some simple infomation of server
      -n [n:c]: Detail for server
              -n n: Detail for server
              -n c: Detail for server & Add color
      -f [n:c]: Full information of server
              -f n: Full information of server
              -f c: Full information of server & Add color
      -t [e:z]: Run Test For Server
              -t e: Run Test & Set Language = English
              -t z: Run Test & Set Language = Simple Chinese
```

> 打印一些系统信息，如：  

```
当前时间            :Fri Aug  9 19:48:56 CST 2019
当前 IP：**.**.**.**  来自于：中国 ** **  **
上行流量             : 4.3MB
下行流量             : 6.5MB
当前开放的服务端口: Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
tcp        0      0 127.0.0.53:53           0.0.0.0:*               LISTEN      998/systemd-resolve
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      1195/sshd
tcp        0      0 0.0.0.0:25              0.0.0.0:*               LISTEN      35145/master
tcp        0      0 0.0.0.0:445             0.0.0.0:*               LISTEN      1389/smbd
tcp        0      0 0.0.0.0:139             0.0.0.0:*               LISTEN      1389/smbd
tcp6       0      0 :::22                   :::*                    LISTEN      1195/sshd
tcp6       0      0 :::25                   :::*                    LISTEN      35145/master
tcp6       0      0 :::1433                 :::*                    LISTEN      7328/docker-proxy
tcp6       0      0 :::445                  :::*                    LISTEN      1389/smbd
tcp6       0      0 :::139                  :::*                    LISTEN      1389/smbd
当前用户的计划任务:

总硬盘大小           : 12.1 GB (5.8 GB Used)
服务器型号           : VMware Virtual Platform
CPU 型号             : Intel(R) Core(TM) i5-7300HQ CPU @ 2.50GHz
CPU 核心数           : 2
CPU 频率             : 2495.999 MHz
总内存大小           : 1970 MB (1255 MB Used)
SWAP大小             : 0 MB (0 MB Used)
开机时长             : 1 days, 13 hour 50 min
系统负载             : 0.07, 0.05, 0.01
系统                 : Ubuntu 18.04.3 LTS
架构                 : x86_64 (64 Bit)
内核                 : 4.15.0-55-generic
虚拟化平台           : vmware
```

### sysInfo_notify.sh
> 工作原理和实现方式和 [ssh_login_notify.sh](#sshloginnotifysh) 一样  

* 使用：  

  ```bash 
  wget -N --no-check-certificate https://raw.githubusercontent.com/IITII/Useless/master/sysInfo_notify.sh && chmod +x sysInfo_notify.sh
  ```

### diamond.sh
> 打印一个菱形

* 使用：  

  ```bash 
  wget -N --no-check-certificate https://raw.githubusercontent.com/IITII/Useless/master/diamond.sh && chmod +x diamond.sh
  ```

* 效果：

```
root@server1804:~/dev# ./diamond.sh
    *
   ***
  *****
 *******
  *****
   ***
    *
root@server1804:~/dev#
```

### autossh.sh
> A simple shell script to update ssh config

* 使用：  

  ```bash 
  wget -N --no-check-certificate https://raw.githubusercontent.com/IITII/Useless/master/autossh.sh && chmod +x autossh.sh
  ```

----
## 配置文件
----
### V2ray-config.conf
> V2ray简单配置文件，内置ss + mtproxy
* 食用方法：
  ```bash
  #请提前将配置文件做好备份
  #防火墙需开放 55555（for ss）和 55557（for mtproxy）
  wget -N --no-check-certificate https://raw.githubusercontent.com/IITII/Useless/master/v2ray-config.json
  mv ./v2ray-config.json /etc/v2ray/config.json
  systemctl restart v2ray && systemctl status v2ray
  ```

### Aria2.conf
> Aria2 简单配置文件。~~搭配[Format.sh](#Formatsh)更香哦~~
* 食用方法:
    ```bash
    ##安装Aria2推荐 ToyoDAdoubiBackup 大佬的一键脚本
    ##==================================
    wget -N --no-check-certificate https://raw.githubusercontent.com/ToyoDAdoubiBackup/doubi/master/aria2.sh && chmod +x aria2.sh && bash aria2.sh
    ##==================================
    ##备份原来的配置文件并替换配置文件
    wget -N --no-check-certificate https://raw.githubusercontent.com/IITII/Useless/master/aria2.conf && chmod 666 aria2.conf && mv ~/.aria2/aria2.conf ~/.aria2/aria2.conf_back && mv aria2.conf ~/.aria2/aria2.conf
    ```
----------
>Contact me by  [Telegram](https://t.me/callmehelp).
>>o((⊙﹏⊙))o.
