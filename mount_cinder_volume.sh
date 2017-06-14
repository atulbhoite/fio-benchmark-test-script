#! /bin/bash

echo "Creating file system on /dev/vdb..."
mkfs.ext4 /dev/vdb

echo "Mounting cinder volume..."
mkdir -p /mnt/testCinder01/
mount /dev/vdb /mnt/testCinder01/

