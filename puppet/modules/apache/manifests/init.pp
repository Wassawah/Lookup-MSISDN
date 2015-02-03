# vagrant/puppet/modules/apache/manifests/init.pp
class apache {

  # install apache2 package
  package { 'apache2':
    ensure => present,
    require => Exec['apt-get update'],
  }

  # ensure apache2 service is running
  service { 'apache2':
    ensure => running,
    require => Package['apache2'],
  }

  package {'libapache2-mod-php5':
    ensure => present,
    require => Exec['apt-get update']
  }

}