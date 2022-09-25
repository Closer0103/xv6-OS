#!/bin/bash
count() #统计q2文档中的相关信息并打印
{
    Log=$1
    
    Count=(`wc -lm $Log`)
    echo "${Count[0]}" #统计行数
    echo "${Count[1]}" #统计字符数量
    
    #取首行和尾行的时间戳
    LogStart=(`head -n 1 $Log`)
    LogEnd=(`tail -n 1 $Log`)
    
    StartTime=${LogStart[0]}
    EndTime=${LogEnd[0]}
    
    #时间化秒
    Start=$(date -d "2000-01-01 $StartTime" +%s)
    End=$(date -d "2000-01-01 $EndTime" +%s)
    echo "$(($End-Start))" #输出时间差，单位为秒
    
    #统计最后三行的数据
    ValueCount1=0
    ValueSum1=0
    while IFS=":," read -a line; do
        Value1=${line[-3]}
        NoZero1=(`echo "$Value1>0" | bc`)
        if [[ $NoZero1 -eq 1 ]]; then
            ValueCount1=$((ValueCount1+1))
            ValueSum1=$(printf "%.2f" `echo "scale=3;$ValueSum1+$Value1" | bc`)
        fi 
    done < $Log
    
    if [[ $ValueCount1 -gt 0 ]]; then
        ValueArg1=$(printf "%.2f" `echo "scale=3;$ValueSum1/$ValueCount1" | bc`)
    else
        ValueArg1=0
    fi
    
    ValueCount2=0
    ValueSum2=0
    while IFS=":," read -a line; do
        Value2=${line[-2]}
        NoZero2=(`echo "$Value2>0" | bc`)
        if [[ $NoZero2 -eq 1 ]]; then
            ValueCount2=$((ValueCount2+1))
            ValueSum2=$(printf "%.2f" `echo "scale=3;$ValueSum2+$Value2" | bc`)
        fi 
    done < $Log
    
    if [[ $ValueCount2 -gt 0 ]]; then
        ValueArg2=$(printf "%.2f" `echo "scale=3;$ValueSum2/$ValueCount2" | bc`)
    else
        ValueArg2=0
    fi
    
    ValueCount3=0
    ValueSum3=0
    while IFS=":," read -a line; do
        Value3=${line[-1]}
        NoZero3=(`echo "$Value3>0" | bc`)
        if [[ $NoZero3 -eq 1 ]]; then
            ValueCount3=$((ValueCount3+1))
            ValueSum3=$(printf "%.2f" `echo "scale=3;$ValueSum3+$Value3" | bc`)
        fi 
    done < $Log
    
    if [[ $ValueCount3 -gt 0 ]]; then
        ValueArg3=$(printf "%.2f" `echo "scale=3;$ValueSum3/$ValueCount3" | bc`)
    else
        ValueArg3=0
    fi
    
    echo "$ValueArg1 $ValueArg2 $ValueArg3"
}

count $1 > "2053643-hw1-q3.log"
