# Nothing
>Nothing
>>> `(￣▽￣)～■干杯□～(￣▽￣)`
----
**Contents**
----
* [***Shell脚本***](#shell脚本)

  * [quick-set.sh](#quick-setsh)
  
  * [AutoFormat.sh](#AutoFormatsh)
  
  * []
  
* [***配置文件***](#配置文件)

  * [V2ray配置文件](#V2ray-configconf)
----
## shell脚本
----
### quick-set.sh
> 为了我在删库后快速重建环境
* 食用方法：
  ```bash
  wget -N --no-check-certificate https://raw.githubusercontent.com/IITII/Useless/master/quick-set.sh && chmod +x quick-set.sh && bash quick-set.sh
  ```
### AutoFormat.sh
> Aria2自动转码脚本（开发ing）
* 食用方法：
  ```bash
  wget -N --no-check-certificate https://raw.githubusercontent.com/IITII/Useless/master/AutoFormat.sh && chmod +x AutoFormat.sh && bash AutoFormat.sh
  ```
----
## 配置文件
----
### V2ray-config.conf
> V2ray简单配置文件，内置ss + mtproxy
* 食用方法：
  ```bash
  wget -N --no-check-certificate https://raw.githubusercontent.com/IITII/Useless/master/v2ray-config.conf
  #请提前将配置文件做好备份
  #防火墙需开放 55555（for ss）和 55557（for mtproxy）
  mv ./v2ray-config.conf /etc/v2ray/config.conf
  systemctl restart v2ray && systemctl status v2ray
  ```
----------
>Contact me by  [Telegram](https://t.me/callmehelp).
>>o((⊙﹏⊙))o.
