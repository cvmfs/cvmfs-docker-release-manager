#!/bin/sh

cvmfs_release_url=https://ecsft.cern.ch/dist/cvmfs/cvmfs-release/cvmfs-release-latest_all.deb

name_tag=$1
if [ x"$name_tag" = x"" ]; then
    echo "Using default name and tag: cvmfs-docker-release-manager:latest"
    name_tag=cvmfs-docker-release-manager:latest
fi

docker build . \
       --build-arg cvmfs_release_url=$cvmfs_release_url \
       -t $name_tag
