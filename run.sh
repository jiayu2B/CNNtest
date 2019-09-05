#!/bin/bash
 
for((i=0;i<=15;i++));
do 
nohup python trainer.py $i >output/$i  2>&1 &

done
