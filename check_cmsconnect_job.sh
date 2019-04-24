ARR_DEBUG=( $(ls *.debug) )

for debug in ${ARR_DEBUG[@]};do

    error=`cat $debug | grep error`
    if [ -z "$error" ];then
	echo "$debug""==>OK"
    else
	echo "@@@@$debug has error!!!"
    fi

done
