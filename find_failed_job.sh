#This is for filtering failed jobs in PHOTOS++ study.


#Error messages : Fatal Error Message, I stop this Run

#ARR_ERR_PHR=("Fatal Error Message, I stop this Run" "Error detected in" "segmentation violation")
ARR_ERR_PHR=("failed with system error")

ARR_LogFileName=($(ls job*.log))

mkdir -p failed_jobs

####Check whether a logfile has err msg####
for LogFileName in ${ARR_LogFileName[@]};do

    jobname=${LogFileName%.log}
    errname=${jobname}.err
    jobnumber=${jobname#job_}
#echo "jobname="$jobname
#FileName=job_1.log
    echo $LogFileName   
    #echo "jobnumber="$jobnumber
  

    for err_phr_i in "${ARR_ERR_PHR[@]}";do
	#echo $LogFileName
	#echo $err_phr_i
	ERR_MSG=`cat $LogFileName | grep "${err_phr_i}"`   
	echo "$ERR_MSG"
	if [ -n "$ERR_MSG" ] 
	then
	   # echo "err from .log"
	    mv OUTPUT_${jobnumber}.root failed_jobs/ 
	fi
	
	
	ERR_MSG=`cat $errname | grep "${err_phr_i}"`
        echo "$ERR_MSG"
	if [ -n "${ERR_MSG}" ]  #Error detected in
	then
	  #  echo "err from .err"
	    mv OUTPUT_${jobnumber}.root failed_jobs/
	fi
    done
done
