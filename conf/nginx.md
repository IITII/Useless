### 简单静态网页托管

```nginx
server { 
    listen 80 default_server;  
    server_name www.example.com;  
    location / { 
    root /usr/share/nginx/html; 
    # alias /usr/share/nginx/html; 
    index index.html index.htm;
    }
}
```

### https静态页面托管

```nginx
server {
    listen 443;
    server_name blog.nchu-cn.tw;
    ssl on;
    root /www/hexo/;
    index index.html index.htm;
    ssl_certificate  /etc/nginx/ssl/_.nchu-cn.tw.pem;
    ssl_certificate_key /etc/nginx/ssl/_.nchu-cn.tw.key;
    ssl_session_timeout 5m;
    ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:ECDHE:ECDH:AES:HIGH:!NULL:!aNULL:!MD5:!ADH:!RC4;
    ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
    ssl_prefer_server_ciphers on;
    location / {
        index index.html index.htm;
        try_files $uri $uri/ =404;
    }
}
server {
    listen 80;
    server_name blog.nchu-cn.tw;
    rewrite ^(.*)$ https://$host$1 permanent;
}
```

### HTTP 负载均衡
```nginx
upstream backend { 
 server 10.10.12.45:80 weight=1; 
 server app.example.com:80 weight=2; 
} 
server {
       location / { 
             proxy_pass http://backend; 
 } 
}
```

### TCP负载平衡，如MySQL查询

```nginx
stream { 
 upstream mysql_read { 
 server read1.example.com:3306 weight=5;
server read2.example.com:3306; 
 server 10.10.12.34:3306 backup; 
 } 
 server { 
 listen 3306; 
 proxy_pass mysql_read; 
 } 
}
```

### UDP负载平衡,如DNS查询

```nginx
stream { 
 upstream ntp { 
 server ntp1.example.com:123 weight=2; 
 server ntp2.example.com:123; 
 } 
 server { 
       listen 123 udp; 
       proxy_pass ntp; 
 } 
}
```

### 通过geoIP来获取客户端的粗略地理位置
> `apt install nginx-module-geoip`  

```nginx
load_module "/usr/lib64/nginx/modules/ngx_http_geoip_module.so"; 
http { 
 geoip_country /etc/nginx/geoip/GeoIP.dat;  
 geoip_city /etc/nginx/geoip/GeoLiteCity.dat; 
... 
}
```
### SSR分应用代理配置文件
```json
true

com.qianyan.eudic
com.tencent.FileManager
com.tmall.wireless
com.deniu.daniu
com.tencent.mm
com.nearme.statistics.rom
com.coloros.bootreg
com.oppo.camera
com.oppo.quicksearchbox
com.nearme.romupdate
com.hengye.share
com.android.packageinstaller
com.coloros.activation
com.android.captiveportallogin
com.oppo.market
com.tencent.mobileqq
com.redteamobile.roaming
com.coloros.filemanager
com.ted.number
com.coloros.fingerprint
com.coloros.findmyphone
com.mobiletools.systemhelper
com.coloros.feedback
com.iflytek.speechcloud
com.coloros.backuprestore
com.google.android.apps.photos
com.android.settings
com.tencent.token
app.greyshirts.sslcapture
com.supercell.clashofclans.uc
com.coloros.speechassist
com.fkzhang.qqxposed
com.eg.android.AlipayGphone
com.android.phone
com.coloros.video
com.android.browser
com.nearme.gamecenter
com.ct.client
com.android.bluetooth
com.oppo.usercenter
com.coloros.weather
mark.via.gp
com.coloros.compass
com.tencent.qqmusic
com.nearme.atlas
com.google.android.apps.docs.editors.docs
com.coloros.simsettings
com.aipao.hanmoveschool
com.flyersoft.moonreaderp
com.eteasun.nanhang
com.android.incallui
com.android.contacts
com.paypal.android.p2pmobile
com.coloros.blacklist
com.oppo.engineermode
com.nearme.sync
com.tencent.tim
com.tencent.tmgp.pubgmhd
com.coloros.speechassist.engine
com.tencent.tmgp.sgame
com.oppo.c2u
com.sonelli.juicessh
com.android.quicksearchbox
com.github.shadowsocks
com.wuxianlin.oppotools
com.coloros.sau
com.nearme.themespace
me.gfuil.bmap
com.coloros.safecenter
com.coloros.gallery3d
com.android.systemui
com.coolapk.market
```