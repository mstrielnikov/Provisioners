#!/bin/bash

SUDO_FLAG="$(echo $(id -u))"
PUPPET_RELEASE="puppet6-release-bionic.deb"
PUPPET_REPO="https://apt.puppetlabs.com/$PUPPET_RELEASE"
PUPPET_CONF="/etc/puppetlabs/puppet/puppet.conf"
PUPPET_PKI="/opt/puppetlabs/bin/puppetserver"
PUPPET_JVM="/etc/default/puppetserver"
PUPPET_JVM_RAM=512
PUPPET_JVM_CACHE=512
PUPPET_DOMAIN="puppet.aether.com"
PUPPET_IP="10.0.1.2"
PUPPET_PORT="8140"

echo "<---Script to configure puppet master--->"

if [[ $SUDO_FLAG -ne 0 ]]
then
    echo "not a sudo" && exit 1
fi

if ! ping -q -c 1 -W 1 8.8.8.8 >/dev/null
then
  echo "IPv4 is down" && exit 1
fi

wget "$PUPPET_REPO"

dpkg -i "$PUPPET_RELEASE"

apt update && apt upgrade
 
apt install -y puppetserver ntpdate ntp bind9 bind9utils

[[ -f "$PUPPET_JVM" ]] && rewrite="$(grep -E ^JAVA_ARGS= $PUPPET_JVM)"

[[ -f "$PUPPET_JVM" ]] && exp="\"-Xms${PUPPET_JVM_RAM}m -Xmx${PUPPET_JVM_CACHE}m -Djruby.logger.class=com.puppetlabs.jruby_utils.jruby.Slf4jLogger\""

[[ -f "$PUPPET_JVM" ]] && sed -i "s/$rewrite/JAVA_ARGS=$exp/" $PUPPET_JVM

ntpdate pool.ntp.org



[[ -f "$PUPPET_CONF" ]] && echo
"[main]
certname = ${PUPPET_DOMAIN}
server = ${PUPPET_DOMAIN}
environment = test
runinterval = 15m" >> $PUPPET_CONF

echo "${PUPPET_IP} ${PUPPET_DOMAIN}" >> /etc/hosts

$PUPPET_PKI ca setup

ufw allow from ${PUPPET_IP} to any port ${PUPPET_PORT}
ufw allow from ${PUPPET_IP} from any port ${PUPPET_PORT}
ufw enable

systemctl restart ufw

systemctl enable puppet

systemctl restart puppet

systemctl status puppet

echo "<---Done--->"

exit 0;