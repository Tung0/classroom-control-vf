class users {
  users::managed_user{'mdt':
  }
  user { 'fundamentals':
    ensure => present,
  }
}  
