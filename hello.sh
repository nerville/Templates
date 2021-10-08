#!/bin/bash
if [ -e /etc/debian_version ]; then
  #get the lock
  while fuser /var/lib/apt/lists/lock >/dev/null 2>&1 ; do
    sleep 5;
  done
  if grep -q ^8 /etc/debian_version; then
    if [ ! -f /etc/apt/sources.list.d/backports.list ]; then
      echo 'deb http://archive.debian.org/debian jessie-backports main' \
           > /etc/apt/sources.list.d/backports.list
    fi
    if [ ! -f /etc/apt/apt.conf.d/10no--check-valid-until ]; then
      echo 'Acquire::Check-Valid-Until "0";' \
           > /etc/apt/apt.conf.d/10no--check-valid-until
    fi
    apt-get update && apt-get -y upgrade && apt-get -y install -t jessie-backports openjdk-8-jdk
  else
    apt-get update && apt-get -y upgrade && apt-get -y install default-jre
  fi
  apt-get install git
else
  yum -y update && yum -y install git java-1.8.0-openjdk
fi
#force sudoers to handle waagent ...
echo 'slave ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/zzz-slave
chmod 440 /etc/sudoers.d/zzz-slave
