#!/bin/bash
declare CONTAINER_NAME=sql
if ! sudo docker ps | grep $CONTAINER_NAME
then
sudo docker start $CONTAINER_NAME
fi