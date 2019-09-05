#!/bin/bash
file_name=nvidia.out
flag=( 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 )
nvidia-smi > $file_name
line_num=0

while read line
do
	if [ $line_num -gt 59 ] ; then
		echo $line
		array=(${line// / })
		if [[ ${array[1]} -gt -1 ]] && [[ ${array[1]} -lt 16 ]];then	
			echo "this num is" $array[1]
			echo "the flag was" $flag[${array[1]}]
			flag[$(( ${array[1]} ))]=-1
			echo "GPU NO:" ${array[1]} "is running successfully"
		fi
	fi
	line_num=$(( $line_num + 1 ))
done  < $file_name


for var in ${flag[@]}
do
	echo $var
done

nvi_id=0
while [ $nvi_id -lt 16 ]
do
	nid_flag=${flag[$nvi_id]}
	if [[ $nid_flag -ge 0 ]]; then
		source activate pyannote
		nohup python trainer.py $nvi_id >output/$nvi_id  2>&1 &
		echo "restart" $nvi_id "flag" $nid_flag  
	fi

	nvi_id=$(( $nvi_id + 1 ))
done

#!/bin/bash
file_name=nvidia.out
flag=( 0 1 2 3 4 5 6 7 )
nvidia-smi > $file_name
line_num=0

while read line
do
        if [ $line_num -gt 36 ] ; then
                #echo $line
                array=(${line// / })
                #echo jiayu
                #echo ${array[1]}
                if [[ ${array[1]} -gt -1 ]] && [[ ${array[1]} -lt 16 ]];then
                        #echo "this num is" $array[1]
                        #echo "the flag was" $flag[${array[1]}]
                        flag[$(( ${array[1]} ))]=-1
                        #echo "GPU NO:" ${array[1]} "is running successfully"
                fi
        fi
        line_num=$(( $line_num + 1 ))
done  < $file_name

#for var in ${flag[@]}
#do
#       echo $var
#done

nvi_id=0
while [ $nvi_id -lt 8 ]
do
        n_flag=${flag[$nvi_id]}
        if [ $n_flag -gt -1 ] ; then
                echo "we have to run"
                echo $nvi_id
        fi
        nvi_id=$(( $nvi_id+1 ))
done
