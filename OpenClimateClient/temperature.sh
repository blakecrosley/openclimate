#!/bin/bash

cpuTemp0=$(cat /sys/class/thermal/thermal_zone0/temp)
cpuTemp1=$(($cpuTemp0/1000))
cpuTemp2=$(($cpuTemp0/100))
cpuTempM=$(($cpuTemp2 % $cpuTemp1))

url=http://192.168.1.16:3030/temperature/save
reqSend=temperature"="$cpuTemp1.$cpuTempM

echo $url
echo $reqSend

curl -X POST --data $reqSend $url

echo CPU temp"="$cpuTemp1"."$cpuTempM"'C"
