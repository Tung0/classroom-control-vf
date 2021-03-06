class memcachesvc {
  package {'memcached':
    ensure => present,
  }
  file {'/etc/sysconfig/memcached':
    ensure => file,
    source => 'puppet:///memcached/memcached',
    require => Package['memcached'],
  }
  service {'memcached':
    ensure => running,
    enable => true,
    subscribe => File['/etc/sysconfig/memcached'],
  }
}
