# Class: kibana
#
# This module manages kibana
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# [Remember: No empty lines between comments and class definition]
class kibana($elasticsearch_server ="localhost:9200")
{

  package {"kibana":
    ensure => present;
  }

  file { '/etc/apache2/conf.d/kibana.conf':
    ensure => 'file',
    group  => '0',
    mode   => '644',
    owner  => '0',
    source => 'puppet:///modules/kibana/kibana.conf',
  }

  file { '/var/www/kibana/':
    ensure => 'directory',
    group  => '0',
    mode   => '777',
    owner  => '0',
  }

  file { '/var/www/kibana/config.php':
    ensure   => 'file',
    group    => '0',
    mode     => '664',
    owner    => '0',
    content  => template('kibana/config.php.erb')
  }

}
