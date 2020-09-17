# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include nfs::server
class nfs::install {

  package {
    'nfs-package':
      ensure => 'present',
      name   => 'nfs-kernel-server',
  }
  -> firewall {
    'nfs-firewall':
      dport  => 2049,
      proto  => tcp,
      action => accept,
  }
  -> service {
    'nfs-service':
      ensure => 'present',
      name   => 'nfs-kernel-server',
  }
}

