#! /bin/bash

fdisk -l

echo "Creating file system on /dev/vdb..."
sudo mkfs.ext4 /dev/vdb

echo "Mounting cinder volume..."
sudo mkdir -p /mnt/testCinder01/
sudo mount /dev/vdb /mnt/testCinder01/

echo " Creating dummy file on newly mounted volume..."
echo "This is a dummy file on the new cinder volume. " > /mnt/testCinder01/mytestfile
sudo cat /mnt/testCinder01/mytestfile

