class nginx {

  case $::osfamily {
    'redhat','debian' :{      
      $package = 'nginx'      
      $owner   = 'root'      
      $group   = 'root'      
      $docroot = '/var/www'      
      $confdir = '/etc/nginx'      
      $logdir  = '/var/log/nginx'
    }    
    'windows' :{      
      $package = 'nginx-service'      
      $owner   = 'Administrator'      
      $group   = 'Administrators'      
      $docroot = 'C:/ProgramData/nginx/html'      
      $confdir = 'C:/ProgramData/nginx'      
      $logdir  = 'C:/ProgramData/nginx/logs'    
    }    
    default :{
      fail("Module ${module_name} is not supported on ${::osfamily}")    
    }  
  
  File {
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0664',
  }
  
  package {'nginx':
     ensure => present,
  }
  
  file {'/var/www':
    ensure => directory,
    mode   => '0775',
  }  
  
  file {'/var/www/index.html':
    source => 'puppet:///modules/nginx/index.html',  
  }  
  
  file {'/etc/nginx/nginx.conf':
    source  => 'puppet:///modules/nginx/nginx.conf',
    require => Package['nginx'],
    notify  => Service['nginx'],  
  }  
  
  file {'/etc/nginx/conf.d':
    ensure => directory,
    mode   => '0775',
  }  
  
  file {'/etc/nginx/conf.d/default.conf':
    source  => 'puppet:///modules/nginx/default.conf',
    require => Package['nginx'],
    notify  => Service['nginx'],  
  }  
  
  service {'nginx':
    ensure  => running,
    enable  => true,
  } 
}
