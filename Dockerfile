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

COPY private/cvmfs_start_release_manager.sh /usr/local/bin/
