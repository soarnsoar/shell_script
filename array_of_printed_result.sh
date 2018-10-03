ARR=($(ls))

echo ${ARR[0]}
echo ${ARR[1]}
echo ${ARR[2]}
echo ${ARR[3]}


ARR2=($(ps -ef |grep jhchoi | awk '{print $2}'))

echo ${ARR2[0]}
echo ${ARR2[1]}
echo ${ARR2[2]}
echo ${ARR2[3]}