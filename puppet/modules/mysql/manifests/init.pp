class mysql 
{
    $mysqlPassword = "root"
 	$mysqlDatabase = "msisdn"
 

    package 
    { 
        "mysql-server":
            ensure  => present,
            require => Exec['apt-get update']
    }

    service 
    { 
        "mysql":
            enable => true,
            ensure => running,
            require => Package["mysql-server"],
    }

    exec 
    { 
		"set-mysql-password":
			unless => "mysqladmin -uroot -p$mysqlPassword status",
			command => "mysqladmin -uroot password $mysqlPassword create $mysqlDatabase",
			require => Service["mysql"],
    }

    exec 
    { 
		"set-mysql-database":
			command => "mysql -uroot -p$mysqlPassword $mysqlDatabase < /vagrant/project/info.sql",
			require => Service["mysql"],
    }

}