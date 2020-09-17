  firewall { 'minecraft':
    dport  => 25565,
    proto  => tcp,
    action => accept,
  }

