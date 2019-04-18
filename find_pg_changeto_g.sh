#ARR=( $(grep -r "LoadMacro" ./ |grep ".py:") )
#echo ${ARR[3]}
ARR=(`grep -r "LoadMacro" ./ |grep ".py:"|grep "+g"|awk '{print $1}'`)
#| awk '{print $4}'))
#for file in "${ARR[@]}";do
#    echo file
#done
#echo ${ARR[4]}
CURDIR=`pwd`
for filedir in ${ARR[@]};do

    

    #echo "filedir="$filedir


    file=${filedir##*/}    
    
    echo "file="$file
    dir=${filedir%${file}}
    echo "dir="$dir

    file=${file%":"}
    pushd ${CURDIR}/${dir}
    
    ls $file

    find . -name $file | xargs perl -pi -e 's/\+g/g/g'

    popd
