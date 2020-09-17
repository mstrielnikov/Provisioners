class nfs::export ($directories, $nfs_host_ip = '10.1.1.1', $nfs_mask = '255.255.255.0') {
  interface {'nfs_host':
    ensure    => present,
    ipaddress => $nfs_host_ip,
  } -> notice("Interface is present ${$nfs_host_ip}")

  -> $directories.each |String $dir|{
    notice("Mounting directories: ${dir}")
    file {
      $dir:
        ensure => directory,
        user   => 'nobody',
        group  => 'nogroup',
        mode   => '0600',
    }
    -> mount {
      $dir:
        ensure => 'mounted',
        name   => $dir,
        device => "${nfs_host_ip}:${dir}",
        atboot => true,
        fstype => 'nfs',
      }
    }
    -> file {
      '/etc/exports':
        ensure  => file,
        name    => '/etc/exports',
        content => epp('nfs/exports.epp', {
          $::nfs_network      => $nfs_host_ip,
          $::nfs_network_mask => $nfs_mask,
          $::exported         => $directories,
        }),
        user    => 'root',
        group   => 'root',
    } -> notice('Directories exported')

    -> service {
      'nfs-service':
        ensure => present,
        name   => 'nfs-kernel-server',
  }
}
