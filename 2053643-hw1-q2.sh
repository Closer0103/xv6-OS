#!/bin/bash

PrintUptime(){
    n=$1
    for((i=0;i<n;i++));do
        uptime
        sleep 10s
    done
}

PrintUptime 15 >> "2053643-hw1-q2.log"      #确保执行不少于15次
