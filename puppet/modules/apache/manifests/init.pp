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

  exec { "rewrite" :
    command => "a2enmod rewrite",
    notify => Service[apache2]
  }
  file { "/etc/apache2/apache2.conf":
    notify => Service["apache2"],
    ensure => "present",
    mode => "0644",
    group => "root",
    source => "puppet:///modules/apache/apache2.conf",
    require => Package["apache2"],
  }

}