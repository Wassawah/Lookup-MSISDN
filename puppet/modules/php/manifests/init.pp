class php {
   $php = ["php5-mysql"]

    package 
    { 
        $php:
            notify  => Service["apache2"], 
            ensure  => present,
            require => Exec['apt-get update']
    }

	package { "python-software-properties":
        ensure => present,
    }

    exec { 'add-apt-repository ppa:ondrej/php5':
        command => '/usr/bin/add-apt-repository ppa:ondrej/php5',
        notify  => Service["apache2"], 
        require => Package["python-software-properties"],
    }

    exec { 'apt-get update for ondrej/php5':
    	command => '/usr/bin/apt-get update',
    	before => Package[$php],
    	require => Exec['add-apt-repository ppa:ondrej/php5'],
    }

}