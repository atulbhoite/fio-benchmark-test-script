#! /bin/bash

fdisk -l

echo "Creating file system on /dev/vdb..."
mkfs.ext4 /dev/vdb

echo "Mounting cinder volume..."
mkdir -p /mnt/testCinder01/
mount /dev/vdb /mnt/testCinder01/
df -kH

echo " Creating dummy file on newly mounted volume..."
echo "This is a dummy file on the new cinder volume. " > /mnt/testCinder01/mytestfile
cat /mnt/testCinder01/mytestfile

