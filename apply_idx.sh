alias getidx='wget https://raw.githubusercontent.com/soarnsoar/MC_Contact_script/master/python/index.php'


ndir='/'
while [ 1 ];do
    dirs=($(ls -d ${PWD}${ndir}))
    if [ ${#dirs[@]} -eq 0  ];then
	echo "[MSG] No dir under ${curdir}${ndir}"
	break
    fi
    #layers+=($ndir)
    for dir in ${dirs[@]};do
	pushd ${dir}
	getidx
	popd
    done
    ndir=$ndir'/*/'
    echo "ndir="${ndir}
done
