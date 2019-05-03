ARR_TAR=( $(ls *.tar.xz) )


for gridpack in ${ARR_TAR[@]};do
    echo "@@TEST "${gridpack}"@@"
    TESTDIR=test_${gridpack}
    mkdir -p ${TESTDIR}
    pushd $TESTDIR
    tar -xf ../${gridpack}
    ./runcmsgrid.sh 10 10 10 &> test_log.txt &
    popd

    
done
