#!/usr/bin/env bash

rw=(read randread randrw randwrite write)
bslist=("4KB" "32KB" "128KB" "1MB")
size1list=("4KB" "1MB" "100MB")
size2list=("32KB" "1MB" "100MB")
size3list=("128KB" "1MB" "100MB")
size4list=("1MB" "100MB")
joblist=(1 16 64 256 1000)
dir="/mnt/testCinder01/"
direct=1
runtime=$1

for rw_val in "${rw[@]}"
do
    if [ "${rw_val}" = "read" ]; then
        rwmixread=(100)
    fi
    if [ "${rw_val}" = "randread" ]; then
        rwmixread=(100)
    fi
    if [ "${rw_val}" = "randrw" ]; then
        rwmixread=(80 50 20)
    fi
    if [ "${rw_val}" = "randwrite" ]; then
        rwmixread=(0)
    fi
    if [ "${rw_val}" = "write" ]; then
        rwmixread=(0)
    fi

    for rwmixread_val in "${rwmixread[@]}"
    do
        bs=${bslist[0]}
        for size in "${size1list[@]}"
        do
            for job in "${joblist[@]}"
            do
                echo "fio --directory=${dir} --bs=${bs} --size=${size} --numjobs=${job} --direct=${direct} --rw=${rw_val} --rwmixread=${rwmixread_val} --group_reporting --name=testfile --output=fio_${bs}_${size}_${job}_${rwmixread_val}_${rw_val}_output.txt --output-format=json --time_based --runtime=${runtime};" >> runAllFioTests.sh
                echo "fio_${bs}_${size}_${job}_${rwmixread_val}_${rw_val}_output.txt" >> ordered_filenames.txt
            done
        done

        echo "rm -rf ${dir}testfile.*;" >> runAllFioTests.sh

        bs=${bslist[1]}
        for size in "${size2list[@]}"
        do
            for job in "${joblist[@]}"
            do
                echo "fio --directory=${dir} --bs=${bs} --size=${size} --numjobs=${job} --direct=${direct} --rw=${rw_val} --rwmixread=${rwmixread_val} --group_reporting --name=testfile --output=fio_${bs}_${size}_${job}_${rwmixread_val}_${rw_val}_output.txt --output-format=json --time_based --runtime=${runtime};" >> runAllFioTests.sh
                echo "fio_${bs}_${size}_${job}_${rwmixread_val}_${rw_val}_output.txt" >> ordered_filenames.txt
            done
        done

        echo "rm -rf ${dir}testfile.*;" >> runAllFioTests.sh

        bs=${bslist[2]}
        for size in "${size3list[@]}"
        do
            for job in "${joblist[@]}"
            do
                echo "fio --directory=${dir} --bs=${bs} --size=${size} --numjobs=${job} --direct=${direct} --rw=${rw_val} --rwmixread=${rwmixread_val} --group_reporting --name=testfile --output=fio_${bs}_${size}_${job}_${rwmixread_val}_${rw_val}_output.txt --output-format=json --time_based --runtime=${runtime};" >> runAllFioTests.sh
                echo "fio_${bs}_${size}_${job}_${rwmixread_val}_${rw_val}_output.txt" >> ordered_filenames.txt
            done
        done

        echo "rm -rf ${dir}testfile.*;" >> runAllFioTests.sh

        bs=${bslist[3]}
        for size in "${size4list[@]}"
        do
            for job in "${joblist[@]}"
            do
                echo "fio --directory=${dir} --bs=${bs} --size=${size} --numjobs=${job} --direct=${direct} --rw=${rw_val} --rwmixread=${rwmixread_val} --group_reporting --name=testfile --output=fio_${bs}_${size}_${job}_${rwmixread_val}_${rw_val}_output.txt --output-format=json --time_based --runtime=${runtime};" >> runAllFioTests.sh
                echo "fio_${bs}_${size}_${job}_${rwmixread_val}_${rw_val}_output.txt" >> ordered_filenames.txt
            done
        done

        echo "rm -rf ${dir}testfile.*;" >> runAllFioTests.sh

    done
done

exit 0
