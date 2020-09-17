class mysql::install {
  package {
    'mysql-server':
      ensure => present,
      name   => 'mysql-server',
  }
  -> firewall {
    'mysql-server':
      proto => 'tcp',
      dport => 3306,
  }
  service {
    'mysql-server':
      ensure => running,
      name   => 'mysql',
      notify => File['/etc/mysql.conf.d/mysqld.cnf'],
  }
}
