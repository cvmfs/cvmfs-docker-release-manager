#!/bin/sh

echo "Welcome to the CernVM-FS Release Manager"

# 1. Read the CVMFS release manager configuration
# Stratum0 URL
config_file=/cvmfs_release_manager/config/repo_config.json
repo_name=$(cat $config_file | jq -r '.repo_name')
stratum0=$(cat $config_file | jq -r '.stratum0')
upstream=$(cat $config_file | jq -r '.upstream')
key_dir=$(cat $config_file | jq -r '.key_dir')

echo "Release manager configuration"
echo "  repo_name: $repo_name"
echo "   stratum0: $stratum0"
echo "   upstream: $upstream"
echo "    key_dir: $key_dir"

# 2. Set up CVMFS repository in "Release manager" mode
cvmfs_server mkfs -f overlayfs -w $stratum0 -u $upstream -k $key_dir -o root $repo_name

# 2. Drop user into an interactive shell
bash