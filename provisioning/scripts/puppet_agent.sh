#!/bin/bash

#Script that brings base box to a testing ready environment

SUDO_FLAG="$(echo $(id -u))"
HOME="/home/$USER"
PUPPET_RELEASE="puppet6-release-bionic.deb"
PUPPET_REPO="https://apt.puppetlabs.com/$PUPPET_RELEASE"
PUPPET_DOMAIN="aether.stage.puppet.com"
export PROJECT_NAME="AetherInfrastructure"
export GIT_REPO="https://github.com/AetherProjectGames/AetherInfrastructure.git"

echo "<---Bootstrap script--->"

if [[ $SUDO_FLAG -ne 0 ]]
then
    echo "not a sudo" && exit 1;
fi

if ! ping -q -c 1 -W 1 8.8.8.8 >/dev/null
then
  echo "IPv4 is down" && exit 1;
fi

cd $HOME

wget "$PUPPET_REPO"

dpkg -i "$PUPPET_RELEASE"

apt update -y && apt install -y puppet-agent git puppet puppet-common

echo
"[main]
certname = ${PUPPET_DOMAIN}
server = ${PUPPET_DOMAIN}
environment = production
runinterval = 15m
"
>> /etc/puppetlabs/puppet/puppet.conf

echo
"
logdir=/var/log/puppet
vardir=/var/lib/puppet
ssldir=/var/lib/puppet/ssl
rundir=/var/run/puppet
modulepath=/etc/puppet/code/modules
" >> /etc/puppet/puppet.conf

systemctl enable "puppet agent"

systemctl start "puppet agent"

systemctl status "puppet agent"

/opt/puppetlabs/bin/puppet agent --test

exit 0;