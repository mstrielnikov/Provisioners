#lvm::volume { 'lv_mysql':
  #  ensure => present,
  #  vg     => 'vg_mysql',
  #  pv     => '/dev/sda3',
  #  fstype => 'ext4',
  #  size   => '40G',
  #} ->
  file {'/data':
    ensure  => directory,
  } ->
  #mount {'/data':
  #  ensure  => 'mounted',
  #  name    => '/data',
  #  device  => '/dev/mapper/vg_mysql-lv_mysql',
  #  fstype  => 'ext4',
  #  options => 'defaults',
  #  atboot  => true,
  #} ->
  #file {'/data/mysql':
  #  ensure  => directory,
  #} ->
