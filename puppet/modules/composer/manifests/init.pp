class composer {

	package { "curl":
		ensure => installed,
	}

	exec { 'composer_install':
		command => 'curl -sS https://getcomposer.org/installer | php && sudo mv composer.phar /usr/local/bin/composer',
		path    => '/usr/bin:/usr/sbin',
		require => Package['curl'],
	}

	exec { 'composer_update':
		command => 'composer install -d /var/www/html/',
		timeout => 0,
		require => [ Package['curl'], Exec['existHTTP'] ]
	}
}