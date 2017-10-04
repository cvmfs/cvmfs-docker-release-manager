#!/bin/sh

echo ""
echo "### Welcome to the CernVM-FS Release Manager"
echo ""

# 1. Read the CVMFS release manager configuration
config_file=/cvmfs_release_manager/config/repo_config.json
repo_name=$(cat $config_file | jq -r '.repo_name')
stratum0=$(cat $config_file | jq -r '.stratum0')
upstream=$(cat $config_file | jq -r '.upstream')
key_dir=$(cat $config_file | jq -r '.key_dir')

echo ""
echo "### Release manager configuration"
echo "     repo_name: $repo_name"
echo "      stratum0: $stratum0"
echo "      upstream: $upstream"
echo "       key_dir: $key_dir"
echo ""

# 2. Set up CVMFS repository in "Release manager" mode
cvmfs_server mkfs -w $stratum0 -u $upstream -k $key_dir -o root $repo_name

# 2. Drop user into an interactive shell
if [ -f /cvmfs_release_manager/data/transaction.sh ]; then
    echo ""
    echo "### Executing data/transaction.sh"
    echo ""
    sh /cvmfs_release_manager/data/transaction.sh
else
    echo ""
    echo "### No data/transaction.sh file found. Starting interactive shell."
    echo ""
    bash
fi
