JobBatchName            = CMS_SingularityTest_$(Cluster)

executable = singularity_test.sh

universe   = vanilla

requirements = ( HasSingularity == true )

getenv     = True

should_transfer_files = YES

when_to_transfer_output = ON_EXIT

output = job_$(Hostname).out

error = job_$(Hostname).err

log = job_$(Hostname).log

requirements = (Machine =?= "$(Hostname)")

transfer_input_files = singularity_test.sh

#transfer_output_files = hello/world.txt

accounting_group=group_cms

+SingularityImage = "/cvmfs/singularity.opensciencegrid.org/opensciencegrid/osgvo-el6:latest"

+SingularityBind = "/cvmfs, /cms, /share"

notification = Error

notify_user = geonmo@kisti.re.kr

queue Hostname from ifarm.txt 
