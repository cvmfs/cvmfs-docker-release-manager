#!/bin/sh

config_dir=$(readlink -f $1)
data_dir=$(readlink -f $2)
spool_dir=$(readlink -f $3)

if [ x"$config_dir" = x"" ] || [ x"$data_dir" = x"" ] || [ x"$spool_dir" = x"" ]; then
    echo "Missing parameter(s). Usage: start.sh <CONFIG_DIR> <DATA_DIR> <SPOOL_DIR>"
    exit 1;
fi

docker run --rm -it --privileged \
    --mount type=bind,source="$config_dir",destination=/cvmfs_release_manager/config \
    --mount type=bind,source="$data_dir",destination=/cvmfs_release_manager/data \
    --mount type=bind,source="$spool_dir",destination=/var/spool/cvmfs \
    cvmfs-docker-release-manager \
    /usr/local/bin/cvmfs_start_release_manager.sh