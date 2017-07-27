#! /bin/bash

echo "Running loadfio.sh... "

if [ -z "${FIO_TEST_RUNTIME}" ]; then
    echo "runtime for test is not set using the variable FIO_TEST_RUNTIME, running default time of 30 seconds";
    ./generate_fio_scripts.sh 3;
else
    echo "using runtime specified in variable FIO_TEST_RUNTIME ${FIO_TEST_RUNTIME}";
    ./generate_fio_scripts.sh "${FIO_TEST_RUNTIME}";
fi

# Ensure script is executable.
chmod +x runAllFioTests.sh

./mount_cinder_volume.sh
./runController.sh