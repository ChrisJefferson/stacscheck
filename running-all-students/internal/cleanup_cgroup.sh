#!/bin/bash


timetowait=$1
student=$2

cgdir="/sys/fs/cgroup/memory/stacscheck-${USER}/$student"

counter=0

while [[ counter -lt timetowait ]]
do
    if [[ $(wc -l < "${cgdir}/tasks") == "0" ]]; then
        echo "$student finished"
        exit 0
    fi;
    sleep 1
    counter=$((counter + 1))
done

echo "Cleaning up $student"

while [[ $(wc -l < "${cgdir}/tasks") != "0" ]]
do
    echo "Killing stale jobs for $student"
    kill -9 $(cat ${cgdir}/tasks)
    sleep 1
done
