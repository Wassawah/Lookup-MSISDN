# default path
Exec {
	path => ["/usr/bin", "/bin", "/usr/sbin", "/sbin", "/usr/local/bin", "/usr/local/sbin"]
}

include build
include apache
include mysql
include php
include composer

class build {
	
    package 
    { 
       "build-essential":
           ensure  => present,
           require => Exec['apt-get update']
    }

	exec 
	{ 
		'apt-get update':
	    command => '/usr/bin/apt-get update'
	}

     exec {'existHTTP':
	    onlyif          => "test -f /var/www/html",
	    path            => ['/usr/bin','/usr/sbin','/bin','/sbin'],
	    notify          => File['/var/www/html'],         
	  }

	file { '/var/www/html':
		ensure => 'link',
		target => '/vagrant/project/',
		force => true,
	}
}