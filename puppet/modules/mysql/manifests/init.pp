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
			command => "mysqladmin -uroot password $mysqlPassword",
            logoutput => on_failure,
			require => Service["mysql"],
    }
    
    exec 
    { 
        "create-mysql-password":
            unless => "mysql -uroot -p$mysqlPassword $mysqlDatabase",
            command => "mysql -uroot -p$mysqlPassword -e 'create database $mysqlDatabase'",
            logoutput => on_failure,
            require => [Service["mysql"], Exec['set-mysql-password']]
    }

    exec 
    { 
		"set-mysql-database":
			command => "mysql -uroot -p$mysqlPassword $mysqlDatabase < /vagrant/project/database.sql",
            onlyif  => "test -f /vagrant/project/database.sql",
			require => [Service["mysql"], Exec['create-mysql-password']],
            notify  => Exec['remove_DB']   
    }
    exec { 
        "remove_DB":
            onlyif  => "test -f /vagrant/project/database.sql",
            command => "mv /vagrant/project/database.sql /vagrant/project/database.backup" 
    }


}