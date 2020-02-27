#!/bin/bash
echo "$(/bin/date +"%H:%M:%S"): System down" >>/root/systemd.log
exit 0;
