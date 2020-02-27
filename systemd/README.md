## Systemd Service
* `startUp.sh`: ***run something after boot***
* `systemDown.sh`: ***run something before system down***
  
### How to use ?
1. `sudo cp *.service /lib/systemd/system/`
2. `sudo cp *.sh /root/`
3. `systemctl enable startUp.service systemDown.service`