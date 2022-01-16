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
chmod +x gradlew
echo ">>> Starting Client"
./gradlew runClient
echo ">>> Waiting for exit message"
#Created: 128x128x0 minecraft:textures/atlas/mob_effects.png-atlas
grep -p 'Created: 128x128x0 minecraft:textures/atlas/mob_effects.png-atlas' < tail -f run/logs/latest.log || exit 1