1. cp frps /usr/bin/ && cp frpc /usr/bin/
2. mkdir -p /etc/frp/ && cp frp*.ini /etc/frp/
3. cp systemd/frp*.service /lib/systemd/system/ 
4. ln -s /lib/systemd/system/frp*.service /etc/systemd/system/