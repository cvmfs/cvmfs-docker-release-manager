FROM ubuntu:xenial

ARG cvmfs_config_package_url
ARG cvmfs_config_package

ARG cvmfs_package_url
ARG cvmfs_client_package
ARG cvmfs_server_package

RUN apt-get update && apt-get dist-upgrade && apt-get install -y apt-utils curl git jq kmod
RUN curl -O $cvmfs_config_package_url/$cvmfs_config_package; \
    curl -O $cvmfs_package_url/$cvmfs_client_package; \
    curl -O $cvmfs_package_url/$cvmfs_server_package; \
    dpkg -i $cvmfs_config_package; \
    dpkg -i $cvmfs_client_package; \
    dpkg -i $cvmfs_server_package; \
    apt-get -y -f install; \
    rm -f $cvmfs_client_package $cvmfs_config_package $cvmfs_server_package

# Patch the cvmfs_server command to place the Aufs xino file in /dev/shm/.xino
RUN sed -i 's*aufs_$name /cvmfs/$name aufs br=${scratch_dir}=rw:${rdonly_dir}=rr,udba=none,noauto,ro$selinux_context 0 0 # added by CernVM-FS for $name*aufs_$name /cvmfs/$name aufs br=${scratch_dir}=rw:${rdonly_dir}=rr,xino=/dev/shm/.aufs.xino,udba=none,noauto,ro$selinux_context 0 0 # added by CernVM-FS for $name*g' /usr/bin/cvmfs_server

COPY private/cvmfs_start_release_manager.sh /usr/local/bin/
