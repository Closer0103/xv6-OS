#!/bin/bash
CountDown()
{
    timeup=$1
    for time in `seq $timeup -10 0`;do
        echo $time
        sleep 10
    done
}
CountDown $1 > "2053643-hw1-q4.log"
