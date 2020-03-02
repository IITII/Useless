# V2ray configure
## NGINX
### PATH: /etc/nginx/nginx.conf
> cat LoadBalance.conf >> /etc/nginx/nginx.conf && nginx -t && nginx -s reload  

1. [LoadBalance.conf](./LoadBalance.conf)

### PATH: /etc/nginx/sites-available/*
> ln -s /etc/nginx/sites-available/* /etc/nginx/sites-enabled/ && nginx -t && nginx -s reload  

1. [multiInBound.json](./multiInBound.json)
2. [reverseProxy.nginx](./reverseProxy.nginx)