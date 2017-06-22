#!/usr/bin/env bash

# run all the fio scripts in background process and capture the pid in a file
./runAllFioTests.sh > ./runAllFioTests.log 2> ./runAllFioTests.error.log & echo $! >>./runAllFioTests.pid

sleep 10

# Check if the process is running, if so, sleep for a while (10mins)
PID=`cat ./runAllFioTests.pid`
while ps -p $PID > /dev/null; do
   echo "$PID is running"
   #sleep 10 minutes
   sleep 10*60
done

echo "$PID has completed. Running post processing of results..."
./copy_files_to_home_dir.sh
python ./json_to_csv_converter.py

exit 0