#!/bin/bash
if [ -e /etc/debian_version ]; then
  #get the lock
  while fuser /var/lib/apt/lists/lock >/dev/null 2>&1 ; do
    sleep 5;
  done
  apt-get update && apt-get -y upgrade && apt-get -y install default-jre git
else
  yum -y install git java-1.8.0-openjdk
  sed -i -e '/secure_path/ s[=.*[&:/usr/local/share/fusionforge/bin:/usr/local/bin[' /etc/sudoers
fi
#force sudoers to handle waagent ...
echo 'slave ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/zzz-slave
chmod 440 /etc/sudoers.d/zzz-slave
