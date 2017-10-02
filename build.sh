#!/bin/sh

cvmfs_config_package_url=http://ecsft.cern.ch/dist/cvmfs/cvmfs-config
cvmfs_config_package=cvmfs-config-default_latest_all.deb

cvmfs_package_url=https://ecsft.cern.ch/dist/cvmfs/nightlies/cvmfs-git-551
cvmfs_client_package=cvmfs_2.5.0~0.551git72e9055d046bbb78+ubuntu16.04_amd64.deb
cvmfs_server_package=cvmfs-server_2.5.0~0.551git72e9055d046bbb78+ubuntu16.04_amd64.deb

name_tag=$1
if [ x"$name_tag" = x"" ]; then
    echo "Using default name and tag: cvmfs-docker-release-manager:latest"
    name_tag=cvmfs-docker-release-manager:latest
fi

docker build . \
       --build-arg cvmfs_config_package_url=$cvmfs_config_package_url \
       --build-arg cvmfs_config_package=$cvmfs_config_package \
       --build-arg cvmfs_package_url=$cvmfs_package_url \
       --build-arg cvmfs_client_package=$cvmfs_client_package \
       --build-arg cvmfs_server_package=$cvmfs_server_package \
       -t $name_tag
