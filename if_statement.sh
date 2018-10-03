FileName=job_1.log

ERR_MSG=`cat $FileName | grep " Fatal Error Message, I stop this Run"`

echo "$ERR_MSG"

if [ -z "$ERR_MSG" ]
then
    echo "no err"
else
    echo "err"
fi
