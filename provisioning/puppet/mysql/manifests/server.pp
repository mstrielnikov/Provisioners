class {'::mysql::server':
  package_name     => 'mysql-server',
  service_name     => 'mysql',
  root_password    => 't5[sb^D[+rt8bBYu',
  override_options => {
    mysqld => {
      'log-error' => '/var/log/mysql/mariadb.log',
      'pid-file'  => '/var/run/mysqld/mysqld.pid',
    },
    mysqld_safe => {
      'log-error' => '/var/log/mysql/mariadb.log',
    },
  }
}

