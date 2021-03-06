#!/bin/sh
if [ "x$1" = "x" ] || [ "x$2" = "x" ]; then
  echo "This utility needs to two parameter in integer"
  echo "@usage: $ ./create.sh 1 10"
  exit 0
fi

start=$1
end=$2

if [ "$start" -ge "$end" ]
then
  echo "$start is bigger than or equal $end"
else 
  echo "============== Cleanup Starting ===================="

  for (( c=$start; c<=$end; c++ ))
  do  
    kubectl delete clusterrolebinding crb-zcp-admin-0$c-clusteradmin
    kubectl delete quota compute-resources -n ns-zcp-admin-0$c
    kubectl delete limitranges mem-limit-range -n ns-zcp-admin-0$c
    kubectl delete limitranges cpu-limit-range -n ns-zcp-admin-0$c
    kubectl delete namespace ns-zcp-admin-0$c
    kubectl delete serviceaccount zcp-admin-0$c -n zcp-system
    echo "....."
  done

  echo "============== Cleanup Finished ===================="
fi
