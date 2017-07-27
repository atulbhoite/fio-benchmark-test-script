#! /bin/bash

echo "Running loadfio.sh... "

echo "Make scripts executable... "
cd fio-benchmark-test-script/
chmod +x generate_fio_scripts.sh
chmod +x mount_cinder_volume.sh
chmod +x copy_files_to_home_dir.sh
chmod +x runController.sh


if [ -z "${FIO_TEST_RUNTIME}" ]; then
    echo "runtime for test is not set using the variable FIO_TEST_RUNTIME, running default time of 30 seconds";
    ./generate_fio_scripts.sh 30;
else
    echo "using runtime specified in variable FIO_TEST_RUNTIME ${FIO_TEST_RUNTIME}";
    ./generate_fio_scripts.sh "${FIO_TEST_RUNTIME}";
fi

# Ensure script is executable.
chmod +x runAllFioTests.sh

sudo ./mount_cinder_volume.sh
sudo ./runController.sh