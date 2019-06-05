#JOBDIR=NanoGardening__Autumn18_102X_nAODv4_GTv16_Full2018v4
#JOBDIR=NanoGardening__Summer16_102X_nAODv4_Full2016v4
#JOBDIR=NanoGardening__Run2016_102X_nAODv4_Full2016v4
JOBDIR=NanoGardening__Fall2017_102X_nAODv4_Full2017v4
#JOBDIR=NanoGardening__Run2017_102X_nAODv4_Full2017v4
#JOBDIR=NanoGardening__Run2018_102X_nAODv4_14Dec_Full2018v4
#JOBDIR=NanoGardening__Autumn18_102X_nAODv4_Full2018

TAG='Cor'
#TAG='rochester'
VETOTAG=''
VETOTAG='-v'

##-----Just check .done exists-----##
pushd $JOBDIR
echo "#Enter"
ARR_ERRFILE=($(ls *.err|grep $VETOTAG "$TAG"))
ARR_TOTAL=($(ls *.sh | grep $VETOTAG "$TAG"))
NSUCCESS=0
NFAIL=0
NRUNNING=0
NSUBMIT=0
NTOTAL=${#ARR_TOTAL[@]}
FAIL_LIST=()
FAIL_ID_LIST=()
SUCCESS_LIST=()
RUNNING_LIST=()
for errfile in ${ARR_ERRFILE[@]};do
    NSUBMIT=`expr $NSUBMIT + 1`
    jobname=${errfile%".err"}
    logfile=${jobname}.log
    outfile=${jobname}.out # file probably overwritten: stopping reporting error messages
    jidfile=${jobname}.jid
    echo "@jobname="$jobname
    echo "@@Check shell@@"
    #ls $jobname.sh
    #ERR=`cat $errfile | grep error`
    #REFERR=`cat $errfile | grep ReferenceError`
    #echo #REFERR
    #if [ -n "$ERR" ]
    #then
	#echo "!!!!!!!!!err!!!!!!!!!!"
	#FAIL_LIST+=($jobname)
	#NFAIL=`expr $NFAIL + 1`
    #elif [ -n "$REFERR" ]
    #then
	#echo "!!!!!!!!!referr!!!!!!!!!!"
        #FAIL_LIST+=($jobname)
	#NFAIL=`expr $NFAIL + 1`

    #else
	#SUCCESS_LIST+=($jobname)
	#NSUCCESS=`expr $NSUCCESS + 1`
    #fi
    TRANSFER_ERR=`cat $errfile|grep 'Server responded with an error'`
    GET_NANOAOD_ERR=`cat $errfile|grep 'attempt to access a null-pointer'`
    TERMINATED_JOB=`cat $logfile|grep 'Job terminated'`
    ALREADY_EXIST=`cat $errfile|grep 'multiple files exist'`
    ZOMBIE=`cat $outfile|grep 'file probably overwritten: stopping reporting error messages'`
    JOBID=`cat ${jidfile}|grep '1 job(s) submitted to cluster'`
    JOBID=${JOBID#"1 job(s) submitted to cluster "}
    JOBID=${JOBID}"0"
    #echo "JODID="${JOBID}
    if [[ -e "$jobname".done ]] && [[ -z "$TRANSFER_ERR" ]] && [[ -z "$GET_NANOAOD_ERR" ]] && [[ -n "$TERMINATED_JOB" ]] && [[ -z "$ZOMBIE" ]];then

	SUCCESS_LIST+=($jobname)
        NSUCCESS=`expr $NSUCCESS + 1`
	
    elif [[ -z "$TERMINATED_JOB" ]] && [[ -z "$ZOMBIE" ]];then
	echo "-->Still Running"
	echo "$TERMINATED_JOB"
	NRUNNING=`expr $NRUNNING + 1`
	RUNNING_LIST+=($jobname)
    elif [[ -n "$ALREADY_EXIST" ]] && [[ -z "$ZOMBIE" ]];then
	SUCCESS_LIST+=($jobname)
	NSUCCESS=`expr $NSUCCESS + 1`
	
    else
	FAIL_LIST+=($jobname)                                                                                                         FAIL_ID_LIST+=(${JOBID})
	echo "check zombie=${ZOMBIE}"                         
        NFAIL=`expr $NFAIL + 1`
	
	echo "!!!!no output!!!"
    fi

done
echo "NSUCCESS="$NSUCCESS
echo "NFAIL="$NFAIL
echo "NRUNNING="$NRUNNING
echo "NSUBMIT="$NSUBMIT
echo "NTOTAL="$NTOTAL
popd

echo "------@@RUNNING LIST@@------"
for run in ${RUNNING_LIST[@]};do
    echo $run
done
echo "------@@FAIL LIST@@------"
for fail in ${FAIL_LIST[@]};do
    echo $fail
done



isanswered=0
isresubmit=0
while [ $isanswered -eq 0 ];do
    echo -e "resubmit????[y/n]: \c "
    read answer
    
    
    if [ "$answer" = "y" ];then
	
	isanswered=1
	isresubmit=1
	
    elif [ "$answer" = "n" ];then
	isanswered=1
	isresubmit=0
    else
	echo "!!Please answer with y/n"
	
    fi
    
done



if [ $isresubmit -eq 1 ];then
    
    isanswered=0
    isclear=0
    recondor=0

    echo "--remove ZOMBIE---"
    for jobid in ${FAIL_ID_LIST[@]};do
	condor_rm ${jobid}
    done


    while [ $isanswered -eq 0 ];do
	echo -e "resubmit via condor_submit????[y/n]: \c "
	read answer
	
	
	if [ "$answer" = "y" ];then
	    
            isanswered=1
            recondor=1
	    isclear=0
	elif [ "$answer" = "n" ];then
            isanswered=1
            recondor=0
	    isclear=1
	else
            echo "!!Please answer with y/n"
	    
	fi
	
    done


    echo "@@resubmit@@"
    echo "recondor="$recondor
    echo "isclear="$isclear
    pushd $JOBDIR
    mkdir -p fail_jobs
    for failjob in ${FAIL_LIST[@]};do
	mv $failjob.out fail_jobs/
	mv $failjob.err fail_jobs/
	mv $failjob.log fail_jobs/
	mv $failjob.done fail_jobs/
	
	

	if [ $isclear -eq 1 ];then
	##resubmit via latino command(not using condor_submit)
	mv $failjob.* fail_jobs/
	#mv $failjob.py fail_jobs/
	#mv $failjob.jid fail_jobs/
	fi
	if [ $recondor -eq 1 ];then
	condor_submit $failjob.jds &> $failjob.jid
	tail $failjob.jid
	fi
    done



    popd
fi
