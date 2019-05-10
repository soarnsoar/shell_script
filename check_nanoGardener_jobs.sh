#JOBDIR=NanoGardening__Autumn18_102X_nAODv4_Full2018
#JOBDIR=NanoGardening__Summer16_102X_nAODv4_Full2016v4
JOBDIR=NanoGardening__Run2016_102X_nAODv4_Full2016v4
pushd $JOBDIR
echo "#Enter"
ARR_ERRFILE=($(ls *.err))
ARR_TOTAL=($(ls *.sh))
NSUCCESS=0
NFAIL=0
NSUBMIT=0
NTOTAL=${#ARR_TOTAL[@]}
FAIL_LIST=()
SUCCESS_LIST=()

for errfile in ${ARR_ERRFILE[@]};do
    NSUBMIT=`expr $NSUBMIT + 1`
    jobname=${errfile%".err"}
    echo "@jobname="$jobname
    echo "@@Check shell@@"
    #ls $jobname.sh
    ERR=`cat $errfile | grep error`
    if [ -z "$ERR" ]
    then
	SUCCESS_LIST+=($jobname)
	NSUCCESS=`expr $NSUCCESS + 1`
    else
	echo "!!!!!!!!!err!!!!!!!!!!"
	FAIL_LIST+=($jobname)
	NFAIL=`expr $NFAIL + 1`
    fi


done
echo "NSUCCESS="$NSUCCESS
echo "NFAIL="$NFAIL
echo "NSUBMIT="$NSUBMIT
echo "NTOTAL="$NTOTAL
popd

echo "@@FAIL LIST@@"
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

    echo "@@resubmit@@"
    pushd $JOBDIR
    mkdir -p fail_jobs
    for failjob in ${FAIL_LIST[@]};do
	mv $failjob.out fail_jobs/
	mv $failjob.err fail_jobs/
	mv $failjob.log fail_jobs/
	condor_submit $failjob.jds

    done



    popd
fi