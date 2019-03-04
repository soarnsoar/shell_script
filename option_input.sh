#!/bin/sh

function  usage {
   echo "USAGE: $0 param..";
   exit 0;
}

PARAM="p:n:ouh";

while getopts $PARAM opt; do
  case $opt in
    p)
        echo "-p option was supplied. OPTARG: $OPTARG" >&2
        OPT_P=$OPTARG;
        ;;
    n)
        echo "-n option was supplied. OPTARG: $OPTARG" >&2
        OPT_N=$OPTARG;
        ;;
    o)
        echo "-o option was supplied." >&2
        ;;
    u)
        echo "-u option was supplied." >&2
        ;;
    h)
        usage;
         ;;
  esac
done

## 저장된 optarg
echo "$OPT_P, $OPT_N";
