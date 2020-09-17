package { 'apparmor':
  name => 'apparmor',
  ensure => absent
}

package { 'selinux':
  name => 'selinux',
  ensure => present
}

package { 'policycoreutils-python-utils':
  name => 'policycoreutils-python-utils'
  ensure => present
}

file { '/etc/selinux/config':
  ensure => '/etc/selinux/config',
  content => epp('./files/config.epp', {
    'SELINUX' => 'enforcing',
    'SELINUXTYPE' => 'default',
    'SETLOCALDEFS' => '0'
  }),
  owner => 'root'
}

file { '/var/log/audit/audit.log':
  ensure => file,
  owner => 'root'
}

