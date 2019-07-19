#!/bin/sh
 
sudo apt-get auto-clean
sudo apt-get clean
sudo apt-get autoremove
 
echo -n "" | sudo tee /var/log/messages
echo -n "" | sudo tee /var/log/user.log
echo -n "" | sudo tee /var/log/auth.log
echo -n "" | sudo tee /var/log/syslog
echo -n "" | sudo tee /var/log/apache2/access.log
echo -n "" | sudo tee /usr/local/nginx/logs/access.log
echo -n "" | sudo tee /usr/local/nginx/logs/error.log
 
exit
