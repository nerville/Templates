#!/bin/bash
if [ -e /etc/debian_version ]; then
  apt-get update && apt-get -y install git default-jre
else
  yum install git
fi
HOSTNAME=$(hostname)
hostname -b $HOSTNAME.buildbot.fusionforge.on.azure
