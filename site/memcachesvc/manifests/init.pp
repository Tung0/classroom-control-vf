class memcachesvc {
  package { 'memcached':
    ensure => present,
    before => File['/etc/sysconfig/memcached'],
  }
  file { '/etc/sysconfig/memcached' :
    ensure => file,
    source => puppet:///modules/memcached/memcached,
    requires => Package['memcached'],
  }
  service { 'memcached':
    ensure => running,
    enable => true,
    subscribe => File['/etc/sysconfig/memcached'],
  }
}
