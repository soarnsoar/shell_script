
FileName="job_10.log"
jobname=${FileName%.log} ## %->remove part .log. *(asterisk) also 

echo "jobname="$jobname # job_10

jobnumber=${jobname#job_}
echo "jobnumber="$jobnumber


