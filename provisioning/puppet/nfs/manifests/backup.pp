# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include nfs::backup
class nfs::backup ($max_backup_size = 30) {
  file {
    '/backup':
      ensure => 'directory',
      owner  => 'root',
      group  => 'root',
      mode   => '0600',
  }
  -> package {
    'rsync':
      ensure => 'present',
      name   => 'rsync',
  }
  -> cron {
    'nfs-backup':
      ensure  => 'present',
      user    => 'root',
      command => "nfs/backup.sh ${$max_backup_size}",
      hour    => '*/1',
  }
}
