# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include master::cert
class master::cert {
  file {
    '/etc/puppetlabs/puppet/ssl':
      ensure => absent,
      name   => '/etc/puppetlabs/puppet/ssl',
  }

  ->exec {
    'gen-ca':
      command => '/opt/puppetlabs/bin/puppetserver ca setup',
  }

  ->service {
    'puppet-master-service':
      ensure => 'running',
      name   => 'puppet',
      notify => Service['gen-ca']
  }
}
