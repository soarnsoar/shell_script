##This is for KISTI job
echo "===batch_creater_jhchoi.sh==="
#############Set variable##########
CURDIR=`pwd`
JOBNAME="JOB_"$1
NJOBS=$2
echo "JOB DIR ="$JOBNAME
##input tar's name => INPUT.tar.gz

###################################


if [ -z $2 ];then
    echo "default NJOBs = 1"
    NJOBS=1
fi





#########Check input argument######
if [ -z $1 ];then
echo "Need argument"


#########Check alreay job env######
elif [ -d $JOBNAME ];then
echo "The job directory alreay exists"

else

##Make tar input

#tar -cvzf INPUT.tar.gz *
echo "===Make INPUT.tar.gz==="


tar -czf INPUT_${1}.tar.gz CMSSW* *.py

#$JOBNAME

mkdir $JOBNAME
cd $JOBNAME
mv ../INPUT_${1}.tar.gz INPUT.tar.gz

echo "===Make submit.jds==="

echo "executable = run_${1}.sh" >> submit.jds 
echo "universe   = vanilla" >> submit.jds
echo "arguments  = \$(Process)" >> submit.jds
echo "requirements = OpSysMajorVer == 6" >> submit.jds
echo "log = condor.log" >> submit.jds
echo "getenv     = True" >> submit.jds
echo "should_transfer_files = YES" >> submit.jds
echo "when_to_transfer_output = ON_EXIT" >> submit.jds
echo "output = job_\$(Process).log" >> submit.jds
echo "error = job_\$(Process).err" >> submit.jds
echo "transfer_input_files = INPUT.tar.gz" >> submit.jds
#echo "use_x509userproxy = true" >> submit.jds
echo "transfer_output_remaps = \"OUTPUT.root = OUTPUT_\$(Process).root\"" >> submit.jds
echo "queue $NJOBS" >> submit.jds


echo "===Make submit.jds DONE.==="

fi
###################################

cd $CURDIR

##then move to $JOBNAME directory and
##make run.sh script
##make output file name to OUTPUT.root
#condor_submit submit.jds


echo "batch_creater_jhchoi.sh DONE."



:<< 'END'
#!/bin/bash
SECTION=`printf %03d $1`
WORKDIR=`pwd`
echo "#### Extracting cmssw ####"
tar -zxvf INPUT.tar.gz
echo "#### cmsenv ####"
export CMS_PATH=/cvmfs/cms.cern.ch
source $CMS_PATH/cmsset_default.sh
export SCRAM_ARCH=slc6_amd64_gcc630
#cd CMSSW_X_Y_Z/src/
cd CMSSW_10_3_X_2018-07-29-2300/src
scram build ProjectRename
eval `scramv1 runtime -sh`
cd ../../
cmsRun RUN.py

END
