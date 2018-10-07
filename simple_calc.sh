 #!/bin/sh                                                                                                                                     

num1=20

num2=7

plus=`expr $num1 + $num2`

minus=`expr $num1 - $num2`

mul=`expr $num1 \* $num2`

div=`expr $num1 / $num2`

rem=`expr $num1 % $num2`


echo $plus

ARR1=( a b c )
ARR2=( d e f )

idx=0

for i in ${ARR1[@]};do

    for j in ${ARR2[@]};do
        echo "idx="$idx
        idx=`expr $idx + 1`
    done

done
