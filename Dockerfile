FROM ubuntu:bionic

ARG cvmfs_release_url

RUN apt-get update && apt-get -y install apt-utils git jq curl lsb-release && \
    curl -O $cvmfs_release_url && \
    dpkg -i cvmfs-release-latest_all.deb && \
    apt-get -y update && apt-get -y dist-upgrade && \
    apt-get -y -f install cvmfs cvmfs-server && \
    apt-get -y clean && \
    rm -f cvmfs-release-latest_all.deb

# Patch the cvmfs_server command to place the Aufs xino file in /dev/shm/.xino
RUN sed -i 's*aufs_$name /cvmfs/$name aufs br=${scratch_dir}=rw:${rdonly_dir}=rr,udba=none,noauto,nodev,ro$selinux_context 0 0 # added by CernVM-FS for $name*aufs_$name /cvmfs/$name aufs br=${scratch_dir}=rw:${rdonly_dir}=rr,xino=/dev/shm/.aufs.xino,udba=none,noauto,nodev,ro$selinux_context 0 0 # added by CernVM-FS for $name*g' /usr/bin/cvmfs_server

COPY private/cvmfs_start_release_manager.sh /usr/local/bin/
