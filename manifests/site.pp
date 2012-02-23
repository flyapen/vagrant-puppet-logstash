node "logstash" {

  include apt

  exec { "apt-key":
    command => "/usr/bin/wget -q http://aeolus.ugent.be/debian/aeolus.gpg -O -|/usr/bin/apt-key add -";
  }

  apt::source { "aeolus":
    location => "http://aeolus.ugent.be/debian/",
    release => "squeeze",
    repos => "main"
  }

  exec { "apt-update":
    command     => "/usr/bin/apt-get update",
  }

  service {"iptables":
    enable => false,
    ensure => stopped;
  }

  package { 'openjdk-6-jdk':
    ensure => 'installed';
  }

  package { 'tanuki':
    ensure => '3.5.13',
   }

  class {'elasticsearch':
    version => '0.18.7',
  }

  include rabbitmq
  include grok 
  include logstash::common 
  class {'logstash::shipper':
    verbose => 'yes',
  }

  class {'logstash::server':
    verbose => 'yes',
  }
  include logstash::web

  service {"apache2":  ensure => running; }
  include kibana

}
