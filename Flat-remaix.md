- Ubuntu18.04配置flat-remiax
    1. __Author：luoping__
    2. __Date：2018年 09月 27日 星期四 00:12:55 CST__
    3. 校对时间:
         - `timedatectl set-local-rtc 1 --adjust-system-clock`
    4. ~~以下操作翻墙体验更好, 下载electron-ssr~~
         - `wget https://github.com/erguotou520/electron-ssr/releases/download/v0.2.4/electron-ssr_0.2.4_amd64.deb`
    5. 安装chrome:
         - `wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && sudo dpkg -i *.deb`
    6. 卸载firefox以及其他无用的链接方式:
         1. `sudo apt-get remove unity-webapps-common`
         2. `sudo apt-get remove firefox*`
         3. `sudo apt-get remove onboard deja-dup`
         4. `sudo apt-get remove gnome-mines cheese transmission-common gnome-orca webbrowser-app gnome-sudoku  landscape-client-ui-install`
         5. `sudo apt-get remove thunderbird totem rhythmbox empathy brasero simple-scan gnome-mahjongg aisleriot`
    7. 安装git等：
         - `sudo  apt install git vim curl tree glances ncdu mc openssh-server`
    8. 安装gnome-tweak-tool：
         - `sudo apt-get install gnome-tweak-tool`
    9. 打开软件商城 --> 附加组件 --> 安装：
         1. user themes
         2.  dash to dock
         3. Hide Top Bar
         4. weather in the clock
    10. 安装guake：
          - `sudo apt-get install guake`
    11. 安装配置oh-my-zsh：
          1. `sudo apt-get install zsh && sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"`
          2. 推荐theme：agnoster
          3. 字体乱码：`sudo apt install fonts-powerline`
          4. 更改默认shell：`chsh -s /bin/zsh`
    12. 安装flat-remix主题：
          1. `sudo add-apt-repository ppa:daniruiz/flat-remix&&sudo apt-get update&&sudo apt-get install flat-remix`
          2. `cd /tmp && rm -rf flat-remix-gnome-theme &&\ngit clone https://github.com/daniruiz/flat-remix-gnome &&\nmkdir -p ~/.themes && cp -r /tmp/flat-remix-gnome/Flat-Remix* ~/.themes &&\ngsettings set org.gnome.shell.extensions.user-theme name "Flat-Remix";`
          3. `apt install flat-remix-gnome && apt  install flat-remix-gtk ` or `apt install flat-remaix-*`

    13. 微调：Ubuntu18.04锁屏后dask to dock隐藏：
          1. 将扩展迁移到当前用户目录下：
             - `sudo mv /usr/share/gnome-shell/extensions/ubuntu-dock@ubuntu.com .local/share/gnome-shell/extensions`
          2. 变更权限：
             - `sudo chown -R $USER:$USER ~/.local/share/gnome-shell/extensions/ubuntu-dock@ubuntu.com`
    14. |||更换ubuntu输入密码时的紫色界面:
          1. 编辑以下这个 CSS 文件: `sudo vi /etc/alternatives/gdm3.css`
          2. 找到  #lockDialogGroup 这一项，原始的应该是这样的:
          3. #lockDialogGroup{
             - background: #2c001e url(resource:///org/gnome/shell/theme/noise-texture.png);
             - background-repeat: repeat;
             - }
          4. 把里面的内容改成  :
          5. #lockDialogGroup {
             - background: url(/*自己喜欢的图片的路径*/);
             - background-repeat: no-repeat;
             - background-size: cover;
             - background-position: center;
             - }
          6. 重启
    15. 安装spacevim：`curl -sLf https://spacevim.org/install.sh | bash && vim`
    16. For Nvidia desktop User: 
          1. __Software&Updates -> Additional Drivers -> Using recommended driver (tested) -> Apply changes -> Setting "Nvidia X Server Setting" -> reboot__
          2. __You can see changs in "System Settings -> Details -> About -> Graphics"__
          3. 使用Nvidia独显作为唯一输出显卡，关机重启不会卡，集显会卡一分钟再进行关机重启之类的。
          4. 不过就是独显能耗高，发热大，但是性能要强__(especially in machine learning & deep learning)__
    17. Ps:如果想安装其他的主题，操作差不多
