array=($(ls *tar.xz))
for tar in ${array[@]};do
    tar -xf $tar

done
