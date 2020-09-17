# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include nfs::client
class nfs::client ($nfs_host_ip = '10.1.1.2') {

  package {
    'nfs-install':
      ensure => present,
      name   => 'nfs-common',
  }
  -> firewall {
    'nfs-firewall':
      dport  => 2049,
      proto  => tcp,
      action => accept,
    }
}
