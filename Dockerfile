FROM ubuntu:xenial

RUN apt-get update && apt-get dist-upgrade && apt-get install -y apt-utils curl git jq kmod
RUN curl -O https://ecsft.cern.ch/dist/cvmfs/nightlies/cvmfs-git-551/cvmfs_2.5.0~0.551git72e9055d046bbb78+ubuntu16.04_amd64.deb; \
    curl -O http://ecsft.cern.ch/dist/cvmfs/cvmfs-config/cvmfs-config-default_latest_all.deb; \
    curl -O https://ecsft.cern.ch/dist/cvmfs/nightlies/cvmfs-git-551/cvmfs-server_2.5.0~0.551git72e9055d046bbb78+ubuntu16.04_amd64.deb; \
    dpkg -i cvmfs-config-default_latest_all.deb; \
    dpkg -i cvmfs_2.5.0~0.551git72e9055d046bbb78+ubuntu16.04_amd64.deb; \
    dpkg -i cvmfs-server_2.5.0~0.551git72e9055d046bbb78+ubuntu16.04_amd64.deb; \
    apt-get -y -f install; \
    rm -f cvmfs_2.5.0~0.551git72e9055d046bbb78+ubuntu16.04_amd64.deb cvmfs-server_2.5.0~0.551git72e9055d046bbb78+ubuntu16.04_amd64.deb

COPY private/cvmfs_start_release_manager.sh /usr/local/bin/