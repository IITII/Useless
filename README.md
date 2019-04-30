# Nothing
>Nothing
>>> `(￣▽￣)～■干杯□～(￣▽￣)`
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
  
* [***配置文件***](#配置文件)

  * [V2ray配置文件](#V2ray-configconf)
  
  * [Aria2配置文件](#aria2conf)
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

### 
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
