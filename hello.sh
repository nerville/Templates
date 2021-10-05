#!/bin/bash
if [ -e /etc/debian_version ]; then
  if grep -q ^8 /etc/debian_version; then
    if [ ! -f /etc/apt/sources.list.d/backports.list ]; then
      echo 'deb http://archive.debian.org/debian jessie-backports main' \
           > /etc/apt/sources.list.d/backports.list
    fi
    if [ ! -f /etc/apt/apt.conf.d/10no--check-valid-until ]; then
      echo 'Acquire::Check-Valid-Until "0";' \
           > /etc/apt/apt.conf.d/10no--check-valid-until
    fi
    apt-get -y install git
    apt-get -y install -t jessie-backports openjdk-8-jdk
  else
    apt-get -y install git default-jre
  fi
fi
$HOSTNAME=`hostname`
hostname -b $HOSTNAME.buildbot.fusionforge.on.azure
