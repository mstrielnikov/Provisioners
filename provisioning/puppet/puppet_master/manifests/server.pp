# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include master::server
class master::server ($server_fqdn = 'puppet.aether.com', $server_ip = '10.0.0.2') {
  host {
    $server_fqdn:
      ensure => present,
      ip     => $server_ip,
  }

  ->file {
    '/etc/puppetlabs/puppet/puppet.conf':
      ensure  => file,
      content => epp('master/puppet.conf.epp', {
        $::puppet_server_fqdn => $server_fqdn
      }),
  }

  -> firewall {
    'puppet-firewall':
      dport  => [4430, 8140],
      proto  => tcp,
      action => accept,
    }
}
