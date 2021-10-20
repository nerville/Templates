#!/bin/bash
if [ -e /etc/debian_version ]; then
  #get the lock
  while fuser /var/lib/apt/lists/lock >/dev/null 2>&1 ; do
    sleep 5;
  done
  echo 'APT::Acquire::Retries "3";' > /etc/apt/apt.conf.d/99-retries
  apt-get update && apt-get -y upgrade && apt-get -y install default-jre git
elif [ -e /etc/centos-release ]; then
  yum -y install git java-1.8.0-openjdk
  sed -i -e '/secure_path/ s[=.*[&:/usr/local/share/fusionforge/bin:/usr/local/bin[' /etc/sudoers
else
  zypper --non-interactive install git java-11-openjdk
fi
#force sudoers to handle waagent ...
echo 'slave ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/zzz-slave
chmod 440 /etc/sudoers.d/zzz-slave
