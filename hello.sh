#!/bin/bash
if [ -e /etc/debian_version ]; then
  #get the lock
  while fuser /var/lib/apt/lists/lock >/dev/null 2>&1 ; do
    sleep 5;
  done
  apt-get update && apt-get -y install git default-jre
else
  yum install git
fi
HOSTNAME=$(hostname)
hostname -b $HOSTNAME.buildbot.fusionforge.on.azure
