#!/bin/bash
if [ -e /etc/debian_version ]; then
  apt-get -y install git default-jre
else
  yum install git
fi
HOSTNAME=$(hostname)
hostname -b $HOSTNAME.buildbot.fusionforge.on.azure
