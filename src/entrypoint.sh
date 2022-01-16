#!/usr/bin/env bash
set -e
set -o pipefail

echo ">>> Updating Packets"
apt update -y
apt upgrade -y
echo ">>> Installing required Programms"
apt install apt-utils -y
apt install dialog -y
apt install git -y
apt install screen -y
echo ">>> Cloning repository: $1"
git clone $1

repositoryURL=$1
repositoryGit=${repositoryURL##*/}
repositoryName=${repositoryGit::-4}
echo ">>> Identified $repositoryName as work dir"
cd $repositoryName
chmod +x gradlew
mkdir run
echo "eula=true" > run/eula.txt
echo ">>> Starting Server"
screen -dmS server bash -c "cd /$repositoryName/ && ./gradlew runServer"

echo ">>> Waiting for exit message"
while [ ! -f /run/logs/latest.log ]; do sleep 1; done

{ tail -n +1 -f /run/logs/latest.log & } | sed -n 'Done' || exit 1