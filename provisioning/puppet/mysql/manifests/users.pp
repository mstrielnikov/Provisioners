mysql::db { 'mydb':
  user     => 'myuser',
  password => 'mypass',
  host     => 'localhost',
  grant    => ['ALL PRIVILEGES'],
  sql      => '/home/backup/mysql/mydb/backup.gz',
  import_cat_cmd => 'zcat',
  import_timeout => 900
}
