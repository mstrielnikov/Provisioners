class mysql::config ($config = 'my2gb.cnf') {

  file {
    '/etc/mysql.conf.d/mysqld.cnf':
      ensure  => 'file',
      owner   => 'root',
      content => file("mysql/${config}"),
  }
  service {
    'mysql-server':
      ensure => running,
      name   => 'mysql',
      notify => File['/etc/mysql.conf.d/mysqld.cnf'],
  }
}
