#!/usr/bin/env bash
set -e
set -o pipefail

echo ">>> Installing Git"
apt install git -y
echo ">>> Cloning repository: $1"
git clone $1

repositoryURL=$1
repositoryGit=${repositoryURL##*/}
repositoryName=${repositoryGit::-4}
echo ">>> Identified $repositoryName as work dir"
cd $repositoryName
ls