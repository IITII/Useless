## Frp xtcp
### Fri Nov  1 11:34:40 CST 2019
* 目前还是不能穿透有线校园网，无线网未测试

> 不排除是 udp 端口的锅


#### Error

* Frpc

> 2019/11/01 11:36:39 [W] [proxy.go:325] [p2p_ssh_server] get sid from visitor error: read udp 10.1.79.11:50343: i/o timeout  
> 2019/11/01 11:36:57 [W] [proxy.go:325] [p2p_ssh_server] get sid from visitor error: read udp 10.1.79.11:54329: i/o timeout  

* Client

> root@server1804:~# ssh -oPort=6000 root@localhost  
> ssh_exchange_identification: read: Connection reset by peer  
> root@server1804:~#  