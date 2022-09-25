#!/bin/bash
CheckPrime()   #检查数字是否为质数
{
    n=$1  #表示输入的参数
    if [[ $n -lt 2 ]]; then
        return 0
    fi
    for ((i=2; i<n; i++)); do
        r=$(($n%$i))
        if [[ $r -eq 0 ]]; then
            return 0
        fi
    done
    return 1
}

Sum()  #求和函数
{
    start=$1 #start为参数1，而end为参数2
    end=$2
    
    sum=0
    for(( n=$start;n<=$end;n++ ))
    do
        CheckPrime $n
        if [[ $? -eq 1 ]]; then
            sum=$(($sum+$n))
        fi
    done
    echo $sum
}

Sum 1 100 > "2053643-hw1-q1.log"
