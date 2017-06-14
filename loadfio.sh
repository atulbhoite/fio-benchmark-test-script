#! /bin/bash

# This is the script used in the cloud init which
# downloads fio rpm package for centos 7 and installs it

#create ssh key
mkdir -p ~/.ssh/
echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAgEAy47C1WrmIy3uCiPW8fNfpgT51BzfvEiKBxcpJn5jr5rDHItViZUmXq6Nx+oYHhotaeIHpgzjj8gAN/Td33MNho171JEe95vc1I9nnkjTGS5EzCHSgooKuSCLcoGuspvYBeGj9bZPXkOQYFBMJkP2BoVqlW9Be7YuwlLfsCGIBUpkgAF8lmNWkHvBMhGwfhJsI7mDNPqrKmym+cRMAMeg5DQ9AlidY1F3itQNQQHqvZC7lmKN4+xjqJYl85TALBaHfGVzzHFH7IPKY6eo9xFeOuN5V9h82WgACCPYrMiMeKqi4HbMmVUYdGFq7xLiyBDYDtTIPYRTsbeuB22oBwYyTDWMN9E/dKeke0RXgFCtSCYGPAWHZ6cm0Vxj8tSmALs+dXgZ9JXQLGchH3yCB7DMO3BwwnSE2sGvLl0mbCWvnrDQAhxZ57CxB2zTNg14s9h4sq8gJYg38OI58wvy11GCDiACTcgS42OJzQoa22Q8cBgjCKCre8tLjJZx4/HTfOzNKqBqXEaJqULHVQRlpATldunlelPjAIRlIDTUQHYDoU9l3hVe1VfuvqvaVS7cJz6/JM5iRhonOtgwz8hchf4zL0AKs0c0itwvDlKM/g8qdtzAP6brRRVK/FDA2aUFu9Pjbz7nics0qdc4Uir9Bnqy9AsjiCS1iys9H5X12Z3koKU="  >> ~/.ssh/authorized_keys

echo "Downloading fio package... "
wget ftp://ftp.pbone.net/mirror/ftp.centos.org/7.3.1611/cloud/x86_64/openstack-newton/common/fio-2.2.10-1.el7.x86_64.rpm
sleep 1
echo "Installing fio package... "
rpm -iv fio-2.2.10-1.el7.x86_64.rpm
sleep 1

echo "Installing gnuplot for fio2gnuplot graphics..."
yum install -y gnuplot
sleep 3

echo "Creating scripts for fio testing..."

# Create a script to run the fio for various block sizes.
#Read-to-Write: 100/0 Sequential
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=4KB --numjobs=1 --rw=read --rwmixread=100 --group_reporting --name=testfile --output=fio_4_4_1_100_0_seqread_output.txt --output-format=json --time_based --runtime=300 --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_4_1_100_0_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=4KB --numjobs=16 --rw=read --rwmixread=100 --group_reporting --name=testfile --output=fio_4_4_16_100_0_seqread_output.txt --output-format=json --time_based --runtime=300 --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_4_16_100_0_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=4KB --numjobs=64 --rw=read --rwmixread=100 --group_reporting --name=testfile --output=fio_4_4_64_100_0_seqread_output.txt --output-format=json --time_based --runtime=300 --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_4_64_100_0_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=4KB --numjobs=256 --rw=read --rwmixread=100 --group_reporting --name=testfile --output=fio_4_4_256_100_0_seqread_output.txt --output-format=json --time_based --runtime=300 --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_4_256_100_0_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=4KB --numjobs=1000 --rw=read --rwmixread=100 --group_reporting --name=testfile --output=fio_4_4_1000_100_0_seqread_output.txt --output-format=json --time_based --runtime=300 --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_4_1000_100_0_seqread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=1MB --numjobs=1 --rw=read --rwmixread=100 --group_reporting --name=testfile --output=fio_4_1_1_100_0_seqread_output.txt --output-format=json --time_based --runtime=300 --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_1_1_100_0_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=1MB --numjobs=16 --rw=read --rwmixread=100 --group_reporting --name=testfile --output=fio_4_1_16_100_0_seqread_output.txt --output-format=json --time_based --runtime=300 --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_1_16_100_0_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=1MB --numjobs=64 --rw=read --rwmixread=100 --group_reporting --name=testfile --output=fio_4_1_64_100_0_seqread_output.txt --output-format=json --time_based --runtime=300 --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_1_64_100_0_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=1MB --numjobs=256 --rw=read --rwmixread=100 --group_reporting --name=testfile --output=fio_4_1_256_100_0_seqread_output.txt --output-format=json --time_based --runtime=300 --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_1_256_100_0_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=1MB --numjobs=1000 --rw=read --rwmixread=100 --group_reporting --name=testfile --output=fio_4_1_1000_100_0_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_1_1000_100_0_seqread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=100MB --numjobs=1 --rw=read --rwmixread=100 --group_reporting --name=testfile --output=fio_4_100_1_100_0_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_100_1_100_0_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=100MB --numjobs=16 --rw=read --rwmixread=100 --group_reporting --name=testfile --output=fio_4_100_16_100_0_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_100_16_100_0_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=100MB --numjobs=64 --rw=read --rwmixread=100 --group_reporting --name=testfile --output=fio_4_100_64_100_0_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_100_64_100_0_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=100MB --numjobs=256 --rw=read --rwmixread=100 --group_reporting --name=testfile --output=fio_4_100_256_100_0_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_100_256_100_0_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=100MB --numjobs=1000 --rw=read --rwmixread=100 --group_reporting --name=testfile --output=fio_4_100_1000_100_0_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_100_1000_100_0_seqread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=32KB --numjobs=1 --rw=read --rwmixread=100 --group_reporting --name=testfile --output=fio_32_32_1_100_0_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_32_1_100_0_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=32KB --numjobs=16 --rw=read --rwmixread=100 --group_reporting --name=testfile --output=fio_32_32_16_100_0_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_32_16_100_0_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=32KB --numjobs=64 --rw=read --rwmixread=100 --group_reporting --name=testfile --output=fio_32_32_64_100_0_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_32_64_100_0_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=32KB --numjobs=256 --rw=read --rwmixread=100 --group_reporting --name=testfile --output=fio_32_32_256_100_0_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_32_256_100_0_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=32KB --numjobs=1000 --rw=read --rwmixread=100 --group_reporting --name=testfile --output=fio_32_32_1000_100_0_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_32_1000_100_0_seqread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=1MB --numjobs=1 --rw=read --rwmixread=100 --group_reporting --name=testfile --output=fio_32_1_1_100_0_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_1_1_100_0_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=1MB --numjobs=16 --rw=read --rwmixread=100 --group_reporting --name=testfile --output=fio_32_1_16_100_0_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_1_16_100_0_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=1MB --numjobs=64 --rw=read --rwmixread=100 --group_reporting --name=testfile --output=fio_32_1_64_100_0_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_1_64_100_0_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=1MB --numjobs=256 --rw=read --rwmixread=100 --group_reporting --name=testfile --output=fio_32_1_256_100_0_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_1_256_100_0_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=1MB --numjobs=1000 --rw=read --rwmixread=100 --group_reporting --name=testfile --output=fio_32_1_1000_100_0_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_1_1000_100_0_seqread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=100MB --numjobs=1 --rw=read --rwmixread=100 --group_reporting --name=testfile --output=fio_32_100_1_100_0_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_100_1_100_0_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=100MB --numjobs=16 --rw=read --rwmixread=100 --group_reporting --name=testfile --output=fio_32_100_16_100_0_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_100_16_100_0_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=100MB --numjobs=64 --rw=read --rwmixread=100 --group_reporting --name=testfile --output=fio_32_100_64_100_0_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_100_64_100_0_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=100MB --numjobs=256 --rw=read --rwmixread=100 --group_reporting --name=testfile --output=fio_32_100_256_100_0_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_100_256_100_0_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=100MB --numjobs=1000 --rw=read --rwmixread=100 --group_reporting --name=testfile --output=fio_32_100_1000_100_0_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_100_1000_100_0_seqread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=128KB --numjobs=1 --rw=read --rwmixread=100 --group_reporting --name=testfile --output=fio_128_128_1_100_0_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_128_1_100_0_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=128KB --numjobs=16 --rw=read --rwmixread=100 --group_reporting --name=testfile --output=fio_128_128_16_100_0_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_128_16_100_0_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=128KB --numjobs=64 --rw=read --rwmixread=100 --group_reporting --name=testfile --output=fio_128_128_64_100_0_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_128_64_100_0_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=128KB --numjobs=256 --rw=read --rwmixread=100 --group_reporting --name=testfile --output=fio_128_128_256_100_0_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_128_256_100_0_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=128KB --numjobs=1000 --rw=read --rwmixread=100 --group_reporting --name=testfile --output=fio_128_128_1000_100_0_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_128_1000_100_0_seqread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=1MB --numjobs=1 --rw=read --rwmixread=100 --group_reporting --name=testfile --output=fio_128_1_1_100_0_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_1_1_100_0_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=1MB --numjobs=16 --rw=read --rwmixread=100 --group_reporting --name=testfile --output=fio_128_1_16_100_0_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_1_16_100_0_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=1MB --numjobs=64 --rw=read --rwmixread=100 --group_reporting --name=testfile --output=fio_128_1_64_100_0_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_1_64_100_0_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=1MB --numjobs=256 --rw=read --rwmixread=100 --group_reporting --name=testfile --output=fio_128_1_256_100_0_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_1_256_100_0_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=1MB --numjobs=1000 --rw=read --rwmixread=100 --group_reporting --name=testfile --output=fio_128_1_1000_100_0_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_1_1000_100_0_seqread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=100MB --numjobs=1 --rw=read --rwmixread=100 --group_reporting --name=testfile --output=fio_128_100_1_100_0_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_100_1_100_0_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=100MB --numjobs=16 --rw=read --rwmixread=100 --group_reporting --name=testfile --output=fio_128_100_16_100_0_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_100_16_100_0_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=100MB --numjobs=64 --rw=read --rwmixread=100 --group_reporting --name=testfile --output=fio_128_100_64_100_0_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_100_64_100_0_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=100MB --numjobs=256 --rw=read --rwmixread=100 --group_reporting --name=testfile --output=fio_128_100_256_100_0_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_100_256_100_0_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=100MB --numjobs=1000 --rw=read --rwmixread=100 --group_reporting --name=testfile --output=fio_128_100_1000_100_0_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_100_1000_100_0_seqread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=1MB --numjobs=1 --rw=read --rwmixread=100 --group_reporting --name=testfile --output=fio_1_1_1_100_0_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_1_1_100_0_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=1MB --numjobs=16 --rw=read --rwmixread=100 --group_reporting --name=testfile --output=fio_1_1_16_100_0_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_1_16_100_0_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=1MB --numjobs=64 --rw=read --rwmixread=100 --group_reporting --name=testfile --output=fio_1_1_64_100_0_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_1_64_100_0_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=1MB --numjobs=256 --rw=read --rwmixread=100 --group_reporting --name=testfile --output=fio_1_1_256_100_0_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_1_256_100_0_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=1MB --numjobs=1000 --rw=read --rwmixread=100 --group_reporting --name=testfile --output=fio_1_1_1000_100_0_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_1_1000_100_0_seqread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=100MB --numjobs=1 --rw=read --rwmixread=100 --group_reporting --name=testfile --output=fio_1_100_1_100_0_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_100_1_100_0_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=100MB --numjobs=16 --rw=read --rwmixread=100 --group_reporting --name=testfile --output=fio_1_100_16_100_0_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_100_16_100_0_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=100MB --numjobs=64 --rw=read --rwmixread=100 --group_reporting --name=testfile --output=fio_1_100_64_100_0_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_100_64_100_0_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=100MB --numjobs=256 --rw=read --rwmixread=100 --group_reporting --name=testfile --output=fio_1_100_256_100_0_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_100_256_100_0_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=100MB --numjobs=1000 --rw=read --rwmixread=100 --group_reporting --name=testfile --output=fio_1_100_1000_100_0_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_100_1000_100_0_seqread.sh


#Read-to-Write: 100/0 Random
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=4KB --numjobs=1 --rw=randread --rwmixread=100 --group_reporting --name=testfile --output=fio_4_4_1_100_0_randread_output.txt --output-format=json --time_based --runtime=300 --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_4_1_100_0_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=4KB --numjobs=16 --rw=randread --rwmixread=100 --group_reporting --name=testfile --output=fio_4_4_16_100_0_randread_output.txt --output-format=json --time_based --runtime=300 --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_4_16_100_0_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=4KB --numjobs=64 --rw=randread --rwmixread=100 --group_reporting --name=testfile --output=fio_4_4_64_100_0_randread_output.txt --output-format=json --time_based --runtime=300 --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_4_64_100_0_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=4KB --numjobs=256 --rw=randread --rwmixread=100 --group_reporting --name=testfile --output=fio_4_4_256_100_0_randread_output.txt --output-format=json --time_based --runtime=300 --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_4_256_100_0_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=4KB --numjobs=1000 --rw=randread --rwmixread=100 --group_reporting --name=testfile --output=fio_4_4_1000_100_0_randread_output.txt --output-format=json --time_based --runtime=300 --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_4_1000_100_0_randread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=1MB --numjobs=1 --rw=randread --rwmixread=100 --group_reporting --name=testfile --output=fio_4_1_1_100_0_randread_output.txt --output-format=json --time_based --runtime=300 --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_1_1_100_0_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=1MB --numjobs=16 --rw=randread --rwmixread=100 --group_reporting --name=testfile --output=fio_4_1_16_100_0_randread_output.txt --output-format=json --time_based --runtime=300 --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_1_16_100_0_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=1MB --numjobs=64 --rw=randread --rwmixread=100 --group_reporting --name=testfile --output=fio_4_1_64_100_0_randread_output.txt --output-format=json --time_based --runtime=300 --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_1_64_100_0_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=1MB --numjobs=256 --rw=randread --rwmixread=100 --group_reporting --name=testfile --output=fio_4_1_256_100_0_randread_output.txt --output-format=json --time_based --runtime=300 --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_1_256_100_0_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=1MB --numjobs=1000 --rw=randread --rwmixread=100 --group_reporting --name=testfile --output=fio_4_1_1000_100_0_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_1_1000_100_0_randread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=100MB --numjobs=1 --rw=randread --rwmixread=100 --group_reporting --name=testfile --output=fio_4_100_1_100_0_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_100_1_100_0_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=100MB --numjobs=16 --rw=randread --rwmixread=100 --group_reporting --name=testfile --output=fio_4_100_16_100_0_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_100_16_100_0_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=100MB --numjobs=64 --rw=randread --rwmixread=100 --group_reporting --name=testfile --output=fio_4_100_64_100_0_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_100_64_100_0_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=100MB --numjobs=256 --rw=randread --rwmixread=100 --group_reporting --name=testfile --output=fio_4_100_256_100_0_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_100_256_100_0_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=100MB --numjobs=1000 --rw=randread --rwmixread=100 --group_reporting --name=testfile --output=fio_4_100_1000_100_0_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_100_1000_100_0_randread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=32KB --numjobs=1 --rw=randread --rwmixread=100 --group_reporting --name=testfile --output=fio_32_32_1_100_0_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_32_1_100_0_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=32KB --numjobs=16 --rw=randread --rwmixread=100 --group_reporting --name=testfile --output=fio_32_32_16_100_0_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_32_16_100_0_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=32KB --numjobs=64 --rw=randread --rwmixread=100 --group_reporting --name=testfile --output=fio_32_32_64_100_0_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_32_64_100_0_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=32KB --numjobs=256 --rw=randread --rwmixread=100 --group_reporting --name=testfile --output=fio_32_32_256_100_0_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_32_256_100_0_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=32KB --numjobs=1000 --rw=randread --rwmixread=100 --group_reporting --name=testfile --output=fio_32_32_1000_100_0_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_32_1000_100_0_randread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=1MB --numjobs=1 --rw=randread --rwmixread=100 --group_reporting --name=testfile --output=fio_32_1_1_100_0_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_1_1_100_0_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=1MB --numjobs=16 --rw=randread --rwmixread=100 --group_reporting --name=testfile --output=fio_32_1_16_100_0_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_1_16_100_0_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=1MB --numjobs=64 --rw=randread --rwmixread=100 --group_reporting --name=testfile --output=fio_32_1_64_100_0_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_1_64_100_0_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=1MB --numjobs=256 --rw=randread --rwmixread=100 --group_reporting --name=testfile --output=fio_32_1_256_100_0_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_1_256_100_0_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=1MB --numjobs=1000 --rw=randread --rwmixread=100 --group_reporting --name=testfile --output=fio_32_1_1000_100_0_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_1_1000_100_0_randread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=100MB --numjobs=1 --rw=randread --rwmixread=100 --group_reporting --name=testfile --output=fio_32_100_1_100_0_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_100_1_100_0_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=100MB --numjobs=16 --rw=randread --rwmixread=100 --group_reporting --name=testfile --output=fio_32_100_16_100_0_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_100_16_100_0_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=100MB --numjobs=64 --rw=randread --rwmixread=100 --group_reporting --name=testfile --output=fio_32_100_64_100_0_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_100_64_100_0_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=100MB --numjobs=256 --rw=randread --rwmixread=100 --group_reporting --name=testfile --output=fio_32_100_256_100_0_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_100_256_100_0_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=100MB --numjobs=1000 --rw=randread --rwmixread=100 --group_reporting --name=testfile --output=fio_32_100_1000_100_0_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_100_1000_100_0_randread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=128KB --numjobs=1 --rw=randread --rwmixread=100 --group_reporting --name=testfile --output=fio_128_128_1_100_0_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_128_1_100_0_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=128KB --numjobs=16 --rw=randread --rwmixread=100 --group_reporting --name=testfile --output=fio_128_128_16_100_0_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_128_16_100_0_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=128KB --numjobs=64 --rw=randread --rwmixread=100 --group_reporting --name=testfile --output=fio_128_128_64_100_0_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_128_64_100_0_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=128KB --numjobs=256 --rw=randread --rwmixread=100 --group_reporting --name=testfile --output=fio_128_128_256_100_0_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_128_256_100_0_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=128KB --numjobs=1000 --rw=randread --rwmixread=100 --group_reporting --name=testfile --output=fio_128_128_1000_100_0_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_128_1000_100_0_randread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=1MB --numjobs=1 --rw=randread --rwmixread=100 --group_reporting --name=testfile --output=fio_128_1_1_100_0_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_1_1_100_0_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=1MB --numjobs=16 --rw=randread --rwmixread=100 --group_reporting --name=testfile --output=fio_128_1_16_100_0_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_1_16_100_0_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=1MB --numjobs=64 --rw=randread --rwmixread=100 --group_reporting --name=testfile --output=fio_128_1_64_100_0_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_1_64_100_0_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=1MB --numjobs=256 --rw=randread --rwmixread=100 --group_reporting --name=testfile --output=fio_128_1_256_100_0_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_1_256_100_0_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=1MB --numjobs=1000 --rw=randread --rwmixread=100 --group_reporting --name=testfile --output=fio_128_1_1000_100_0_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_1_1000_100_0_randread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=100MB --numjobs=1 --rw=randread --rwmixread=100 --group_reporting --name=testfile --output=fio_128_100_1_100_0_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_100_1_100_0_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=100MB --numjobs=16 --rw=randread --rwmixread=100 --group_reporting --name=testfile --output=fio_128_100_16_100_0_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_100_16_100_0_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=100MB --numjobs=64 --rw=randread --rwmixread=100 --group_reporting --name=testfile --output=fio_128_100_64_100_0_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_100_64_100_0_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=100MB --numjobs=256 --rw=randread --rwmixread=100 --group_reporting --name=testfile --output=fio_128_100_256_100_0_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_100_256_100_0_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=100MB --numjobs=1000 --rw=randread --rwmixread=100 --group_reporting --name=testfile --output=fio_128_100_1000_100_0_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_100_1000_100_0_randread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=1MB --numjobs=1 --rw=randread --rwmixread=100 --group_reporting --name=testfile --output=fio_1_1_1_100_0_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_1_1_100_0_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=1MB --numjobs=16 --rw=randread --rwmixread=100 --group_reporting --name=testfile --output=fio_1_1_16_100_0_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_1_16_100_0_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=1MB --numjobs=64 --rw=randread --rwmixread=100 --group_reporting --name=testfile --output=fio_1_1_64_100_0_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_1_64_100_0_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=1MB --numjobs=256 --rw=randread --rwmixread=100 --group_reporting --name=testfile --output=fio_1_1_256_100_0_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_1_256_100_0_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=1MB --numjobs=1000 --rw=randread --rwmixread=100 --group_reporting --name=testfile --output=fio_1_1_1000_100_0_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_1_1000_100_0_randread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=100MB --numjobs=1 --rw=randread --rwmixread=100 --group_reporting --name=testfile --output=fio_1_100_1_100_0_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_100_1_100_0_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=100MB --numjobs=16 --rw=randread --rwmixread=100 --group_reporting --name=testfile --output=fio_1_100_16_100_0_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_100_16_100_0_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=100MB --numjobs=64 --rw=randread --rwmixread=100 --group_reporting --name=testfile --output=fio_1_100_64_100_0_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_100_64_100_0_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=100MB --numjobs=256 --rw=randread --rwmixread=100 --group_reporting --name=testfile --output=fio_1_100_256_100_0_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_100_256_100_0_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=100MB --numjobs=1000 --rw=randread --rwmixread=100 --group_reporting --name=testfile --output=fio_1_100_1000_100_0_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_100_1000_100_0_randread.sh

#Read-to-Write: 80/20 Random
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=4KB --numjobs=1 --rw=randread --rwmixread=80 --group_reporting --name=testfile --output=fio_4_4_1_80_20_randread_output.txt --output-format=json --time_based --runtime=300 --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_4_1_80_20_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=4KB --numjobs=16 --rw=randread --rwmixread=80 --group_reporting --name=testfile --output=fio_4_4_16_80_20_randread_output.txt --output-format=json --time_based --runtime=300 --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_4_16_80_20_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=4KB --numjobs=64 --rw=randread --rwmixread=80 --group_reporting --name=testfile --output=fio_4_4_64_80_20_randread_output.txt --output-format=json --time_based --runtime=300 --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_4_64_80_20_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=4KB --numjobs=256 --rw=randread --rwmixread=80 --group_reporting --name=testfile --output=fio_4_4_256_80_20_randread_output.txt --output-format=json --time_based --runtime=300 --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_4_256_80_20_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=4KB --numjobs=1000 --rw=randread --rwmixread=80 --group_reporting --name=testfile --output=fio_4_4_1000_80_20_randread_output.txt --output-format=json --time_based --runtime=300 --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_4_1000_80_20_randread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=1MB --numjobs=1 --rw=randread --rwmixread=80 --group_reporting --name=testfile --output=fio_4_1_1_80_20_randread_output.txt --output-format=json --time_based --runtime=300 --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_1_1_80_20_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=1MB --numjobs=16 --rw=randread --rwmixread=80 --group_reporting --name=testfile --output=fio_4_1_16_80_20_randread_output.txt --output-format=json --time_based --runtime=300 --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_1_16_80_20_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=1MB --numjobs=64 --rw=randread --rwmixread=80 --group_reporting --name=testfile --output=fio_4_1_64_80_20_randread_output.txt --output-format=json --time_based --runtime=300 --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_1_64_80_20_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=1MB --numjobs=256 --rw=randread --rwmixread=80 --group_reporting --name=testfile --output=fio_4_1_256_80_20_randread_output.txt --output-format=json --time_based --runtime=300 --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_1_256_80_20_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=1MB --numjobs=1000 --rw=randread --rwmixread=80 --group_reporting --name=testfile --output=fio_4_1_1000_80_20_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_1_1000_80_20_randread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=100MB --numjobs=1 --rw=randread --rwmixread=80 --group_reporting --name=testfile --output=fio_4_100_1_80_20_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_100_1_80_20_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=100MB --numjobs=16 --rw=randread --rwmixread=80 --group_reporting --name=testfile --output=fio_4_100_16_80_20_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_100_16_80_20_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=100MB --numjobs=64 --rw=randread --rwmixread=80 --group_reporting --name=testfile --output=fio_4_100_64_80_20_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_100_64_80_20_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=100MB --numjobs=256 --rw=randread --rwmixread=80 --group_reporting --name=testfile --output=fio_4_100_256_80_20_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_100_256_80_20_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=100MB --numjobs=1000 --rw=randread --rwmixread=80 --group_reporting --name=testfile --output=fio_4_100_1000_80_20_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_100_1000_80_20_randread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=32KB --numjobs=1 --rw=randread --rwmixread=80 --group_reporting --name=testfile --output=fio_32_32_1_80_20_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_32_1_80_20_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=32KB --numjobs=16 --rw=randread --rwmixread=80 --group_reporting --name=testfile --output=fio_32_32_16_80_20_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_32_16_80_20_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=32KB --numjobs=64 --rw=randread --rwmixread=80 --group_reporting --name=testfile --output=fio_32_32_64_80_20_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_32_64_80_20_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=32KB --numjobs=256 --rw=randread --rwmixread=80 --group_reporting --name=testfile --output=fio_32_32_256_80_20_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_32_256_80_20_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=32KB --numjobs=1000 --rw=randread --rwmixread=80 --group_reporting --name=testfile --output=fio_32_32_1000_80_20_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_32_1000_80_20_randread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=1MB --numjobs=1 --rw=randread --rwmixread=80 --group_reporting --name=testfile --output=fio_32_1_1_80_20_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_1_1_80_20_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=1MB --numjobs=16 --rw=randread --rwmixread=80 --group_reporting --name=testfile --output=fio_32_1_16_80_20_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_1_16_80_20_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=1MB --numjobs=64 --rw=randread --rwmixread=80 --group_reporting --name=testfile --output=fio_32_1_64_80_20_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_1_64_80_20_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=1MB --numjobs=256 --rw=randread --rwmixread=80 --group_reporting --name=testfile --output=fio_32_1_256_80_20_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_1_256_80_20_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=1MB --numjobs=1000 --rw=randread --rwmixread=80 --group_reporting --name=testfile --output=fio_32_1_1000_80_20_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_1_1000_80_20_randread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=100MB --numjobs=1 --rw=randread --rwmixread=80 --group_reporting --name=testfile --output=fio_32_100_1_80_20_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_100_1_80_20_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=100MB --numjobs=16 --rw=randread --rwmixread=80 --group_reporting --name=testfile --output=fio_32_100_16_80_20_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_100_16_80_20_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=100MB --numjobs=64 --rw=randread --rwmixread=80 --group_reporting --name=testfile --output=fio_32_100_64_80_20_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_100_64_80_20_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=100MB --numjobs=256 --rw=randread --rwmixread=80 --group_reporting --name=testfile --output=fio_32_100_256_80_20_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_100_256_80_20_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=100MB --numjobs=1000 --rw=randread --rwmixread=80 --group_reporting --name=testfile --output=fio_32_100_1000_80_20_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_100_1000_80_20_randread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=128KB --numjobs=1 --rw=randread --rwmixread=80 --group_reporting --name=testfile --output=fio_128_128_1_80_20_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_128_1_80_20_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=128KB --numjobs=16 --rw=randread --rwmixread=80 --group_reporting --name=testfile --output=fio_128_128_16_80_20_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_128_16_80_20_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=128KB --numjobs=64 --rw=randread --rwmixread=80 --group_reporting --name=testfile --output=fio_128_128_64_80_20_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_128_64_80_20_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=128KB --numjobs=256 --rw=randread --rwmixread=80 --group_reporting --name=testfile --output=fio_128_128_256_80_20_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_128_256_80_20_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=128KB --numjobs=1000 --rw=randread --rwmixread=80 --group_reporting --name=testfile --output=fio_128_128_1000_80_20_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_128_1000_80_20_randread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=1MB --numjobs=1 --rw=randread --rwmixread=80 --group_reporting --name=testfile --output=fio_128_1_1_80_20_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_1_1_80_20_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=1MB --numjobs=16 --rw=randread --rwmixread=80 --group_reporting --name=testfile --output=fio_128_1_16_80_20_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_1_16_80_20_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=1MB --numjobs=64 --rw=randread --rwmixread=80 --group_reporting --name=testfile --output=fio_128_1_64_80_20_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_1_64_80_20_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=1MB --numjobs=256 --rw=randread --rwmixread=80 --group_reporting --name=testfile --output=fio_128_1_256_80_20_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_1_256_80_20_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=1MB --numjobs=1000 --rw=randread --rwmixread=80 --group_reporting --name=testfile --output=fio_128_1_1000_80_20_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_1_1000_80_20_randread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=100MB --numjobs=1 --rw=randread --rwmixread=80 --group_reporting --name=testfile --output=fio_128_100_1_80_20_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_100_1_80_20_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=100MB --numjobs=16 --rw=randread --rwmixread=80 --group_reporting --name=testfile --output=fio_128_100_16_80_20_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_100_16_80_20_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=100MB --numjobs=64 --rw=randread --rwmixread=80 --group_reporting --name=testfile --output=fio_128_100_64_80_20_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_100_64_80_20_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=100MB --numjobs=256 --rw=randread --rwmixread=80 --group_reporting --name=testfile --output=fio_128_100_256_80_20_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_100_256_80_20_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=100MB --numjobs=1000 --rw=randread --rwmixread=80 --group_reporting --name=testfile --output=fio_128_100_1000_80_20_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_100_1000_80_20_randread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=1MB --numjobs=1 --rw=randread --rwmixread=80 --group_reporting --name=testfile --output=fio_1_1_1_80_20_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_1_1_80_20_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=1MB --numjobs=16 --rw=randread --rwmixread=80 --group_reporting --name=testfile --output=fio_1_1_16_80_20_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_1_16_80_20_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=1MB --numjobs=64 --rw=randread --rwmixread=80 --group_reporting --name=testfile --output=fio_1_1_64_80_20_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_1_64_80_20_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=1MB --numjobs=256 --rw=randread --rwmixread=80 --group_reporting --name=testfile --output=fio_1_1_256_80_20_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_1_256_80_20_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=1MB --numjobs=1000 --rw=randread --rwmixread=80 --group_reporting --name=testfile --output=fio_1_1_1000_80_20_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_1_1000_80_20_randread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=100MB --numjobs=1 --rw=randread --rwmixread=80 --group_reporting --name=testfile --output=fio_1_100_1_80_20_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_100_1_80_20_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=100MB --numjobs=16 --rw=randread --rwmixread=80 --group_reporting --name=testfile --output=fio_1_100_16_80_20_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_100_16_80_20_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=100MB --numjobs=64 --rw=randread --rwmixread=80 --group_reporting --name=testfile --output=fio_1_100_64_80_20_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_100_64_80_20_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=100MB --numjobs=256 --rw=randread --rwmixread=80 --group_reporting --name=testfile --output=fio_1_100_256_80_20_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_100_256_80_20_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=100MB --numjobs=1000 --rw=randread --rwmixread=80 --group_reporting --name=testfile --output=fio_1_100_1000_80_20_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_100_1000_80_20_randread.sh

#Read-to-Write: 50/50 Random
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=4KB --numjobs=1 --rw=randread --rwmixread=50 --group_reporting --name=testfile --output=fio_4_4_1_50_50_randread_output.txt --output-format=json --time_based --runtime=300 --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_4_1_50_50_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=4KB --numjobs=16 --rw=randread --rwmixread=50 --group_reporting --name=testfile --output=fio_4_4_16_50_50_randread_output.txt --output-format=json --time_based --runtime=300 --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_4_16_50_50_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=4KB --numjobs=64 --rw=randread --rwmixread=50 --group_reporting --name=testfile --output=fio_4_4_64_50_50_randread_output.txt --output-format=json --time_based --runtime=300 --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_4_64_50_50_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=4KB --numjobs=256 --rw=randread --rwmixread=50 --group_reporting --name=testfile --output=fio_4_4_256_50_50_randread_output.txt --output-format=json --time_based --runtime=300 --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_4_256_50_50_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=4KB --numjobs=1000 --rw=randread --rwmixread=50 --group_reporting --name=testfile --output=fio_4_4_1000_50_50_randread_output.txt --output-format=json --time_based --runtime=300 --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_4_1000_50_50_randread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=1MB --numjobs=1 --rw=randread --rwmixread=50 --group_reporting --name=testfile --output=fio_4_1_1_50_50_randread_output.txt --output-format=json --time_based --runtime=300 --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_1_1_50_50_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=1MB --numjobs=16 --rw=randread --rwmixread=50 --group_reporting --name=testfile --output=fio_4_1_16_50_50_randread_output.txt --output-format=json --time_based --runtime=300 --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_1_16_50_50_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=1MB --numjobs=64 --rw=randread --rwmixread=50 --group_reporting --name=testfile --output=fio_4_1_64_50_50_randread_output.txt --output-format=json --time_based --runtime=300 --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_1_64_50_50_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=1MB --numjobs=256 --rw=randread --rwmixread=50 --group_reporting --name=testfile --output=fio_4_1_256_50_50_randread_output.txt --output-format=json --time_based --runtime=300 --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_1_256_50_50_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=1MB --numjobs=1000 --rw=randread --rwmixread=50 --group_reporting --name=testfile --output=fio_4_1_1000_50_50_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_1_1000_50_50_randread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=100MB --numjobs=1 --rw=randread --rwmixread=50 --group_reporting --name=testfile --output=fio_4_100_1_50_50_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_100_1_50_50_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=100MB --numjobs=16 --rw=randread --rwmixread=50 --group_reporting --name=testfile --output=fio_4_100_16_50_50_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_100_16_50_50_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=100MB --numjobs=64 --rw=randread --rwmixread=50 --group_reporting --name=testfile --output=fio_4_100_64_50_50_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_100_64_50_50_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=100MB --numjobs=256 --rw=randread --rwmixread=50 --group_reporting --name=testfile --output=fio_4_100_256_50_50_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_100_256_50_50_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=100MB --numjobs=1000 --rw=randread --rwmixread=50 --group_reporting --name=testfile --output=fio_4_100_1000_50_50_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_100_1000_50_50_randread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=32KB --numjobs=1 --rw=randread --rwmixread=50 --group_reporting --name=testfile --output=fio_32_32_1_50_50_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_32_1_50_50_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=32KB --numjobs=16 --rw=randread --rwmixread=50 --group_reporting --name=testfile --output=fio_32_32_16_50_50_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_32_16_50_50_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=32KB --numjobs=64 --rw=randread --rwmixread=50 --group_reporting --name=testfile --output=fio_32_32_64_50_50_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_32_64_50_50_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=32KB --numjobs=256 --rw=randread --rwmixread=50 --group_reporting --name=testfile --output=fio_32_32_256_50_50_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_32_256_50_50_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=32KB --numjobs=1000 --rw=randread --rwmixread=50 --group_reporting --name=testfile --output=fio_32_32_1000_50_50_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_32_1000_50_50_randread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=1MB --numjobs=1 --rw=randread --rwmixread=50 --group_reporting --name=testfile --output=fio_32_1_1_50_50_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_1_1_50_50_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=1MB --numjobs=16 --rw=randread --rwmixread=50 --group_reporting --name=testfile --output=fio_32_1_16_50_50_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_1_16_50_50_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=1MB --numjobs=64 --rw=randread --rwmixread=50 --group_reporting --name=testfile --output=fio_32_1_64_50_50_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_1_64_50_50_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=1MB --numjobs=256 --rw=randread --rwmixread=50 --group_reporting --name=testfile --output=fio_32_1_256_50_50_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_1_256_50_50_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=1MB --numjobs=1000 --rw=randread --rwmixread=50 --group_reporting --name=testfile --output=fio_32_1_1000_50_50_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_1_1000_50_50_randread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=100MB --numjobs=1 --rw=randread --rwmixread=50 --group_reporting --name=testfile --output=fio_32_100_1_50_50_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_100_1_50_50_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=100MB --numjobs=16 --rw=randread --rwmixread=50 --group_reporting --name=testfile --output=fio_32_100_16_50_50_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_100_16_50_50_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=100MB --numjobs=64 --rw=randread --rwmixread=50 --group_reporting --name=testfile --output=fio_32_100_64_50_50_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_100_64_50_50_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=100MB --numjobs=256 --rw=randread --rwmixread=50 --group_reporting --name=testfile --output=fio_32_100_256_50_50_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_100_256_50_50_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=100MB --numjobs=1000 --rw=randread --rwmixread=50 --group_reporting --name=testfile --output=fio_32_100_1000_50_50_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_100_1000_50_50_randread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=128KB --numjobs=1 --rw=randread --rwmixread=50 --group_reporting --name=testfile --output=fio_128_128_1_50_50_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_128_1_50_50_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=128KB --numjobs=16 --rw=randread --rwmixread=50 --group_reporting --name=testfile --output=fio_128_128_16_50_50_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_128_16_50_50_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=128KB --numjobs=64 --rw=randread --rwmixread=50 --group_reporting --name=testfile --output=fio_128_128_64_50_50_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_128_64_50_50_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=128KB --numjobs=256 --rw=randread --rwmixread=50 --group_reporting --name=testfile --output=fio_128_128_256_50_50_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_128_256_50_50_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=128KB --numjobs=1000 --rw=randread --rwmixread=50 --group_reporting --name=testfile --output=fio_128_128_1000_50_50_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_128_1000_50_50_randread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=1MB --numjobs=1 --rw=randread --rwmixread=50 --group_reporting --name=testfile --output=fio_128_1_1_50_50_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_1_1_50_50_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=1MB --numjobs=16 --rw=randread --rwmixread=50 --group_reporting --name=testfile --output=fio_128_1_16_50_50_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_1_16_50_50_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=1MB --numjobs=64 --rw=randread --rwmixread=50 --group_reporting --name=testfile --output=fio_128_1_64_50_50_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_1_64_50_50_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=1MB --numjobs=256 --rw=randread --rwmixread=50 --group_reporting --name=testfile --output=fio_128_1_256_50_50_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_1_256_50_50_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=1MB --numjobs=1000 --rw=randread --rwmixread=50 --group_reporting --name=testfile --output=fio_128_1_1000_50_50_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_1_1000_50_50_randread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=100MB --numjobs=1 --rw=randread --rwmixread=50 --group_reporting --name=testfile --output=fio_128_100_1_50_50_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_100_1_50_50_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=100MB --numjobs=16 --rw=randread --rwmixread=50 --group_reporting --name=testfile --output=fio_128_100_16_50_50_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_100_16_50_50_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=100MB --numjobs=64 --rw=randread --rwmixread=50 --group_reporting --name=testfile --output=fio_128_100_64_50_50_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_100_64_50_50_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=100MB --numjobs=256 --rw=randread --rwmixread=50 --group_reporting --name=testfile --output=fio_128_100_256_50_50_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_100_256_50_50_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=100MB --numjobs=1000 --rw=randread --rwmixread=50 --group_reporting --name=testfile --output=fio_128_100_1000_50_50_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_100_1000_50_50_randread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=1MB --numjobs=1 --rw=randread --rwmixread=50 --group_reporting --name=testfile --output=fio_1_1_1_50_50_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_1_1_50_50_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=1MB --numjobs=16 --rw=randread --rwmixread=50 --group_reporting --name=testfile --output=fio_1_1_16_50_50_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_1_16_50_50_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=1MB --numjobs=64 --rw=randread --rwmixread=50 --group_reporting --name=testfile --output=fio_1_1_64_50_50_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_1_64_50_50_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=1MB --numjobs=256 --rw=randread --rwmixread=50 --group_reporting --name=testfile --output=fio_1_1_256_50_50_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_1_256_50_50_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=1MB --numjobs=1000 --rw=randread --rwmixread=50 --group_reporting --name=testfile --output=fio_1_1_1000_50_50_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_1_1000_50_50_randread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=100MB --numjobs=1 --rw=randread --rwmixread=50 --group_reporting --name=testfile --output=fio_1_100_1_50_50_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_100_1_50_50_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=100MB --numjobs=16 --rw=randread --rwmixread=50 --group_reporting --name=testfile --output=fio_1_100_16_50_50_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_100_16_50_50_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=100MB --numjobs=64 --rw=randread --rwmixread=50 --group_reporting --name=testfile --output=fio_1_100_64_50_50_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_100_64_50_50_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=100MB --numjobs=256 --rw=randread --rwmixread=50 --group_reporting --name=testfile --output=fio_1_100_256_50_50_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_100_256_50_50_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=100MB --numjobs=1000 --rw=randread --rwmixread=50 --group_reporting --name=testfile --output=fio_1_100_1000_50_50_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_100_1000_50_50_randread.sh

#Read-to-Write: 20/80 Random
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=4KB --numjobs=1 --rw=randread --rwmixread=20 --group_reporting --name=testfile --output=fio_4_4_1_20_80_randread_output.txt --output-format=json --time_based --runtime=300 --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_4_1_20_80_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=4KB --numjobs=16 --rw=randread --rwmixread=20 --group_reporting --name=testfile --output=fio_4_4_16_20_80_randread_output.txt --output-format=json --time_based --runtime=300 --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_4_16_20_80_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=4KB --numjobs=64 --rw=randread --rwmixread=20 --group_reporting --name=testfile --output=fio_4_4_64_20_80_randread_output.txt --output-format=json --time_based --runtime=300 --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_4_64_20_80_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=4KB --numjobs=256 --rw=randread --rwmixread=20 --group_reporting --name=testfile --output=fio_4_4_256_20_80_randread_output.txt --output-format=json --time_based --runtime=300 --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_4_256_20_80_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=4KB --numjobs=1000 --rw=randread --rwmixread=20 --group_reporting --name=testfile --output=fio_4_4_1000_20_80_randread_output.txt --output-format=json --time_based --runtime=300 --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_4_1000_20_80_randread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=1MB --numjobs=1 --rw=randread --rwmixread=20 --group_reporting --name=testfile --output=fio_4_1_1_20_80_randread_output.txt --output-format=json --time_based --runtime=300 --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_1_1_20_80_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=1MB --numjobs=16 --rw=randread --rwmixread=20 --group_reporting --name=testfile --output=fio_4_1_16_20_80_randread_output.txt --output-format=json --time_based --runtime=300 --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_1_16_20_80_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=1MB --numjobs=64 --rw=randread --rwmixread=20 --group_reporting --name=testfile --output=fio_4_1_64_20_80_randread_output.txt --output-format=json --time_based --runtime=300 --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_1_64_20_80_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=1MB --numjobs=256 --rw=randread --rwmixread=20 --group_reporting --name=testfile --output=fio_4_1_256_20_80_randread_output.txt --output-format=json --time_based --runtime=300 --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_1_256_20_80_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=1MB --numjobs=1000 --rw=randread --rwmixread=20 --group_reporting --name=testfile --output=fio_4_1_1000_20_80_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_1_1000_20_80_randread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=100MB --numjobs=1 --rw=randread --rwmixread=20 --group_reporting --name=testfile --output=fio_4_100_1_20_80_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_100_1_20_80_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=100MB --numjobs=16 --rw=randread --rwmixread=20 --group_reporting --name=testfile --output=fio_4_100_16_20_80_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_100_16_20_80_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=100MB --numjobs=64 --rw=randread --rwmixread=20 --group_reporting --name=testfile --output=fio_4_100_64_20_80_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_100_64_20_80_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=100MB --numjobs=256 --rw=randread --rwmixread=20 --group_reporting --name=testfile --output=fio_4_100_256_20_80_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_100_256_20_80_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=100MB --numjobs=1000 --rw=randread --rwmixread=20 --group_reporting --name=testfile --output=fio_4_100_1000_20_80_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_100_1000_20_80_randread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=32KB --numjobs=1 --rw=randread --rwmixread=20 --group_reporting --name=testfile --output=fio_32_32_1_20_80_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_32_1_20_80_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=32KB --numjobs=16 --rw=randread --rwmixread=20 --group_reporting --name=testfile --output=fio_32_32_16_20_80_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_32_16_20_80_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=32KB --numjobs=64 --rw=randread --rwmixread=20 --group_reporting --name=testfile --output=fio_32_32_64_20_80_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_32_64_20_80_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=32KB --numjobs=256 --rw=randread --rwmixread=20 --group_reporting --name=testfile --output=fio_32_32_256_20_80_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_32_256_20_80_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=32KB --numjobs=1000 --rw=randread --rwmixread=20 --group_reporting --name=testfile --output=fio_32_32_1000_20_80_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_32_1000_20_80_randread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=1MB --numjobs=1 --rw=randread --rwmixread=20 --group_reporting --name=testfile --output=fio_32_1_1_20_80_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_1_1_20_80_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=1MB --numjobs=16 --rw=randread --rwmixread=20 --group_reporting --name=testfile --output=fio_32_1_16_20_80_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_1_16_20_80_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=1MB --numjobs=64 --rw=randread --rwmixread=20 --group_reporting --name=testfile --output=fio_32_1_64_20_80_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_1_64_20_80_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=1MB --numjobs=256 --rw=randread --rwmixread=20 --group_reporting --name=testfile --output=fio_32_1_256_20_80_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_1_256_20_80_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=1MB --numjobs=1000 --rw=randread --rwmixread=20 --group_reporting --name=testfile --output=fio_32_1_1000_20_80_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_1_1000_20_80_randread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=100MB --numjobs=1 --rw=randread --rwmixread=20 --group_reporting --name=testfile --output=fio_32_100_1_20_80_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_100_1_20_80_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=100MB --numjobs=16 --rw=randread --rwmixread=20 --group_reporting --name=testfile --output=fio_32_100_16_20_80_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_100_16_20_80_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=100MB --numjobs=64 --rw=randread --rwmixread=20 --group_reporting --name=testfile --output=fio_32_100_64_20_80_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_100_64_20_80_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=100MB --numjobs=256 --rw=randread --rwmixread=20 --group_reporting --name=testfile --output=fio_32_100_256_20_80_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_100_256_20_80_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=100MB --numjobs=1000 --rw=randread --rwmixread=20 --group_reporting --name=testfile --output=fio_32_100_1000_20_80_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_100_1000_20_80_randread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=128KB --numjobs=1 --rw=randread --rwmixread=20 --group_reporting --name=testfile --output=fio_128_128_1_20_80_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_128_1_20_80_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=128KB --numjobs=16 --rw=randread --rwmixread=20 --group_reporting --name=testfile --output=fio_128_128_16_20_80_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_128_16_20_80_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=128KB --numjobs=64 --rw=randread --rwmixread=20 --group_reporting --name=testfile --output=fio_128_128_64_20_80_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_128_64_20_80_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=128KB --numjobs=256 --rw=randread --rwmixread=20 --group_reporting --name=testfile --output=fio_128_128_256_20_80_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_128_256_20_80_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=128KB --numjobs=1000 --rw=randread --rwmixread=20 --group_reporting --name=testfile --output=fio_128_128_1000_20_80_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_128_1000_20_80_randread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=1MB --numjobs=1 --rw=randread --rwmixread=20 --group_reporting --name=testfile --output=fio_128_1_1_20_80_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_1_1_20_80_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=1MB --numjobs=16 --rw=randread --rwmixread=20 --group_reporting --name=testfile --output=fio_128_1_16_20_80_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_1_16_20_80_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=1MB --numjobs=64 --rw=randread --rwmixread=20 --group_reporting --name=testfile --output=fio_128_1_64_20_80_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_1_64_20_80_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=1MB --numjobs=256 --rw=randread --rwmixread=20 --group_reporting --name=testfile --output=fio_128_1_256_20_80_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_1_256_20_80_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=1MB --numjobs=1000 --rw=randread --rwmixread=20 --group_reporting --name=testfile --output=fio_128_1_1000_20_80_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_1_1000_20_80_randread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=100MB --numjobs=1 --rw=randread --rwmixread=20 --group_reporting --name=testfile --output=fio_128_100_1_20_80_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_100_1_20_80_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=100MB --numjobs=16 --rw=randread --rwmixread=20 --group_reporting --name=testfile --output=fio_128_100_16_20_80_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_100_16_20_80_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=100MB --numjobs=64 --rw=randread --rwmixread=20 --group_reporting --name=testfile --output=fio_128_100_64_20_80_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_100_64_20_80_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=100MB --numjobs=256 --rw=randread --rwmixread=20 --group_reporting --name=testfile --output=fio_128_100_256_20_80_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_100_256_20_80_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=100MB --numjobs=1000 --rw=randread --rwmixread=20 --group_reporting --name=testfile --output=fio_128_100_1000_20_80_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_100_1000_20_80_randread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=1MB --numjobs=1 --rw=randread --rwmixread=20 --group_reporting --name=testfile --output=fio_1_1_1_20_80_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_1_1_20_80_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=1MB --numjobs=16 --rw=randread --rwmixread=20 --group_reporting --name=testfile --output=fio_1_1_16_20_80_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_1_16_20_80_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=1MB --numjobs=64 --rw=randread --rwmixread=20 --group_reporting --name=testfile --output=fio_1_1_64_20_80_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_1_64_20_80_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=1MB --numjobs=256 --rw=randread --rwmixread=20 --group_reporting --name=testfile --output=fio_1_1_256_20_80_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_1_256_20_80_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=1MB --numjobs=1000 --rw=randread --rwmixread=20 --group_reporting --name=testfile --output=fio_1_1_1000_20_80_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_1_1000_20_80_randread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=100MB --numjobs=1 --rw=randread --rwmixread=20 --group_reporting --name=testfile --output=fio_1_100_1_20_80_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_100_1_20_80_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=100MB --numjobs=16 --rw=randread --rwmixread=20 --group_reporting --name=testfile --output=fio_1_100_16_20_80_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_100_16_20_80_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=100MB --numjobs=64 --rw=randread --rwmixread=20 --group_reporting --name=testfile --output=fio_1_100_64_20_80_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_100_64_20_80_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=100MB --numjobs=256 --rw=randread --rwmixread=20 --group_reporting --name=testfile --output=fio_1_100_256_20_80_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_100_256_20_80_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=100MB --numjobs=1000 --rw=randread --rwmixread=20 --group_reporting --name=testfile --output=fio_1_100_1000_20_80_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_100_1000_20_80_randread.sh

#Read-to-Write: 0/100 Random
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=4KB --numjobs=1 --rw=randread --rwmixread=0 --group_reporting --name=testfile --output=fio_4_4_1_0_100_randread_output.txt --output-format=json --time_based --runtime=300 --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_4_1_0_100_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=4KB --numjobs=16 --rw=randread --rwmixread=0 --group_reporting --name=testfile --output=fio_4_4_16_0_100_randread_output.txt --output-format=json --time_based --runtime=300 --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_4_16_0_100_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=4KB --numjobs=64 --rw=randread --rwmixread=0 --group_reporting --name=testfile --output=fio_4_4_64_0_100_randread_output.txt --output-format=json --time_based --runtime=300 --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_4_64_0_100_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=4KB --numjobs=256 --rw=randread --rwmixread=0 --group_reporting --name=testfile --output=fio_4_4_256_0_100_randread_output.txt --output-format=json --time_based --runtime=300 --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_4_256_0_100_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=4KB --numjobs=1000 --rw=randread --rwmixread=0 --group_reporting --name=testfile --output=fio_4_4_1000_0_100_randread_output.txt --output-format=json --time_based --runtime=300 --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_4_1000_0_100_randread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=1MB --numjobs=1 --rw=randread --rwmixread=0 --group_reporting --name=testfile --output=fio_4_1_1_0_100_randread_output.txt --output-format=json --time_based --runtime=300 --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_1_1_0_100_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=1MB --numjobs=16 --rw=randread --rwmixread=0 --group_reporting --name=testfile --output=fio_4_1_16_0_100_randread_output.txt --output-format=json --time_based --runtime=300 --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_1_16_0_100_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=1MB --numjobs=64 --rw=randread --rwmixread=0 --group_reporting --name=testfile --output=fio_4_1_64_0_100_randread_output.txt --output-format=json --time_based --runtime=300 --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_1_64_0_100_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=1MB --numjobs=256 --rw=randread --rwmixread=0 --group_reporting --name=testfile --output=fio_4_1_256_0_100_randread_output.txt --output-format=json --time_based --runtime=300 --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_1_256_0_100_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=1MB --numjobs=1000 --rw=randread --rwmixread=0 --group_reporting --name=testfile --output=fio_4_1_1000_0_100_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_1_1000_0_100_randread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=100MB --numjobs=1 --rw=randread --rwmixread=0 --group_reporting --name=testfile --output=fio_4_100_1_0_100_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_100_1_0_100_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=100MB --numjobs=16 --rw=randread --rwmixread=0 --group_reporting --name=testfile --output=fio_4_100_16_0_100_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_100_16_0_100_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=100MB --numjobs=64 --rw=randread --rwmixread=0 --group_reporting --name=testfile --output=fio_4_100_64_0_100_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_100_64_0_100_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=100MB --numjobs=256 --rw=randread --rwmixread=0 --group_reporting --name=testfile --output=fio_4_100_256_0_100_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_100_256_0_100_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=100MB --numjobs=1000 --rw=randread --rwmixread=0 --group_reporting --name=testfile --output=fio_4_100_1000_0_100_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_100_1000_0_100_randread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=32KB --numjobs=1 --rw=randread --rwmixread=0 --group_reporting --name=testfile --output=fio_32_32_1_0_100_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_32_1_0_100_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=32KB --numjobs=16 --rw=randread --rwmixread=0 --group_reporting --name=testfile --output=fio_32_32_16_0_100_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_32_16_0_100_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=32KB --numjobs=64 --rw=randread --rwmixread=0 --group_reporting --name=testfile --output=fio_32_32_64_0_100_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_32_64_0_100_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=32KB --numjobs=256 --rw=randread --rwmixread=0 --group_reporting --name=testfile --output=fio_32_32_256_0_100_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_32_256_0_100_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=32KB --numjobs=1000 --rw=randread --rwmixread=0 --group_reporting --name=testfile --output=fio_32_32_1000_0_100_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_32_1000_0_100_randread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=1MB --numjobs=1 --rw=randread --rwmixread=0 --group_reporting --name=testfile --output=fio_32_1_1_0_100_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_1_1_0_100_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=1MB --numjobs=16 --rw=randread --rwmixread=0 --group_reporting --name=testfile --output=fio_32_1_16_0_100_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_1_16_0_100_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=1MB --numjobs=64 --rw=randread --rwmixread=0 --group_reporting --name=testfile --output=fio_32_1_64_0_100_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_1_64_0_100_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=1MB --numjobs=256 --rw=randread --rwmixread=0 --group_reporting --name=testfile --output=fio_32_1_256_0_100_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_1_256_0_100_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=1MB --numjobs=1000 --rw=randread --rwmixread=0 --group_reporting --name=testfile --output=fio_32_1_1000_0_100_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_1_1000_0_100_randread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=100MB --numjobs=1 --rw=randread --rwmixread=0 --group_reporting --name=testfile --output=fio_32_100_1_0_100_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_100_1_0_100_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=100MB --numjobs=16 --rw=randread --rwmixread=0 --group_reporting --name=testfile --output=fio_32_100_16_0_100_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_100_16_0_100_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=100MB --numjobs=64 --rw=randread --rwmixread=0 --group_reporting --name=testfile --output=fio_32_100_64_0_100_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_100_64_0_100_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=100MB --numjobs=256 --rw=randread --rwmixread=0 --group_reporting --name=testfile --output=fio_32_100_256_0_100_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_100_256_0_100_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=100MB --numjobs=1000 --rw=randread --rwmixread=0 --group_reporting --name=testfile --output=fio_32_100_1000_0_100_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_100_1000_0_100_randread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=128KB --numjobs=1 --rw=randread --rwmixread=0 --group_reporting --name=testfile --output=fio_128_128_1_0_100_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_128_1_0_100_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=128KB --numjobs=16 --rw=randread --rwmixread=0 --group_reporting --name=testfile --output=fio_128_128_16_0_100_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_128_16_0_100_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=128KB --numjobs=64 --rw=randread --rwmixread=0 --group_reporting --name=testfile --output=fio_128_128_64_0_100_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_128_64_0_100_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=128KB --numjobs=256 --rw=randread --rwmixread=0 --group_reporting --name=testfile --output=fio_128_128_256_0_100_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_128_256_0_100_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=128KB --numjobs=1000 --rw=randread --rwmixread=0 --group_reporting --name=testfile --output=fio_128_128_1000_0_100_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_128_1000_0_100_randread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=1MB --numjobs=1 --rw=randread --rwmixread=0 --group_reporting --name=testfile --output=fio_128_1_1_0_100_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_1_1_0_100_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=1MB --numjobs=16 --rw=randread --rwmixread=0 --group_reporting --name=testfile --output=fio_128_1_16_0_100_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_1_16_0_100_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=1MB --numjobs=64 --rw=randread --rwmixread=0 --group_reporting --name=testfile --output=fio_128_1_64_0_100_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_1_64_0_100_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=1MB --numjobs=256 --rw=randread --rwmixread=0 --group_reporting --name=testfile --output=fio_128_1_256_0_100_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_1_256_0_100_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=1MB --numjobs=1000 --rw=randread --rwmixread=0 --group_reporting --name=testfile --output=fio_128_1_1000_0_100_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_1_1000_0_100_randread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=100MB --numjobs=1 --rw=randread --rwmixread=0 --group_reporting --name=testfile --output=fio_128_100_1_0_100_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_100_1_0_100_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=100MB --numjobs=16 --rw=randread --rwmixread=0 --group_reporting --name=testfile --output=fio_128_100_16_0_100_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_100_16_0_100_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=100MB --numjobs=64 --rw=randread --rwmixread=0 --group_reporting --name=testfile --output=fio_128_100_64_0_100_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_100_64_0_100_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=100MB --numjobs=256 --rw=randread --rwmixread=0 --group_reporting --name=testfile --output=fio_128_100_256_0_100_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_100_256_0_100_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=100MB --numjobs=1000 --rw=randread --rwmixread=0 --group_reporting --name=testfile --output=fio_128_100_1000_0_100_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_100_1000_0_100_randread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=1MB --numjobs=1 --rw=randread --rwmixread=0 --group_reporting --name=testfile --output=fio_1_1_1_0_100_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_1_1_0_100_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=1MB --numjobs=16 --rw=randread --rwmixread=0 --group_reporting --name=testfile --output=fio_1_1_16_0_100_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_1_16_0_100_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=1MB --numjobs=64 --rw=randread --rwmixread=0 --group_reporting --name=testfile --output=fio_1_1_64_0_100_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_1_64_0_100_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=1MB --numjobs=256 --rw=randread --rwmixread=0 --group_reporting --name=testfile --output=fio_1_1_256_0_100_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_1_256_0_100_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=1MB --numjobs=1000 --rw=randread --rwmixread=0 --group_reporting --name=testfile --output=fio_1_1_1000_0_100_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_1_1000_0_100_randread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=100MB --numjobs=1 --rw=randread --rwmixread=0 --group_reporting --name=testfile --output=fio_1_100_1_0_100_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_100_1_0_100_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=100MB --numjobs=16 --rw=randread --rwmixread=0 --group_reporting --name=testfile --output=fio_1_100_16_0_100_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_100_16_0_100_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=100MB --numjobs=64 --rw=randread --rwmixread=0 --group_reporting --name=testfile --output=fio_1_100_64_0_100_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_100_64_0_100_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=100MB --numjobs=256 --rw=randread --rwmixread=0 --group_reporting --name=testfile --output=fio_1_100_256_0_100_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_100_256_0_100_randread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=100MB --numjobs=1000 --rw=randread --rwmixread=0 --group_reporting --name=testfile --output=fio_1_100_1000_0_100_randread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_100_1000_0_100_randread.sh

#Read-to-Write: 0/100 Sequential
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=4KB --numjobs=1 --rw=read --rwmixread=0 --group_reporting --name=testfile --output=fio_4_4_1_0_100_seqread_output.txt --output-format=json --time_based --runtime=300 --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_4_1_0_100_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=4KB --numjobs=16 --rw=read --rwmixread=0 --group_reporting --name=testfile --output=fio_4_4_16_0_100_seqread_output.txt --output-format=json --time_based --runtime=300 --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_4_16_0_100_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=4KB --numjobs=64 --rw=read --rwmixread=0 --group_reporting --name=testfile --output=fio_4_4_64_0_100_seqread_output.txt --output-format=json --time_based --runtime=300 --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_4_64_0_100_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=4KB --numjobs=256 --rw=read --rwmixread=0 --group_reporting --name=testfile --output=fio_4_4_256_0_100_seqread_output.txt --output-format=json --time_based --runtime=300 --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_4_256_0_100_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=4KB --numjobs=1000 --rw=read --rwmixread=0 --group_reporting --name=testfile --output=fio_4_4_1000_0_100_seqread_output.txt --output-format=json --time_based --runtime=300 --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_4_1000_0_100_seqread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=1MB --numjobs=1 --rw=read --rwmixread=0 --group_reporting --name=testfile --output=fio_4_1_1_0_100_seqread_output.txt --output-format=json --time_based --runtime=300 --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_1_1_0_100_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=1MB --numjobs=16 --rw=read --rwmixread=0 --group_reporting --name=testfile --output=fio_4_1_16_0_100_seqread_output.txt --output-format=json --time_based --runtime=300 --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_1_16_0_100_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=1MB --numjobs=64 --rw=read --rwmixread=0 --group_reporting --name=testfile --output=fio_4_1_64_0_100_seqread_output.txt --output-format=json --time_based --runtime=300 --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_1_64_0_100_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=1MB --numjobs=256 --rw=read --rwmixread=0 --group_reporting --name=testfile --output=fio_4_1_256_0_100_seqread_output.txt --output-format=json --time_based --runtime=300 --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_1_256_0_100_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=1MB --numjobs=1000 --rw=read --rwmixread=0 --group_reporting --name=testfile --output=fio_4_1_1000_0_100_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_1_1000_0_100_seqread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=100MB --numjobs=1 --rw=read --rwmixread=0 --group_reporting --name=testfile --output=fio_4_100_1_0_100_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_100_1_0_100_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=100MB --numjobs=16 --rw=read --rwmixread=0 --group_reporting --name=testfile --output=fio_4_100_16_0_100_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_100_16_0_100_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=100MB --numjobs=64 --rw=read --rwmixread=0 --group_reporting --name=testfile --output=fio_4_100_64_0_100_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_100_64_0_100_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=100MB --numjobs=256 --rw=read --rwmixread=0 --group_reporting --name=testfile --output=fio_4_100_256_0_100_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_100_256_0_100_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=4KB --size=100MB --numjobs=1000 --rw=read --rwmixread=0 --group_reporting --name=testfile --output=fio_4_100_1000_0_100_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_4_100_1000_0_100_seqread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=32KB --numjobs=1 --rw=read --rwmixread=0 --group_reporting --name=testfile --output=fio_32_32_1_0_100_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_32_1_0_100_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=32KB --numjobs=16 --rw=read --rwmixread=0 --group_reporting --name=testfile --output=fio_32_32_16_0_100_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_32_16_0_100_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=32KB --numjobs=64 --rw=read --rwmixread=0 --group_reporting --name=testfile --output=fio_32_32_64_0_100_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_32_64_0_100_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=32KB --numjobs=256 --rw=read --rwmixread=0 --group_reporting --name=testfile --output=fio_32_32_256_0_100_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_32_256_0_100_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=32KB --numjobs=1000 --rw=read --rwmixread=0 --group_reporting --name=testfile --output=fio_32_32_1000_0_100_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_32_1000_0_100_seqread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=1MB --numjobs=1 --rw=read --rwmixread=0 --group_reporting --name=testfile --output=fio_32_1_1_0_100_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_1_1_0_100_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=1MB --numjobs=16 --rw=read --rwmixread=0 --group_reporting --name=testfile --output=fio_32_1_16_0_100_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_1_16_0_100_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=1MB --numjobs=64 --rw=read --rwmixread=0 --group_reporting --name=testfile --output=fio_32_1_64_0_100_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_1_64_0_100_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=1MB --numjobs=256 --rw=read --rwmixread=0 --group_reporting --name=testfile --output=fio_32_1_256_0_100_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_1_256_0_100_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=1MB --numjobs=1000 --rw=read --rwmixread=0 --group_reporting --name=testfile --output=fio_32_1_1000_0_100_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_1_1000_0_100_seqread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=100MB --numjobs=1 --rw=read --rwmixread=0 --group_reporting --name=testfile --output=fio_32_100_1_0_100_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_100_1_0_100_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=100MB --numjobs=16 --rw=read --rwmixread=0 --group_reporting --name=testfile --output=fio_32_100_16_0_100_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_100_16_0_100_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=100MB --numjobs=64 --rw=read --rwmixread=0 --group_reporting --name=testfile --output=fio_32_100_64_0_100_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_100_64_0_100_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=100MB --numjobs=256 --rw=read --rwmixread=0 --group_reporting --name=testfile --output=fio_32_100_256_0_100_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_100_256_0_100_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=32KB --size=100MB --numjobs=1000 --rw=read --rwmixread=0 --group_reporting --name=testfile --output=fio_32_100_1000_0_100_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_32_100_1000_0_100_seqread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=128KB --numjobs=1 --rw=read --rwmixread=0 --group_reporting --name=testfile --output=fio_128_128_1_0_100_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_128_1_0_100_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=128KB --numjobs=16 --rw=read --rwmixread=0 --group_reporting --name=testfile --output=fio_128_128_16_0_100_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_128_16_0_100_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=128KB --numjobs=64 --rw=read --rwmixread=0 --group_reporting --name=testfile --output=fio_128_128_64_0_100_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_128_64_0_100_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=128KB --numjobs=256 --rw=read --rwmixread=0 --group_reporting --name=testfile --output=fio_128_128_256_0_100_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_128_256_0_100_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=128KB --numjobs=1000 --rw=read --rwmixread=0 --group_reporting --name=testfile --output=fio_128_128_1000_0_100_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_128_1000_0_100_seqread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=1MB --numjobs=1 --rw=read --rwmixread=0 --group_reporting --name=testfile --output=fio_128_1_1_0_100_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_1_1_0_100_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=1MB --numjobs=16 --rw=read --rwmixread=0 --group_reporting --name=testfile --output=fio_128_1_16_0_100_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_1_16_0_100_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=1MB --numjobs=64 --rw=read --rwmixread=0 --group_reporting --name=testfile --output=fio_128_1_64_0_100_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_1_64_0_100_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=1MB --numjobs=256 --rw=read --rwmixread=0 --group_reporting --name=testfile --output=fio_128_1_256_0_100_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_1_256_0_100_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=1MB --numjobs=1000 --rw=read --rwmixread=0 --group_reporting --name=testfile --output=fio_128_1_1000_0_100_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_1_1000_0_100_seqread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=100MB --numjobs=1 --rw=read --rwmixread=0 --group_reporting --name=testfile --output=fio_128_100_1_0_100_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_100_1_0_100_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=100MB --numjobs=16 --rw=read --rwmixread=0 --group_reporting --name=testfile --output=fio_128_100_16_0_100_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_100_16_0_100_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=100MB --numjobs=64 --rw=read --rwmixread=0 --group_reporting --name=testfile --output=fio_128_100_64_0_100_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_100_64_0_100_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=100MB --numjobs=256 --rw=read --rwmixread=0 --group_reporting --name=testfile --output=fio_128_100_256_0_100_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_100_256_0_100_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=128KB --size=100MB --numjobs=1000 --rw=read --rwmixread=0 --group_reporting --name=testfile --output=fio_128_100_1000_0_100_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_128_100_1000_0_100_seqread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=1MB --numjobs=1 --rw=read --rwmixread=0 --group_reporting --name=testfile --output=fio_1_1_1_0_100_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_1_1_0_100_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=1MB --numjobs=16 --rw=read --rwmixread=0 --group_reporting --name=testfile --output=fio_1_1_16_0_100_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_1_16_0_100_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=1MB --numjobs=64 --rw=read --rwmixread=0 --group_reporting --name=testfile --output=fio_1_1_64_0_100_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_1_64_0_100_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=1MB --numjobs=256 --rw=read --rwmixread=0 --group_reporting --name=testfile --output=fio_1_1_256_0_100_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_1_256_0_100_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=1MB --numjobs=1000 --rw=read --rwmixread=0 --group_reporting --name=testfile --output=fio_1_1_1000_0_100_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_1_1000_0_100_seqread.sh

echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=100MB --numjobs=1 --rw=read --rwmixread=0 --group_reporting --name=testfile --output=fio_1_100_1_0_100_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_100_1_0_100_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=100MB --numjobs=16 --rw=read --rwmixread=0 --group_reporting --name=testfile --output=fio_1_100_16_0_100_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_100_16_0_100_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=100MB --numjobs=64 --rw=read --rwmixread=0 --group_reporting --name=testfile --output=fio_1_100_64_0_100_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_100_64_0_100_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=100MB --numjobs=256 --rw=read --rwmixread=0 --group_reporting --name=testfile --output=fio_1_100_256_0_100_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_100_256_0_100_seqread.sh
echo "fio --directory=/mnt/testCinder01/ --bs=1MB --size=100MB --numjobs=1000 --rw=read --rwmixread=0 --group_reporting --name=testfile --output=fio_1_100_1000_0_100_seqread_output.txt --output-format=json --time_based --runtime=300  --per_job_logs=0 --write_bw_log=fio-test --write_iops_log=fio-test --write_lat_log=fio-test;" >> fio_1_100_1000_0_100_seqread.sh

echo "Changing permissions on all shell scripts..."
chmod +x ./fio*.sh

echo "Creating a run all fio scripts bash file..."
cat  > runAllFioTest.sh << EOL

#Read-to-Write: 100/0 Sequential
./fio_4_4_1_100_0_seqread.sh
./fio_4_4_16_100_0_seqread.sh
./fio_4_4_64_100_0_seqread.sh
./fio_4_4_256_100_0_seqread.sh
./fio_4_4_1000_100_0_seqread.sh

./fio_4_1_1_100_0_seqread.sh
./fio_4_1_16_100_0_seqread.sh
./fio_4_1_64_100_0_seqread.sh
./fio_4_1_256_100_0_seqread.sh
./fio_4_1_1000_100_0_seqread.sh

./fio_4_100_1_100_0_seqread.sh
./fio_4_100_16_100_0_seqread.sh
./fio_4_100_64_100_0_seqread.sh
./fio_4_100_256_100_0_seqread.sh
./fio_4_100_1000_100_0_seqread.sh

./fio_32_32_1_100_0_seqread.sh
./fio_32_32_16_100_0_seqread.sh
./fio_32_32_64_100_0_seqread.sh
./fio_32_32_256_100_0_seqread.sh
./fio_32_32_1000_100_0_seqread.sh

./fio_32_1_1_100_0_seqread.sh
./fio_32_1_16_100_0_seqread.sh
./fio_32_1_64_100_0_seqread.sh
./fio_32_1_256_100_0_seqread.sh
./fio_32_1_1000_100_0_seqread.sh

./fio_32_100_1_100_0_seqread.sh
./fio_32_100_16_100_0_seqread.sh
./fio_32_100_64_100_0_seqread.sh
./fio_32_100_256_100_0_seqread.sh
./fio_32_100_1000_100_0_seqread.sh

./fio_128_128_1_100_0_seqread.sh
./fio_128_128_16_100_0_seqread.sh
./fio_128_128_64_100_0_seqread.sh
./fio_128_128_256_100_0_seqread.sh
./fio_128_128_1000_100_0_seqread.sh

./fio_128_1_1_100_0_seqread.sh
./fio_128_1_16_100_0_seqread.sh
./fio_128_1_64_100_0_seqread.sh
./fio_128_1_256_100_0_seqread.sh
./fio_128_1_1000_100_0_seqread.sh

./fio_128_100_1_100_0_seqread.sh
./fio_128_100_16_100_0_seqread.sh
./fio_128_100_64_100_0_seqread.sh
./fio_128_100_256_100_0_seqread.sh
./fio_128_100_1000_100_0_seqread.sh

./fio_1_1_1_100_0_seqread.sh
./fio_1_1_16_100_0_seqread.sh
./fio_1_1_64_100_0_seqread.sh
./fio_1_1_256_100_0_seqread.sh
./fio_1_1_1000_100_0_seqread.sh

./fio_1_100_1_100_0_seqread.sh
./fio_1_100_16_100_0_seqread.sh
./fio_1_100_64_100_0_seqread.sh
./fio_1_100_256_100_0_seqread.sh
./fio_1_100_1000_100_0_seqread.sh

#Read-to-Write: 100/0 Random
./fio_4_4_1_100_0_randread.sh
./fio_4_4_16_100_0_randread.sh
./fio_4_4_64_100_0_randread.sh
./fio_4_4_256_100_0_randread.sh
./fio_4_4_1000_100_0_randread.sh

./fio_4_1_1_100_0_randread.sh
./fio_4_1_16_100_0_randread.sh
./fio_4_1_64_100_0_randread.sh
./fio_4_1_256_100_0_randread.sh
./fio_4_1_1000_100_0_randread.sh

./fio_4_100_1_100_0_randread.sh
./fio_4_100_16_100_0_randread.sh
./fio_4_100_64_100_0_randread.sh
./fio_4_100_256_100_0_randread.sh
./fio_4_100_1000_100_0_randread.sh

./fio_32_32_1_100_0_randread.sh
./fio_32_32_16_100_0_randread.sh
./fio_32_32_64_100_0_randread.sh
./fio_32_32_256_100_0_randread.sh
./fio_32_32_1000_100_0_randread.sh

./fio_32_1_1_100_0_randread.sh
./fio_32_1_16_100_0_randread.sh
./fio_32_1_64_100_0_randread.sh
./fio_32_1_256_100_0_randread.sh
./fio_32_1_1000_100_0_randread.sh

./fio_32_100_1_100_0_randread.sh
./fio_32_100_16_100_0_randread.sh
./fio_32_100_64_100_0_randread.sh
./fio_32_100_256_100_0_randread.sh
./fio_32_100_1000_100_0_randread.sh

./fio_128_128_1_100_0_randread.sh
./fio_128_128_16_100_0_randread.sh
./fio_128_128_64_100_0_randread.sh
./fio_128_128_256_100_0_randread.sh
./fio_128_128_1000_100_0_randread.sh

./fio_128_1_1_100_0_randread.sh
./fio_128_1_16_100_0_randread.sh
./fio_128_1_64_100_0_randread.sh
./fio_128_1_256_100_0_randread.sh
./fio_128_1_1000_100_0_randread.sh

./fio_128_100_1_100_0_randread.sh
./fio_128_100_16_100_0_randread.sh
./fio_128_100_64_100_0_randread.sh
./fio_128_100_256_100_0_randread.sh
./fio_128_100_1000_100_0_randread.sh

./fio_1_1_1_100_0_randread.sh
./fio_1_1_16_100_0_randread.sh
./fio_1_1_64_100_0_randread.sh
./fio_1_1_256_100_0_randread.sh
./fio_1_1_1000_100_0_randread.sh

./fio_1_100_1_100_0_randread.sh
./fio_1_100_16_100_0_randread.sh
./fio_1_100_64_100_0_randread.sh
./fio_1_100_256_100_0_randread.sh
./fio_1_100_1000_100_0_randread.sh

#Read-to-Write: 80/20 Random
./fio_4_4_1_80_20_randread.sh
./fio_4_4_16_80_20_randread.sh
./fio_4_4_64_80_20_randread.sh
./fio_4_4_256_80_20_randread.sh
./fio_4_4_1000_80_20_randread.sh

./fio_4_1_1_80_20_randread.sh
./fio_4_1_16_80_20_randread.sh
./fio_4_1_64_80_20_randread.sh
./fio_4_1_256_80_20_randread.sh
./fio_4_1_1000_80_20_randread.sh

./fio_4_100_1_80_20_randread.sh
./fio_4_100_16_80_20_randread.sh
./fio_4_100_64_80_20_randread.sh
./fio_4_100_256_80_20_randread.sh
./fio_4_100_1000_80_20_randread.sh

./fio_32_32_1_80_20_randread.sh
./fio_32_32_16_80_20_randread.sh
./fio_32_32_64_80_20_randread.sh
./fio_32_32_256_80_20_randread.sh
./fio_32_32_1000_80_20_randread.sh

./fio_32_1_1_80_20_randread.sh
./fio_32_1_16_80_20_randread.sh
./fio_32_1_64_80_20_randread.sh
./fio_32_1_256_80_20_randread.sh
./fio_32_1_1000_80_20_randread.sh

./fio_32_100_1_80_20_randread.sh
./fio_32_100_16_80_20_randread.sh
./fio_32_100_64_80_20_randread.sh
./fio_32_100_256_80_20_randread.sh
./fio_32_100_1000_80_20_randread.sh

./fio_128_128_1_80_20_randread.sh
./fio_128_128_16_80_20_randread.sh
./fio_128_128_64_80_20_randread.sh
./fio_128_128_256_80_20_randread.sh
./fio_128_128_1000_80_20_randread.sh

./fio_128_1_1_80_20_randread.sh
./fio_128_1_16_80_20_randread.sh
./fio_128_1_64_80_20_randread.sh
./fio_128_1_256_80_20_randread.sh
./fio_128_1_1000_80_20_randread.sh

./fio_128_100_1_80_20_randread.sh
./fio_128_100_16_80_20_randread.sh
./fio_128_100_64_80_20_randread.sh
./fio_128_100_256_80_20_randread.sh
./fio_128_100_1000_80_20_randread.sh

./fio_1_1_1_80_20_randread.sh
./fio_1_1_16_80_20_randread.sh
./fio_1_1_64_80_20_randread.sh
./fio_1_1_256_80_20_randread.sh
./fio_1_1_1000_80_20_randread.sh

./fio_1_100_1_80_20_randread.sh
./fio_1_100_16_80_20_randread.sh
./fio_1_100_64_80_20_randread.sh
./fio_1_100_256_80_20_randread.sh
./fio_1_100_1000_80_20_randread.sh

#Read-to-Write: 50/50 Random
./fio_4_4_1_50_50_randread.sh
./fio_4_4_16_50_50_randread.sh
./fio_4_4_64_50_50_randread.sh
./fio_4_4_256_50_50_randread.sh
./fio_4_4_1000_50_50_randread.sh

./fio_4_1_1_50_50_randread.sh
./fio_4_1_16_50_50_randread.sh
./fio_4_1_64_50_50_randread.sh
./fio_4_1_256_50_50_randread.sh
./fio_4_1_1000_50_50_randread.sh

./fio_4_100_1_50_50_randread.sh
./fio_4_100_16_50_50_randread.sh
./fio_4_100_64_50_50_randread.sh
./fio_4_100_256_50_50_randread.sh
./fio_4_100_1000_50_50_randread.sh

./fio_32_32_1_50_50_randread.sh
./fio_32_32_16_50_50_randread.sh
./fio_32_32_64_50_50_randread.sh
./fio_32_32_256_50_50_randread.sh
./fio_32_32_1000_50_50_randread.sh

./fio_32_1_1_50_50_randread.sh
./fio_32_1_16_50_50_randread.sh
./fio_32_1_64_50_50_randread.sh
./fio_32_1_256_50_50_randread.sh
./fio_32_1_1000_50_50_randread.sh

./fio_32_100_1_50_50_randread.sh
./fio_32_100_16_50_50_randread.sh
./fio_32_100_64_50_50_randread.sh
./fio_32_100_256_50_50_randread.sh
./fio_32_100_1000_50_50_randread.sh

./fio_128_128_1_50_50_randread.sh
./fio_128_128_16_50_50_randread.sh
./fio_128_128_64_50_50_randread.sh
./fio_128_128_256_50_50_randread.sh
./fio_128_128_1000_50_50_randread.sh

./fio_128_1_1_50_50_randread.sh
./fio_128_1_16_50_50_randread.sh
./fio_128_1_64_50_50_randread.sh
./fio_128_1_256_50_50_randread.sh
./fio_128_1_1000_50_50_randread.sh

./fio_128_100_1_50_50_randread.sh
./fio_128_100_16_50_50_randread.sh
./fio_128_100_64_50_50_randread.sh
./fio_128_100_256_50_50_randread.sh
./fio_128_100_1000_50_50_randread.sh

./fio_1_1_1_50_50_randread.sh
./fio_1_1_16_50_50_randread.sh
./fio_1_1_64_50_50_randread.sh
./fio_1_1_256_50_50_randread.sh
./fio_1_1_1000_50_50_randread.sh

./fio_1_100_1_50_50_randread.sh
./fio_1_100_16_50_50_randread.sh
./fio_1_100_64_50_50_randread.sh
./fio_1_100_256_50_50_randread.sh
./fio_1_100_1000_50_50_randread.sh

#Read-to-Write: 0/100 Random
./fio_4_4_1_0_100_randread.sh
./fio_4_4_16_0_100_randread.sh
./fio_4_4_64_0_100_randread.sh
./fio_4_4_256_0_100_randread.sh
./fio_4_4_1000_0_100_randread.sh

./fio_4_1_1_0_100_randread.sh
./fio_4_1_16_0_100_randread.sh
./fio_4_1_64_0_100_randread.sh
./fio_4_1_256_0_100_randread.sh
./fio_4_1_1000_0_100_randread.sh

./fio_4_100_1_0_100_randread.sh
./fio_4_100_16_0_100_randread.sh
./fio_4_100_64_0_100_randread.sh
./fio_4_100_256_0_100_randread.sh
./fio_4_100_1000_0_100_randread.sh

./fio_32_32_1_0_100_randread.sh
./fio_32_32_16_0_100_randread.sh
./fio_32_32_64_0_100_randread.sh
./fio_32_32_256_0_100_randread.sh
./fio_32_32_1000_0_100_randread.sh

./fio_32_1_1_0_100_randread.sh
./fio_32_1_16_0_100_randread.sh
./fio_32_1_64_0_100_randread.sh
./fio_32_1_256_0_100_randread.sh
./fio_32_1_1000_0_100_randread.sh

./fio_32_100_1_0_100_randread.sh
./fio_32_100_16_0_100_randread.sh
./fio_32_100_64_0_100_randread.sh
./fio_32_100_256_0_100_randread.sh
./fio_32_100_1000_0_100_randread.sh

./fio_128_128_1_0_100_randread.sh
./fio_128_128_16_0_100_randread.sh
./fio_128_128_64_0_100_randread.sh
./fio_128_128_256_0_100_randread.sh
./fio_128_128_1000_0_100_randread.sh

./fio_128_1_1_0_100_randread.sh
./fio_128_1_16_0_100_randread.sh
./fio_128_1_64_0_100_randread.sh
./fio_128_1_256_0_100_randread.sh
./fio_128_1_1000_0_100_randread.sh

./fio_128_100_1_0_100_randread.sh
./fio_128_100_16_0_100_randread.sh
./fio_128_100_64_0_100_randread.sh
./fio_128_100_256_0_100_randread.sh
./fio_128_100_1000_0_100_randread.sh

./fio_1_1_1_0_100_randread.sh
./fio_1_1_16_0_100_randread.sh
./fio_1_1_64_0_100_randread.sh
./fio_1_1_256_0_100_randread.sh
./fio_1_1_1000_0_100_randread.sh

./fio_1_100_1_0_100_randread.sh
./fio_1_100_16_0_100_randread.sh
./fio_1_100_64_0_100_randread.sh
./fio_1_100_256_0_100_randread.sh
./fio_1_100_1000_0_100_randread.sh

#Read-to-Write: 0/100 Sequential
./fio_4_4_1_0_100_seqread.sh
./fio_4_4_16_0_100_seqread.sh
./fio_4_4_64_0_100_seqread.sh
./fio_4_4_256_0_100_seqread.sh
./fio_4_4_1000_0_100_seqread.sh

./fio_4_1_1_0_100_seqread.sh
./fio_4_1_16_0_100_seqread.sh
./fio_4_1_64_0_100_seqread.sh
./fio_4_1_256_0_100_seqread.sh
./fio_4_1_1000_0_100_seqread.sh

./fio_4_100_1_0_100_seqread.sh
./fio_4_100_16_0_100_seqread.sh
./fio_4_100_64_0_100_seqread.sh
./fio_4_100_256_0_100_seqread.sh
./fio_4_100_1000_0_100_seqread.sh

./fio_32_32_1_0_100_seqread.sh
./fio_32_32_16_0_100_seqread.sh
./fio_32_32_64_0_100_seqread.sh
./fio_32_32_256_0_100_seqread.sh
./fio_32_32_1000_0_100_seqread.sh

./fio_32_1_1_0_100_seqread.sh
./fio_32_1_16_0_100_seqread.sh
./fio_32_1_64_0_100_seqread.sh
./fio_32_1_256_0_100_seqread.sh
./fio_32_1_1000_0_100_seqread.sh

./fio_32_100_1_0_100_seqread.sh
./fio_32_100_16_0_100_seqread.sh
./fio_32_100_64_0_100_seqread.sh
./fio_32_100_256_0_100_seqread.sh
./fio_32_100_1000_0_100_seqread.sh

./fio_128_128_1_0_100_seqread.sh
./fio_128_128_16_0_100_seqread.sh
./fio_128_128_64_0_100_seqread.sh
./fio_128_128_256_0_100_seqread.sh
./fio_128_128_1000_0_100_seqread.sh

./fio_128_1_1_0_100_seqread.sh
./fio_128_1_16_0_100_seqread.sh
./fio_128_1_64_0_100_seqread.sh
./fio_128_1_256_0_100_seqread.sh
./fio_128_1_1000_0_100_seqread.sh

./fio_128_100_1_0_100_seqread.sh
./fio_128_100_16_0_100_seqread.sh
./fio_128_100_64_0_100_seqread.sh
./fio_128_100_256_0_100_seqread.sh
./fio_128_100_1000_0_100_seqread.sh

./fio_1_1_1_0_100_seqread.sh
./fio_1_1_16_0_100_seqread.sh
./fio_1_1_64_0_100_seqread.sh
./fio_1_1_256_0_100_seqread.sh
./fio_1_1_1000_0_100_seqread.sh

./fio_1_100_1_0_100_seqread.sh
./fio_1_100_16_0_100_seqread.sh
./fio_1_100_64_0_100_seqread.sh
./fio_1_100_256_0_100_seqread.sh
./fio_1_100_1000_0_100_seqread.sh
EOL

echo "Changing permissions on run shell scripts..."
chmod +x ./runAllFioTest.sh

exit 0