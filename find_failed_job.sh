#This is for filtering failed jobs in PHOTOS++ study.


#Error messages : Fatal Error Message, I stop this Run
ARR_LogFileName=($(ls *.log))
mkdir -p failed_jobs

####Check whether a logfile has err msg####
for LogFileName in ${ARR_LogFileName[@]};do

    jobname=${LogFileName%.log}
    errname=${jobname}.err
    jobnumber=${jobname#job_}
#echo "jobname="$jobname
#FileName=job_1.log
    echo $LogFileName   
    echo "jobnumber="$jobnumber
    ERR_MSG=`cat $LogFileName | grep "Fatal Error Message, I stop this Run"`   
    echo "$ERR_MSG"
    if [ -n "$ERR_MSG" ] 
    then
	echo "err"
	mv OUTPUT_${jobnumber}.root failed_jobs/	
    fi


    ERR_MSG=`cat $errname | grep "Error detected in"`
    if [ -n "${ERR_MSG}" ]  #Error detected in
    then
	echo "err"
	mv OUTPUT_${jobnumber}.root failed_jobs/
    fi
done
