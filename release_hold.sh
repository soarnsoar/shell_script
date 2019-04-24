#status=condor_q jhchoi | awk '{print $6}'
ARR_ID=(`condor_q -hold jhchoi | grep jhchoi | awk '{print $1}'`)

for id in ${ARR_ID[@]};do
    #echo $id
    condor_release $id
done
