class users {
  user::managed_user{'mdt'}
  user { 'fundamentals':
    ensure => present,
  }
}  
